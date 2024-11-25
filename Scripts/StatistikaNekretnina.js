let StatistikaNekretnina = function () {
  let spisakNekretnina = SpisakNekretnina();

  // Implementacija metoda
  let init = function (listaNekretnina, listaKorisnika) {
    spisakNekretnina.init(listaNekretnina, listaKorisnika);
  };

  let prosjecnaKvadratura = function (kriterij) {
    let filtriraneNekretnine = spisakNekretnina.filtrirajNekretnine(kriterij);
    if (filtriraneNekretnine.length === 0) return 0;
    let ukupnaKvadratura = filtriraneNekretnine.reduce(
      (sum, nekretnina) => sum + nekretnina.kvadratura,
      0
    );
    return ukupnaKvadratura / filtriraneNekretnine.length;
  };

  let outlier = function (kriterij, nazivSvojstva) {
    let filtriraneNekretnine = spisakNekretnina.filtrirajNekretnine(kriterij);
    if (filtriraneNekretnine.length === 0) return null;
    let prosjecnaVrijednost =
      filtriraneNekretnine.reduce(
        (sum, nekretnina) => sum + nekretnina[nazivSvojstva],
        0
      ) / filtriraneNekretnine.length;
    let maxOdstupanje = -Infinity;
    let outlierNekretnina = null;
    filtriraneNekretnine.forEach((nekretnina) => {
      let odstupanje = Math.abs(
        nekretnina[nazivSvojstva] - prosjecnaVrijednost
      );
      if (odstupanje > maxOdstupanje) {
        maxOdstupanje = odstupanje;
        outlierNekretnina = nekretnina;
      }
    });
    return outlierNekretnina;
  };

  let mojeNekretnine = function (korisnik) {
    let nekretnineSaUpitima = spisakNekretnina.listaNekretnina.filter(
      (nekretnina) => {
        return (
          nekretnina.upiti &&
          nekretnina.upiti.some((upit) => upit.korisnik === korisnik)
        );
      }
    );
    nekretnineSaUpitima.sort((a, b) => b.upiti.length - a.upiti.length);
    return nekretnineSaUpitima;
  };

  let histogramCijena = function (periodi, rasponiCijena) {
    let rezultat = [];
    periodi.forEach((period, indeksPerioda) => {
      let nekretnineUPeriodu = spisakNekretnina.listaNekretnina.filter(
        (nekretnina) =>
          new Date(nekretnina.datum_objave).getFullYear() >= period.od &&
          new Date(nekretnina.datum_objave).getFullYear() <= period.do
      );
      rasponiCijena.forEach((raspon, indeksRasponaCijena) => {
        let brojNekretnina = nekretnineUPeriodu.filter(
          (nekretnina) =>
            nekretnina.cijena >= raspon.od && nekretnina.cijena <= raspon.do
        ).length;
        rezultat.push({
          indeksPerioda: indeksPerioda,
          indeksRasponaCijena: indeksRasponaCijena,
          brojNekretnina: brojNekretnina,
        });
      });
    });
    return rezultat;
  };

  return {
    init: init,
    prosjecnaKvadratura: prosjecnaKvadratura,
    outlier: outlier,
    mojeNekretnine: mojeNekretnine,
    histogramCijena: histogramCijena,
  };
};
