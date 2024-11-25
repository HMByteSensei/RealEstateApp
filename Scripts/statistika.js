document.addEventListener("DOMContentLoaded", function () {
  let periodiCounter = 1;
  let rasponiCijenaCounter = 1;

  window.dodajPeriod = function () {
    periodiCounter++;
    const periodiDiv = document.getElementById("periodi");
    const noviPeriod = document.createElement("div");
    noviPeriod.innerHTML = `
              <label>Od: <input type="number" id="periodOd${periodiCounter}"></label>
              <label>Do: <input type="number" id="periodDo${periodiCounter}"></label>
          `;
    periodiDiv.appendChild(noviPeriod);
  };

  window.dodajRasponCijena = function () {
    rasponiCijenaCounter++;
    const rasponiCijenaDiv = document.getElementById("rasponiCijena");
    const noviRaspon = document.createElement("div");
    noviRaspon.innerHTML = `
              <label>Od: <input type="number" id="cijenaOd${rasponiCijenaCounter}"></label>
              <label>Do: <input type="number" id="cijenaDo${rasponiCijenaCounter}"></label>
          `;
    rasponiCijenaDiv.appendChild(noviRaspon);
  };

  window.iscrtajHistogram = function () {
    const periodi = [];
    for (let i = 1; i <= periodiCounter; i++) {
      const od = document.getElementById(`periodOd${i}`).value;
      const doPeriod = document.getElementById(`periodDo${i}`).value;
      if (od && doPeriod) {
        periodi.push({ od: parseInt(od), do: parseInt(doPeriod) });
      }
    }

    const rasponiCijena = [];
    for (let i = 1; i <= rasponiCijenaCounter; i++) {
      const od = document.getElementById(`cijenaOd${i}`).value;
      const doCijena = document.getElementById(`cijenaDo${i}`).value;
      if (od && doCijena) {
        rasponiCijena.push({ od: parseInt(od), do: parseInt(doCijena) });
      }
    }

    console.log("Periodi:", periodi);
    console.log("Rasponi cijena:", rasponiCijena);

    const statistika = StatistikaNekretnina();
    statistika.init(listaNekretnina, listaKorisnika);
    const histogramData = statistika.histogramCijena(periodi, rasponiCijena);

    console.log("Histogram Data:", histogramData);

    const histogramiDiv = document.getElementById("histogrami");
    histogramiDiv.innerHTML = ""; // Očisti prethodne grafikone

    periodi.forEach((period, indeksPerioda) => {
      const canvas = document.createElement("canvas");
      canvas.id = `histogram${indeksPerioda}`;
      histogramiDiv.appendChild(canvas);

      const data = {
        labels: rasponiCijena.map((raspon) => `${raspon.od} - ${raspon.do}`),
        datasets: [
          {
            label: `Period ${period.od} - ${period.do}`,
            data: histogramData
              .filter((item) => item.indeksPerioda === indeksPerioda)
              .map((item) => item.brojNekretnina),
            backgroundColor: "rgba(75, 192, 192, 0.2)",
            borderColor: "rgba(75, 192, 192, 1)",
            borderWidth: 1,
          },
        ],
      };

      const config = {
        type: "bar",
        data: data,
        options: {
          scales: {
            y: {
              beginAtZero: true,
            },
          },
        },
      };

      new Chart(document.getElementById(`histogram${indeksPerioda}`), config);
    });
  };
});
