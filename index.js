const express = require('express');
const session = require('express-session');
const path = require('path');
const fs = require('fs').promises; // Using asynchronous API for file read and write
const bcrypt = require('bcrypt');

const { sequelize, Korisnik, Nekretnina, Upit, Zahtjev, Ponuda } = require('./database/db');

const app = express();
const PORT = 3000;


app.use(session({
  secret: 'tajna sifra',
  resave: true,
  saveUninitialized: true
}));

app.use(express.static(__dirname + '/public'));
// Enable JSON parsing without body-parser
app.use(express.json());

const loginAttempts = {};

function logAttempt(username, status) {
  const dateTime = new Date().toISOString();
  const logMessage = `[${dateTime}] - username: "${username}" - status: "${status}"\n`;
  fs.appendFile('prijave.txt', logMessage, (err) => {
    if (err) console.error('Greška prilikom pisanja u prijave.txt:', err);
  });
}

app.post('/login', async (req, res) => {
  const { username, password } = req.body;

  if (!loginAttempts[username]) {
    loginAttempts[username] = { count: 0, lastAttempt: null };
  }

  const currentTime = Date.now();
  const userAttempts = loginAttempts[username];

  if (userAttempts.count >= 3 && currentTime - userAttempts.lastAttempt < 60000) {
    logAttempt(username, 'neuspješno');
    return res.status(429).json({ greska: 'Previse neuspjesnih pokusaja. Pokusajte ponovo za 1 minutu.' });
  }

  try {
    const korisnik = await Korisnik.findOne({ where: { email: username } });

    if (korisnik) {
      const isPasswordMatched = await bcrypt.compare(password, korisnik.password);

      if (isPasswordMatched) {
        req.session.username = korisnik.email;
        userAttempts.count = 0;
        logAttempt(username, 'uspješno');
        return res.json({ poruka: 'Uspješna prijava' });
      }
    }

    userAttempts.count += 1;
    userAttempts.lastAttempt = currentTime;
    logAttempt(username, 'neuspješno');
    res.status(401).json({ greska: 'Neispravno korisničko ime ili lozinka' });
  } catch (error) {
    console.error('Error during login:', error);
    res.status(500).json({ greska: 'Internal Server Error' });
  }
});

// Nova ruta: /nekretnine/top5
app.get('/nekretnine/top5', async (req, res) => {
  const lokacija = req.query.lokacija;

  try {
    // Pronađi nekretnine prema lokaciji i sortiraj prema datumu objave (najnoviji prvo)
    const nekretnine = await Nekretnina.findAll({
      where: { lokacija },
      order: [['datum_objave', 'DESC']],
      limit: 5
    });

    res.status(200).json(nekretnine);
  } catch (error) {
    console.error('Error fetching top 5 properties:', error);
    res.status(500).json({ greska: 'Internal Server Error' });
  }
});

/* ---------------- SERVING HTML -------------------- */

// Async function for serving html files
async function serveHTMLFile(req, res, fileName) {
  const htmlPath = path.join(__dirname, 'public/HTML', fileName);
  try {
    const content = await fs.readFile(htmlPath, 'utf-8');
    res.send(content);
  } catch (error) {
    console.error('Error serving HTML file:', error);
    res.status(500).json({ greska: 'Internal Server Error' });
  }
}

// Array of HTML files and their routes
const routes = [
  { route: '/nekretnine.html', file: 'nekretnine.html' },
  { route: '/detalji.html', file: 'detalji.html' },
  { route: '/meni.html', file: 'meni.html' },
  { route: '/prijava.html', file: 'prijava.html' },
  { route: '/profil.html', file: 'profil.html' },
  { route: '/vijesti.html', file: 'vijesti.html' },
  { route: '/mojiUpiti.html', file: 'mojiUpiti.html' },
  { route: '/topNekretnine.html', file: 'topNekretnine.html' }
  // Practical for adding more .html files as the project grows
];

// Loop through the array so HTML can be served
routes.forEach(({ route, file }) => {
  app.get(route, async (req, res) => {
    await serveHTMLFile(req, res, file);
  });
});

/* ----------- SERVING OTHER ROUTES --------------- */

// Async function for reading json data from data folder 
async function readJsonFile(filename) {
  const filePath = path.join(__dirname, 'data', `${filename}.json`);
  try {
    const rawdata = await fs.readFile(filePath, 'utf-8');
    return JSON.parse(rawdata);
  } catch (error) {
    throw error;
  }
}

// Async function for reading json data from data folder 
async function saveJsonFile(filename, data) {
  const filePath = path.join(__dirname, 'data', `${filename}.json`);
  try {
    await fs.writeFile(filePath, JSON.stringify(data, null, 2), 'utf-8');
  } catch (error) {
    throw error;
  }
}

/*
Checks if the user exists and if the password is correct based on korisnici.json data. 
If the data is correct, the username is saved in the session and a success message is sent.
*/
app.post('/login', async (req, res) => {
  const { username, password } = req.body;

  try {
    const korisnik = await Korisnik.findOne({ where: { email: username } });

    if (korisnik) {
      const isPasswordMatched = await bcrypt.compare(password, korisnik.password);

      if (isPasswordMatched) {
        req.session.username = korisnik.email;
        return res.json({ poruka: 'Uspješna prijava' });
      }
    }

    res.json({ poruka: 'Neuspješna prijava' });
  } catch (error) {
    console.error('Error during login:', error);
    res.status(500).json({ greska: 'Internal Server Error' });
  }
});

/*
Delete everything from the session.
*/
app.post('/logout', (req, res) => {
  // Check if the user is authenticated
  if (!req.session.username) {
    // User is not logged in
    return res.status(401).json({ greska: 'Neautorizovan pristup' });
  }

  // Clear all information from the session
  req.session.destroy((err) => {
    if (err) {
      console.error('Error during logout:', err);
      res.status(500).json({ greska: 'Internal Server Error' });
    } else {
      res.status(200).json({ poruka: 'Uspješno ste se odjavili' });
    }
  });
});

/*
Returns currently logged user data. First takes the username from the session and grabs other data
from the .json file.
*/
app.get('/korisnik', async (req, res) => {
  // Check if the username is present in the session
  if (!req.session.username) {
    // User is not logged in
    return res.status(401).json({ greska: 'Neautorizovan pristup' });
  }

  // User is logged in, fetch additional user data
  const username = req.session.username;

  try {
    // Find the user by username in the database
    const korisnik = await Korisnik.findOne({ where: { email: username } });

    if (!korisnik) {
      // User not found (should not happen if users are correctly managed)
      return res.status(401).json({ greska: 'Neautorizovan pristup' });
    }

    // Send user data
    const userData = {
      id: korisnik.id,
      ime: korisnik.ime,
      prezime: korisnik.prezime,
      username: korisnik.email,
      password: korisnik.password // Trebam izuzeti pass zbog sigurnosti, al nek stoji za sad
    };

    res.status(200).json(userData);
  } catch (error) {
    console.error('Error fetching user data:', error);
    res.status(500).json({ greska: 'Internal Server Error' });
  }
});

/*
Allows logged user to make a request for a property
*/
app.post('/upit', async (req, res) => {
  // Check if the user is authenticated
  if (!req.session.username) {
    // User is not logged in
    return res.status(401).json({ greska: 'Neautorizovan pristup' });
  }

  // Get data from the request body
  const { nekretnina_id, tekst_upita } = req.body;

  try {
    // Find the user by username in the database
    const korisnik = await Korisnik.findOne({ where: { email: req.session.username } });

    // Check if the property with nekretnina_id exists
    const nekretnina = await Nekretnina.findByPk(nekretnina_id);

    if (!nekretnina) {
      // Property not found
      return res.status(400).json({ greska: `Nekretnina sa id-em ${nekretnina_id} ne postoji` });
    }

    // Check if the user has already made more than 3 queries for the same property
    const userQueries = await Upit.findAll({ where: { korisnikId: korisnik.id, nekretninaId: nekretnina_id } });

    if (userQueries.length >= 3) {
      return res.status(429).json({ greska: 'Previse upita za istu nekretninu.' });
    }

    // Add a new query to the database
    const upit = await Upit.create({ tekst: tekst_upita, korisnikId: korisnik.id, nekretninaId: nekretnina_id });

    res.status(200).json({ poruka: 'Upit je uspješno dodan', upit });
  } catch (error) {
    console.error('Error processing query:', error);
    res.status(500).json({ greska: 'Internal Server Error' });
  }
});

app.get('/upiti/moji', async (req, res) => {
  // Check if the user is authenticated
  if (!req.session.username) {
    return res.status(401).json({ greska: 'Neautorizovan pristup' });
  }

  try {
    // Find the user by username in the database
    const korisnik = await Korisnik.findOne({ where: { email: req.session.username } });

    if (!korisnik) {
      return res.status(401).json({ greska: 'Neautorizovan pristup' });
    }

    // Find all queries made by the logged-in user and include related properties
    const userQueries = await Upit.findAll({
      where: { korisnikId: korisnik.id },
      include: [{ model: Nekretnina, attributes: ['id', 'naziv'] }]
    });

    if (userQueries.length === 0) {
      return res.status(404).json([]);
    }

    // Format the response to include property details
    const formattedQueries = userQueries.map(upit => ({
      id_nekretnine: upit.Nekretnina.id,
      naziv_nekretnine: upit.Nekretnina.naziv,
      tekst_upita: upit.tekst
    }));

    res.status(200).json(formattedQueries);
  } catch (error) {
    console.error('Error fetching user queries:', error);
    res.status(500).json({ greska: 'Internal Server Error' });
  }
});

app.get('/nekretnina/details', async (req, res) => {
  const nekretninaId = req.query.id;

  try {
    const nekretnina = await Nekretnina.findByPk(nekretninaId);

    if (nekretnina) {
      res.status(200).json(nekretnina);
    } else {
      res.status(404).json({ greska: 'Nekretnina nije pronađena' });
    }
  } catch (error) {
    console.error('Error fetching property details:', error);
    res.status(500).json({ greska: 'Internal Server Error' });
  }
});



app.get('/nekretnina/:id', async (req, res) => {
  const { id } = req.params;

  try {
    // Find the property with the given id in the database
    const nekretnina = await Nekretnina.findByPk(id, {
      include: [{ model: Upit, limit: 3, order: [['createdAt', 'DESC']] }]
    });

    if (!nekretnina) {
      // Property not found
      return res.status(404).json({ greska: `Nekretnina sa id-em ${id} ne postoji` });
    }

    // Return the property details along with the last 3 queries
    res.status(200).json(nekretnina);
  } catch (error) {
    console.error('Error fetching property details:', error);
    res.status(500).json({ greska: 'Internal Server Error' });
  }
});

app.get('/nekretnina/:id/upiti', async (req, res) => {
  const { id } = req.params;

  try {
    const nekretnina = await Nekretnina.findByPk(id);
    if (!nekretnina) {
      return res.status(404).json({ greska: `Nekretnina sa id-em ${id} ne postoji` });
    }

    const upiti = await Upit.findAll({ where: { nekretninaId: id } });

    res.status(200).json(upiti);
  } catch (error) {
    console.error('Error fetching upiti:', error);
    res.status(500).json({ greska: 'Internal Server Error' });
  }
});

app.get('/next/upiti/nekretnina/:id', async (req, res) => {
  const { id } = req.params;

  try {
    const nekretnina = await Nekretnina.findByPk(id);
    if (!nekretnina) {
      return res.status(404).json([]);
    }

    const allUpiti = await Upit.findAll({
      where: { nekretninaId: id },
      order: [['createdAt', 'DESC']]
    });

    const formattedUpiti = allUpiti.map(upit => ({
      korisnik_id: upit.korisnikId,
      tekst_upita: upit.tekst
    }));

    res.status(200).json(formattedUpiti);
  } catch (error) {
    console.error('Error fetching queries:', error);
    res.status(500).json({ greska: 'Internal Server Error' });
  }
});



/*
Updates any user field
*/
app.put('/korisnik', async (req, res) => {
  // Check if the user is authenticated
  if (!req.session.username) {
    // User is not logged in
    return res.status(401).json({ greska: 'Neautorizovan pristup' });
  }

  // Get data from the request body
  const { ime, prezime, username, password } = req.body;

  try {
    // Find the user by username in the database
    const korisnik = await Korisnik.findOne({ where: { email: req.session.username } });

    if (!korisnik) {
      // User not found (should not happen if users are correctly managed)
      return res.status(401).json({ greska: 'Neautorizovan pristup' });
    }

    // Update user data with the provided values
    if (ime) korisnik.ime = ime;
    if (prezime) korisnik.prezime = prezime;
    if (username) korisnik.email = username;
    if (password) {
      // Hash the new password
      const hashedPassword = await bcrypt.hash(password, 10);
      korisnik.password = hashedPassword;
    }

    // Save the updated user data to the database
    await korisnik.save();
    res.status(200).json({ poruka: 'Podaci su uspješno ažurirani' });
  } catch (error) {
    console.error('Error updating user data:', error);
    res.status(500).json({ greska: 'Internal Server Error' });
  }
});

/*
Returns all properties from the file.
*/
app.get('/nekretnine', async (req, res) => {
  try {
    const nekretnineData = await readJsonFile('nekretnine');
    res.json(nekretnineData);
  } catch (error) {
    console.error('Error fetching properties data:', error);
    res.status(500).json({ greska: 'Internal Server Error' });
  }
});

/* ----------------- MARKETING ROUTES ----------------- */

// Route that increments value of pretrage for one based on list of ids in nizNekretnina
app.post('/marketing/nekretnine', async (req, res) => {
  const { nizNekretnina } = req.body;

  try {
    // Load JSON data
    let preferencije = await readJsonFile('preferencije');

    // Check format
    if (!preferencije || !Array.isArray(preferencije)) {
      console.error('Neispravan format podataka u preferencije.json.');
      res.status(500).json({ error: 'Internal Server Error' });
      return;
    }

    // Init object for search
    preferencije = preferencije.map((nekretnina) => {
      nekretnina.pretrage = nekretnina.pretrage || 0;
      return nekretnina;
    });

    // Update atribute pretraga
    nizNekretnina.forEach((id) => {
      const nekretnina = preferencije.find((item) => item.id === id);
      if (nekretnina) {
        nekretnina.pretrage += 1;
      }
    });

    // Save JSON file
    await saveJsonFile('preferencije', preferencije);

    res.status(200).json({});
  } catch (error) {
    console.error('Greška prilikom čitanja ili pisanja JSON datoteke:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

app.post('/marketing/nekretnina/:id', async (req, res) => {
  const { id } = req.params;

  try {
    // Read JSON 
    const preferencije = await readJsonFile('preferencije');

    // Finding the needed objects based on id
    const nekretninaData = preferencije.find((item) => item.id === parseInt(id, 10));

    if (nekretninaData) {
      // Update clicks
      nekretninaData.klikovi = (nekretninaData.klikovi || 0) + 1;

      // Save JSON file
      await saveJsonFile('preferencije', preferencije);

      res.status(200).json({ success: true, message: 'Broj klikova ažuriran.' });
    } else {
      res.status(404).json({ error: 'Nekretnina nije pronađena.' });
    }
  } catch (error) {
    console.error('Greška prilikom čitanja ili pisanja JSON datoteke:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

app.post('/marketing/osvjezi/pretrage', async (req, res) => {
  const { nizNekretnina } = req.body || { nizNekretnina: [] };

  try {
    // Read JSON 
    const preferencije = await readJsonFile('preferencije');

    // Finding the needed objects based on id
    const promjene = nizNekretnina.map((id) => {
      const nekretninaData = preferencije.find((item) => item.id === id);
      return { id, pretrage: nekretninaData ? nekretninaData.pretrage : 0 };
    });

    res.status(200).json({ nizNekretnina: promjene });
  } catch (error) {
    console.error('Greška prilikom čitanja ili pisanja JSON datoteke:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

app.post('/marketing/osvjezi/klikovi', async (req, res) => {
  const { nizNekretnina } = req.body || { nizNekretnina: [] };

  try {
    // Read JSON 
    const preferencije = await readJsonFile('preferencije');

    // Finding the needed objects based on id
    const promjene = nizNekretnina.map((id) => {
      const nekretninaData = preferencije.find((item) => item.id === id);
      return { id, klikovi: nekretninaData ? nekretninaData.klikovi : 0 };
    });

    res.status(200).json({ nizNekretnina: promjene });
  } catch (error) {
    console.error('Greška prilikom čitanja ili pisanja JSON datoteke:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

app.get('/nekretnina/:id/zahtjevi', async (req, res) => {
  const { id } = req.params;

  try {
    const nekretnina = await Nekretnina.findByPk(id);
    if (!nekretnina) {
      return res.status(404).json({ greska: `Nekretnina sa id-em ${id} ne postoji` });
    }

    const zahtjevi = await Zahtjev.findAll({ where: { nekretninaId: id } });

    let korisnik = null;
    let isAdmin = false;

    if (req.session.username) {
      korisnik = await Korisnik.findOne({ where: { email: req.session.username } });
      isAdmin = korisnik && korisnik.admin;
    }

    const formattedZahtjevi = zahtjevi.map(zahtjev => {
      if (isAdmin || (korisnik && zahtjev.korisnikId === korisnik.id)) {
        return zahtjev;
      } else {
        const { ...rest } = zahtjev.toJSON();
        return rest;
      }
    });

    res.status(200).json(formattedZahtjevi);
  } catch (error) {
    console.error('Error fetching zahtjevi:', error);
    res.status(500).json({ greska: 'Internal Server Error' });
  }
});

app.post('/nekretnina/:id/upit', async (req, res) => {
  const { id } = req.params;
  const { tekst_upita } = req.body;

  if (!req.session.username) {
    return res.status(401).json({ greska: 'Neautorizovan pristup' });
  }

  try {
    const korisnik = await Korisnik.findOne({ where: { email: req.session.username } });

    if (!korisnik) {
      return res.status(401).json({ greska: 'Neautorizovan pristup' });
    }

    const nekretnina = await Nekretnina.findByPk(id);

    if (!nekretnina) {
      return res.status(400).json({ greska: `Nekretnina sa id-em ${id} ne postoji` });
    }

    const noviUpit = await Upit.create({
      korisnikId: korisnik.id,
      nekretninaId: id,
      tekst: tekst_upita
    });

    res.status(201).json({ poruka: 'Upit je uspješno dodan', upit: noviUpit });
  } catch (error) {
    console.error('Error creating query:', error);
    res.status(500).json({ greska: 'Internal Server Error' });
  }
});

app.get('/nekretnina/:id/interesovanja', async (req, res) => {
  const { id } = req.params;

  try {
    // Find the property with the given id in the database
    const nekretnina = await Nekretnina.findByPk(id);

    if (!nekretnina) {
      // Property not found
      return res.status(404).json({ greska: `Nekretnina sa id-em ${id} ne postoji` });
    }

    // Get all interests (upiti, zahtjevi, ponude) related to the property
    const upiti = await Upit.findAll({ where: { nekretninaId: id } });
    const zahtjevi = await Zahtjev.findAll({ where: { nekretninaId: id } });
    const ponude = await Ponuda.findAll({ where: { nekretninaId: id } });

    let korisnik = null;
    let isAdmin = false;

    if (req.session.username) {
      korisnik = await Korisnik.findOne({ where: { email: req.session.username } });
      isAdmin = korisnik && korisnik.admin;
    }

    const formattedPonude = ponude.map(ponuda => {
      if (isAdmin || (ponuda.korisnikId && korisnik && (ponuda.korisnikId === korisnik.id || ponuda.parentPonudaId === korisnik.id))) {
        return ponuda;
      } else {
        const { cijena, ...rest } = ponuda.toJSON();
        return rest;
      }
    });

    const interesovanja = {
      upiti,
      zahtjevi,
      ponude: formattedPonude
    };

    res.status(200).json(interesovanja);
  } catch (error) {
    console.error('Error fetching property interests:', error);
    res.status(500).json({ greska: 'Internal Server Error' });
  }
});

app.get('/nekretnina/:id/ponude', async (req, res) => {
  const { id } = req.params;

  try {
    const nekretnina = await Nekretnina.findByPk(id);
    if (!nekretnina) {
      return res.status(404).json({ greska: `Nekretnina sa id-em ${id} ne postoji` });
    }

    const ponude = await Ponuda.findAll({ where: { nekretninaId: id } });

    res.status(200).json(ponude);
  } catch (error) {
    console.error('Error fetching ponude:', error);
    res.status(500).json({ greska: 'Internal Server Error' });
  }
});

app.post('/nekretnina/:id/ponuda', async (req, res) => {
  const { id } = req.params;
  const { tekst, cijenaPonude, datumPonude, idVezanePonude, odbijenaPonuda } = req.body;

  try {
    // Find the property with the given id in the database
    const nekretnina = await Nekretnina.findByPk(id);

    if (!nekretnina) {
      // Property not found
      return res.status(404).json({ greska: `Nekretnina sa id-em ${id} ne postoji` });
    }

    // Check if the user is authenticated
    if (!req.session.username) {
      return res.status(401).json({ greska: 'Neautorizovan pristup' });
    }

    // Find the user by username in the database
    const korisnik = await Korisnik.findOne({ where: { email: req.session.username } });

    if (!korisnik) {
      return res.status(401).json({ greska: 'Neautorizovan pristup' });
    }

    // Check if the related offer exists and if it has been rejected
    if (idVezanePonude) {
      const vezanaPonuda = await Ponuda.findByPk(idVezanePonude);
      if (!vezanaPonuda) {
        return res.status(400).json({ greska: 'Vezana ponuda ne postoji' });
      }
      if (vezanaPonuda.odbijenaPonuda) {
        return res.status(400).json({ greska: 'Ne možete dodati ponudu na odbijenu ponudu' });
      }
    }

    // Check if the user is allowed to create the offer
    const isAdmin = korisnik.admin;
    if (!isAdmin && idVezanePonude) {
      const vezanaPonuda = await Ponuda.findByPk(idVezanePonude);
      if (vezanaPonuda.korisnikId !== korisnik.id && vezanaPonuda.parentPonudaId !== korisnik.id) {
        return res.status(403).json({ greska: 'Ne možete odgovoriti na ovu ponudu' });
      }
    }

    // Create the new offer
    const novaPonuda = await Ponuda.create({
      tekst,
      cijenaPonude,
      datumPonude,
      odbijenaPonuda,
      nekretninaId: id,
      korisnikId: korisnik.id,
      parentPonudaId: idVezanePonude
    });

    res.status(201).json(novaPonuda);
  } catch (error) {
    console.error('Error creating offer:', error.message, error.stack);
    res.status(500).json({ greska: 'Internal Server Error' });
  }
});

app.get('/korisnik/admin', async (req, res) => {
  if (!req.session.username) {
    return res.status(401).json({ isAdmin: false });
  }

  try {
    const korisnik = await Korisnik.findOne({ where: { email: req.session.username } });
    if (!korisnik) {
      return res.status(401).json({ isAdmin: false });
    }

    res.status(200).json({ isAdmin: korisnik.admin });
  } catch (error) {
    console.error('Error checking admin status:', error);
    res.status(500).json({ isAdmin: false });
  }
});

app.post('/nekretnina/:id/zahtjev', async (req, res) => {
  const { id } = req.params;
  const { tekst, trazeniDatum } = req.body;

  try {
    // Find the property with the given id in the database
    const nekretnina = await Nekretnina.findByPk(id);

    if (!nekretnina) {
      // Property not found
      return res.status(404).json({ greska: `Nekretnina sa id-em ${id} ne postoji` });
    }

    // Check if the requested date is valid
    const currentDate = new Date();
    const requestedDate = new Date(trazeniDatum);
    if (requestedDate < currentDate) {
      return res.status(400).json({ greska: 'Traženi datum je neispravan' });
    }

    // Check if the user is authenticated
    if (!req.session.username) {
      return res.status(401).json({ greska: 'Neautorizovan pristup' });
    }

    // Find the user by username in the database
    const korisnik = await Korisnik.findOne({ where: { email: req.session.username } });

    if (!korisnik) {
      return res.status(401).json({ greska: 'Neautorizovan pristup' });
    }

    // Create the new request
    const noviZahtjev = await Zahtjev.create({
      tekst,
      trazeniDatum: requestedDate,
      nekretninaId: id,
      korisnikId: korisnik.id
    });

    res.status(201).json(noviZahtjev);
  } catch (error) {
    console.error('Error creating request:', error);
    res.status(500).json({ greska: 'Internal Server Error' });
  }
});

app.put('/nekretnina/:id/zahtjev/:zid', async (req, res) => {
  const { id, zid } = req.params;
  const { odobren, addToTekst } = req.body;

  try {
    // Check if the user is authenticated
    if (!req.session.username) {
      return res.status(401).json({ greska: 'Neautorizovan pristup' });
    }

    // Find the user by username in the database
    const korisnik = await Korisnik.findOne({ where: { email: req.session.username } });

    if (!korisnik || !korisnik.admin) {
      return res.status(403).json({ greska: 'Samo admin može odgovoriti na zahtjev' });
    }

    // Find the property with the given id in the database
    const nekretnina = await Nekretnina.findByPk(id);

    if (!nekretnina) {
      // Property not found
      return res.status(404).json({ greska: `Nekretnina sa id-em ${id} ne postoji` });
    }

    // Find the request with the given id in the database
    const zahtjev = await Zahtjev.findByPk(zid);

    if (!zahtjev) {
      // Request not found
      return res.status(404).json({ greska: `Zahtjev sa id-em ${zid} ne postoji` });
    }

    // Check if addToTekst is required and valid
    if (odobren === false && (!addToTekst || addToTekst.trim() === '')) {
      return res.status(400).json({ greska: 'addToTekst mora postojati ako je odobren=false' });
    }

    // Update the request
    zahtjev.odobren = odobren;
    if (addToTekst) {
      zahtjev.tekst += ` ODGOVOR ADMINA: ${addToTekst}`;
    } else if (odobren) {
      zahtjev.tekst += ` ODGOVOR ADMINA: Odobren`;
    }
    await zahtjev.save();

    res.status(200).json(zahtjev);
  } catch (error) {
    console.error('Error updating request:', error);
    res.status(500).json({ greska: 'Internal Server Error' });
  }
});

// Start server
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
