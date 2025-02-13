module.exports = (sequelize, DataTypes) => {
  const Ponuda = sequelize.define('Ponuda', {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true,
    },
    tekst: {
      type: DataTypes.TEXT,
      allowNull: false,
    },
    cijenaPonude: {
      type: DataTypes.FLOAT,
      allowNull: false,
    },
    datumPonude: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    odbijenaPonuda: {
      type: DataTypes.BOOLEAN,
      defaultValue: false,
    },
  });

  return Ponuda;
};