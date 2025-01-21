document.addEventListener("DOMContentLoaded", function () {
  const urlParams = new URLSearchParams(window.location.search);
  const lokacija = urlParams.get("lokacija");
  const lokacijaNaslov = document.getElementById("lokacija-naslov");
  const nekretnineContainer = document.getElementById("nekretnine-container");

  if (lokacija) {
      lokacijaNaslov.textContent = lokacija;

      PoziviAjax.getTop5Nekretnina(lokacija, (error, data) => {
          if (error) {
              console.error("Greška prilikom dohvatanja top 5 nekretnina:", error);
              nekretnineContainer.innerHTML = "<p>Greška prilikom dohvatanja nekretnina.</p>";
          } else {
              nekretnineContainer.innerHTML = "";
              data.forEach(nekretnina => {
                  const nekretninaElement = document.createElement("div");
                  nekretninaElement.classList.add("nekretnina");
                  nekretninaElement.id = `${nekretnina.id}`;

                  const slikaElement = document.createElement("img");
                  slikaElement.classList.add("slika-nekretnine");
                  slikaElement.src = `../Resources/${nekretnina.id}.jpg`;
                  slikaElement.alt = nekretnina.naziv;
                  nekretninaElement.appendChild(slikaElement);

                  const detaljiElement = document.createElement("div");
                  detaljiElement.classList.add("detalji-nekretnine");
                  detaljiElement.innerHTML = `
                      <h3>${nekretnina.naziv}</h3>
                      <p>Kvadratura: ${nekretnina.kvadratura} m²</p>
                  `;
                  nekretninaElement.appendChild(detaljiElement);

                  const cijenaElement = document.createElement("div");
                  cijenaElement.classList.add("cijena-nekretnine");
                  cijenaElement.innerHTML = `<p>Cijena: ${nekretnina.cijena} BAM</p>`;
                  nekretninaElement.appendChild(cijenaElement);

                  const detaljiDugme = document.createElement("a");
                  detaljiDugme.classList.add("detalji-dugme");
                  detaljiDugme.textContent = 'Detalji';
                  detaljiDugme.href = `detalji.html?id=${nekretnina.id}`;
                  nekretninaElement.appendChild(detaljiDugme);

                  nekretnineContainer.appendChild(nekretninaElement);
              });
          }
      });
  } else {
      lokacijaNaslov.style.display = 'none';
      nekretnineContainer.innerHTML = "<p>Nije specificirana lokacija. Molimo upišite lokaciju za prikaz top nekretnina u URL-u.</p>";
  }
});