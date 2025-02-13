const { Sequelize, DataTypes } = require('sequelize');
const bcrypt = require('bcrypt');

// Povezivanje sa bazom
const sequelize = new Sequelize('wt24', 'root', 'password', {
  host: 'localhost',
  dialect: 'mysql',
  logging: false,
});

const Korisnik = require('../models/Korisnik')(sequelize, DataTypes);
const Nekretnina = require('../models/Nekretnina')(sequelize, DataTypes);
const Upit = require('../models/Upit')(sequelize, DataTypes);
const Zahtjev = require('../models/Zahtjev')(sequelize, DataTypes);
const Ponuda = require('../models/Ponuda')(sequelize, DataTypes);

// Definiranje relacija
Korisnik.hasMany(Upit, { foreignKey: 'korisnikId' });
Upit.belongsTo(Korisnik, { foreignKey: 'korisnikId' });

Korisnik.hasMany(Zahtjev, { foreignKey: 'korisnikId' });
Zahtjev.belongsTo(Korisnik, { foreignKey: 'korisnikId' });

Korisnik.hasMany(Ponuda, { foreignKey: 'korisnikId' });
Ponuda.belongsTo(Korisnik, { foreignKey: 'korisnikId' });

Nekretnina.hasMany(Upit, { foreignKey: 'nekretninaId' });
Upit.belongsTo(Nekretnina, { foreignKey: 'nekretninaId' });

Nekretnina.hasMany(Zahtjev, { foreignKey: 'nekretninaId' });
Zahtjev.belongsTo(Nekretnina, { foreignKey: 'nekretninaId' });

Nekretnina.hasMany(Ponuda, { foreignKey: 'nekretninaId' });
Ponuda.belongsTo(Nekretnina, { foreignKey: 'nekretninaId' });

Ponuda.hasMany(Ponuda, { as: 'vezanePonude', foreignKey: 'parentPonudaId' });
Ponuda.belongsTo(Ponuda, { as: 'parentPonuda', foreignKey: 'parentPonudaId' });

Nekretnina.prototype.getInteresovanja = async function () {
  const upiti = await Upit.findAll({ where: { nekretninaId: this.id } });
  const zahtjevi = await Zahtjev.findAll({ where: { nekretninaId: this.id } });
  const ponude = await Ponuda.findAll({ where: { nekretninaId: this.id } });
  return [...upiti, ...zahtjevi, ...ponude];
};

const syncDatabase = async () => {
  try {
    await sequelize.authenticate();
    console.log('Uspješno povezivanje na bazu podataka!');
    await sequelize.sync({ alter: true }); // Kreira tabele prema modelima ako ne postoje
    console.log('Tabele su uspješno kreirane!');

    const adminPassword = await bcrypt.hash('admin', 10);
    const userPassword = await bcrypt.hash('user', 10);

    await Korisnik.findOrCreate({
      where: { email: 'admin' },
      defaults: { ime: 'Admin', prezime: 'Admin', email: 'admin', password: adminPassword, admin: true }
    });

    await Korisnik.findOrCreate({
      where: { email: 'user' },
      defaults: { ime: 'User', prezime: 'User', email: 'user', password: userPassword, admin: false }
    });

    console.log('Korisnici su uspješno dodani!');
  } catch (error) {
    console.error('Greška prilikom povezivanja na bazu:', error);
  }
};

// Pokrenite sinkronizaciju baze podataka samo kada je potrebno
if (process.env.SYNC_DB === 'true') {
  syncDatabase();
}

module.exports = {
  sequelize,
  Korisnik,
  Nekretnina,
  Upit,
  Zahtjev,
  Ponuda
};