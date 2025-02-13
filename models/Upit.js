module.exports = (sequelize, DataTypes) => {
  const Upit = sequelize.define('Upit', {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true,
    },
    tekst: {
      type: DataTypes.TEXT,
      allowNull: false,
    },
  });

  return Upit;
};