document.addEventListener("DOMContentLoaded", function () {
  const glavniElement = document.getElementById("upiti");
  const carouselButtons = document.querySelector(".carousel-buttons");
  let currentPage = 0;
  let allUpitiLoaded = false;
  let sviUpiti = [];
  let carousel = null;

  function initializeCarousel() {
    const sviElementi = sviUpiti.map(upit => {
      const upitElement = document.createElement("div");
      upitElement.classList.add("upit");
      upitElement.innerHTML = `
        <p><strong>${upit.korisnik_id}:</strong></p>
        <p>${upit.tekst_upita}</p>
      `;
      return upitElement;
    });

    if (sviElementi.length > 0) {
      console.log("sviElementi:", sviElementi);
    } else {
      console.log("sviElementi je prazan");
    }

    if (!carousel) {
      carousel = postaviCarousel(glavniElement, sviElementi, 0, loadNextUpiti);

      if (carousel) {
        document.getElementById("prev").addEventListener("click", function () {
          carousel.fnLijevo();
        });
        document.getElementById("next").addEventListener("click", function () {
          carousel.fnDesno();
          if (carousel.isAtEnd() && !allUpitiLoaded) {
            loadNextUpiti();
          }
        });
      }
    } else {
      carousel.updateElements(sviElementi);
    }
  }

  function loadNextUpiti(callback) {
    const urlParams = new URLSearchParams(window.location.search);
    const nekretninaId = urlParams.get("id");
    PoziviAjax.getNextUpiti(nekretninaId, currentPage, (error, data) => {
      console.log(currentPage);
      if (error) {
        console.error("Greška prilikom dohvatanja sljedećih upita:", error);
      } else if (data.length === 0) {
        allUpitiLoaded = true;
      } else {
        currentPage++;
        sviUpiti.splice(0, sviUpiti.length);
        sviUpiti = sviUpiti.concat(data);
        console.log("Updated upiti:", sviUpiti); 
        if (callback) callback();
        initializeCarousel(); // Ponovno inicijaliziramo carousel s novim upitima
      }
    });
  }

  function loadNekretninaDetails() {
    const urlParams = new URLSearchParams(window.location.search);
    const nekretninaId = urlParams.get("id");
    PoziviAjax.getNekretninaDetails(nekretninaId, (error, data) => {
      if (error) {
        console.error("Greška prilikom dohvatanja detalja nekretnine:", error);
      } else {
        document.getElementById("nekretnina-slika").src = `../Resources/${data.id}.jpg`;
        document.getElementById("nekretnina-slika").setAttribute("data-nekretnina-id", data.id);
        document.getElementById("nekretnina-naziv").textContent = data.naziv;
        document.getElementById("nekretnina-kvadratura").textContent = data.kvadratura;
        document.getElementById("nekretnina-cijena").textContent = data.cijena;
        document.getElementById("nekretnina-grijanje").textContent = data.tip_grijanja;
        document.getElementById("nekretnina-lokacija").textContent = data.lokacija;
        document.getElementById("nekretnina-lokacija").setAttribute("data-lokacija", data.lokacija);
        document.getElementById("nekretnina-godina").textContent = data.godina_izgradnje;
        document.getElementById("nekretnina-datum").textContent = data.datum_objave;
        document.getElementById("nekretnina-opis").textContent = data.opis;

        // Prikazivanje upita
        sviUpiti = data.upiti;
        console.log("Initial upiti:", sviUpiti); 
        initializeCarousel();
      }
    });
  }

  // Učitavanje detalja nekretnine
  loadNekretninaDetails();

  // Prikazivanje prvih 3 upita
  loadNextUpiti();

  // Dodavanje event listenera za link lokacije
  const lokacijaLink = document.querySelector("#nekretnina-lokacija");
  if (lokacijaLink) {
    lokacijaLink.addEventListener("click", function (event) {
      event.preventDefault();
      const lokacija = event.target.getAttribute("data-lokacija");
      window.location.href = `topNekretnine.html?lokacija=${encodeURIComponent(lokacija)}`;
    });
  }
});