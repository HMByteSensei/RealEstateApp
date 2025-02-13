const fs = require('fs').promises;
const path = require('path');
const { sequelize, Nekretnina, Upit } = require('./db');

async function populateNekretnine() {
  try {
    const data = await fs.readFile(path.join(__dirname, '..', 'data', 'nekretnine.json'), 'utf-8');
    const nekretnine = JSON.parse(data);

    for (const nekretnina of nekretnine) {
      const [createdNekretnina, created] = await Nekretnina.upsert({
        id: nekretnina.id,
        tip_nekretnine: nekretnina.tip_nekretnine,
        naziv: nekretnina.naziv,
        kvadratura: nekretnina.kvadratura,
        cijena: nekretnina.cijena,
        tip_grijanja: nekretnina.tip_grijanja,
        lokacija: nekretnina.lokacija,
        godina_izgradnje: nekretnina.godina_izgradnje,
        datum_objave: new Date(nekretnina.datum_objave.split('.').reverse().join('-')),
        opis: nekretnina.opis,
      });

      for (const upit of nekretnina.upiti) {
        await Upit.create({
          tekst: upit.tekst_upita,
          korisnikId: upit.korisnik_id,
          nekretninaId: createdNekretnina.id,
        });
      }
    }

    console.log('Nekretnine i upiti su uspješno dodani u bazu podataka!');
  } catch (error) {
    console.error('Error populating nekretnine:', error);
  } finally {
    // Ensure the connection is closed after all operations are complete
    try {
      await sequelize.close();
      console.log('Konekcija na bazu podataka je uspješno zatvorena.');
    } catch (closeError) {
      console.error('Greška prilikom zatvaranja konekcije na bazu:', closeError);
    }
  }
}

populateNekretnine();