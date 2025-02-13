module.exports = (sequelize, DataTypes) => {
  const Korisnik = sequelize.define('Korisnik', {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true,
    },
    ime: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    prezime: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    email: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true,
    },
    password: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    admin: {
      type: DataTypes.BOOLEAN,
      defaultValue: false,
    },
  });

  Korisnik.associate = (models) => {
    Korisnik.hasMany(models.Upit, { foreignKey: 'korisnikId' });
    Korisnik.hasMany(models.Zahtjev, { foreignKey: 'korisnikId' });
    Korisnik.hasMany(models.Ponuda, { foreignKey: 'korisnikId' });
  };

  return Korisnik;
};