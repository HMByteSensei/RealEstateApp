async function populateVezanePonudeDropdown() {
  const nekretninaId = new URLSearchParams(window.location.search).get("id");
  const response = await fetch(`/nekretnina/${nekretninaId}/ponude`);
  const ponude = await response.json();

  const dropdown = document.getElementById("id-vezane-ponude");
  dropdown.innerHTML = '<option value="">Nema vezane ponude</option>';

  ponude.forEach(ponuda => {
    const option = document.createElement("option");
    option.value = ponuda.id;
    option.textContent = `Ponuda ID: ${ponuda.id}`;
    dropdown.appendChild(option);
  });

  if (ponude.length > 0) {
    dropdown.disabled = false;
  }
}

async function loadInteresovanja() {
  const nekretninaId = new URLSearchParams(window.location.search).get("id");
  const response = await fetch(`/nekretnina/${nekretninaId}/interesovanja`);
  const interesovanja = await response.json();

  const container = document.getElementById("interesovanja-container");
  container.innerHTML = "";

  interesovanja.upiti.forEach(upit => {
    const div = document.createElement("div");
    div.innerHTML = `<p>ID: ${upit.id}</p><p>Tekst: ${upit.tekst}</p>`;
    container.appendChild(div);
  });

  interesovanja.zahtjevi.forEach(zahtjev => {
    const div = document.createElement("div");
    div.innerHTML = `<p>ID: ${zahtjev.id}</p><p>Tekst: ${zahtjev.tekst}</p><p>Datum: ${zahtjev.trazeniDatum}</p><p>Status: ${zahtjev.odobren ? "Odobren" : "Odbijen"}</p>`;
    container.appendChild(div);
  });

  interesovanja.ponude.forEach(ponuda => {
    const div = document.createElement("div");
    div.innerHTML = `<p>ID: ${ponuda.id}</p><p>Tekst: ${ponuda.tekst}</p><p>Status: ${ponuda.odbijenaPonuda ? "Odbijena" : "Odobrena"}</p>`;
    container.appendChild(div);
  });
}

document.addEventListener("DOMContentLoaded", function () {
  populateVezanePonudeDropdown();
  loadInteresovanja();
  const glavniElement = document.getElementById("upiti");
  const carouselButtons = document.querySelector(".carousel-buttons");
  const ponudeElement = document.getElementById("ponude");
  
  const zahtjeviElement = document.getElementById("zahtjevi");
  let sviUpiti = [];
  let sviZahtjevi = [];
  let carouselUpiti = null;
  let carouselZahtjevi = null;
  let isAdmin = false;
  let svePonude = [];

  // Provjera da li je korisnik admin
  function checkIfAdmin() {
    fetch('/korisnik/admin')
      .then(response => response.json())
      .then(data => {
        isAdmin = data.isAdmin;
      })
      .catch(error => {
        console.error("Error checking admin status:", error);
      });
  }

  function initializeCarousel(element, items, prevButtonId, nextButtonId) {
    console.log("Initializing carousel with items:", items);
    if (!items) {
      console.error("Items are undefined");
      return;
    }

    const sviElementi = items.map(item => {
      const itemElement = document.createElement("div");
      itemElement.classList.add("item");
      itemElement.innerHTML = `
        <p><strong>ID Korisnika: ${item.korisnikId}</strong></p>
        <p>${item.tekst}</p>
        ${item.trazeniDatum ? `<p>Datum: ${item.trazeniDatum}</p>` : ''}
        ${item.odobren !== undefined ? `<p>Status: ${item.odobren ? "Odobren" : "Odbijen"}</p>` : ''}
        ${item.cijenaPonude ? `<p>Cijena: ${item.cijenaPonude}</p>` : ''}
        ${item.datumPonude ? `<p>Datum ponude: ${item.datumPonude}</p>` : ''}
      `;

      if (isAdmin && item.trazeniDatum) {
        const odgovorForm = document.createElement("form");
        odgovorForm.innerHTML = `
          <label for="odobren">Odobri:</label>
          <select name="odobren" id="odobren">
            <option value="true">Da</option>
            <option value="false">Ne</option>
          </select>
          <label for="addToTekst">Dodaj tekst:</label>
          <input type="text" name="addToTekst" id="addToTekst">
          <button type="submit">Odgovori</button>
        `;
        odgovorForm.addEventListener("submit", function (event) {
          event.preventDefault();
          const odobren = odgovorForm.querySelector("#odobren").value === "true";
          const addToTekst = odgovorForm.querySelector("#addToTekst").value;
          odgovorNaZahtjev(item.id, odobren, addToTekst);
        });
        itemElement.appendChild(odgovorForm);
      }

      return itemElement;
    });

    if (sviElementi.length > 0) {
      console.log("sviElementi:", sviElementi);
    } else {
      console.log("sviElementi je prazan");
    }

    const carousel = postaviCarousel(element, sviElementi, 0);

    if (carousel) {
      document.getElementById(prevButtonId).addEventListener("click", function () {
        carousel.fnLijevo();
      });
      document.getElementById(nextButtonId).addEventListener("click", function () {
        carousel.fnDesno();
      });
    }
  }


  function loadNextUpiti(callback) {
    const urlParams = new URLSearchParams(window.location.search);
    const nekretninaId = urlParams.get("id");
    console.log("Loading next upiti for nekretninaId:", nekretninaId, "page:", currentPage);
    PoziviAjax.getNextUpiti(nekretninaId, currentPage, (error, data) => {
      console.log("Received data:", data);
      if (error) {
        console.error("Greška prilikom dohvatanja sljedećih upita:", error);
      } else if (data.length === 0) {
        allUpitiLoaded = true;
        if (currentPage === 1) {
          glavniElement.innerHTML = "<p>Nema upita za ovu nekretninu</p>";
        }
      } else {
        currentPage++;
        sviUpiti = sviUpiti.concat(data);
        console.log("Updated upiti:", sviUpiti); 
        if (callback) callback();
        initializeCarousel(); // Ponovno inicijaliziramo carousel s novim upitima
      }
    });
  }

  function loadUpiti() {
    const urlParams = new URLSearchParams(window.location.search);
    const nekretninaId = urlParams.get("id");
    console.log("Loading upiti for nekretninaId:", nekretninaId);
    fetch(`/nekretnina/${nekretninaId}/upiti`)
      .then(response => {
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        return response.json();
      })
      .then(data => {
        console.log("Received upiti data:", data);
        if (data.length === 0) {
          glavniElement.innerHTML = "<p>Nema upita za ovu nekretninu</p>";
        } else {
          sviUpiti = data;
          console.log("Updated upiti:", sviUpiti); 
          initializeCarousel(glavniElement, sviUpiti, "prev-upiti", "next-upiti"); // Ponovno inicijaliziramo carousel s novim upitima
        }
      })
      .catch(error => {
        console.error("Error fetching upiti:", error);
      });
  }

  function loadZahtjevi() {
    const urlParams = new URLSearchParams(window.location.search);
    const nekretninaId = urlParams.get("id");
    console.log("Loading zahtjevi for nekretninaId:", nekretninaId);
    fetch(`/nekretnina/${nekretninaId}/zahtjevi`)
      .then(response => {
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        return response.json();
      })
      .then(data => {
        console.log("Received zahtjevi data:", data);
        if (data.length === 0) {
          zahtjeviElement.innerHTML = "<p>Nema zahtjeva za ovu nekretninu</p>";
        } else {
          sviZahtjevi = data;
          console.log("Updated zahtjevi:", sviZahtjevi);
          initializeCarousel(zahtjeviElement, sviZahtjevi, "prev-zahtjevi", "next-zahtjevi");
        }
      })
      .catch(error => {
        console.error("Error fetching zahtjevi:", error);
      });
  }

  function odgovorNaZahtjev(zahtjevId, odobren, addToTekst) {
    const urlParams = new URLSearchParams(window.location.search);
    const nekretninaId = urlParams.get("id");
    fetch(`/nekretnina/${nekretninaId}/zahtjev/${zahtjevId}`, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ odobren, addToTekst })
    })
    .then(response => response.json())
    .then(result => {
      console.log("Success:", result);
      // Reload zahtjevi after successful response
      loadZahtjevi();
    })
    .catch(error => {
      console.error("Error:", error);
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
        sviUpiti = data.upiti || [];
        console.log("Initial upiti:", sviUpiti); 
        initializeCarousel();
      }
    });
  }

  function loadPonude() {
    const urlParams = new URLSearchParams(window.location.search);
    const nekretninaId = urlParams.get("id");
    console.log("Loading ponude for nekretninaId:", nekretninaId);
    fetch(`/nekretnina/${nekretninaId}/ponude`)
      .then(response => {
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        return response.json();
      })
      .then(data => {
        console.log("Received ponude data:", data);
        if (data.length === 0) {
          ponudeElement.innerHTML = "<p>Trenutno nema ponuda za ovu nekretninu.</p>";
        } else {
          svePonude = data;
          console.log("Updated ponude:", svePonude);
          initializeCarousel(ponudeElement, svePonude, "prev-ponude", "next-ponude");
        }
      })
      .catch(error => {
        console.error("Error fetching ponude:", error);
      });
  }


  function odgovorNaZahtjev(zahtjevId, odobren, addToTekst) {
    const urlParams = new URLSearchParams(window.location.search);
    const nekretninaId = urlParams.get("id");
    fetch(`/nekretnina/${nekretninaId}/zahtjev/${zahtjevId}`, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ odobren, addToTekst })
    })
    .then(response => {
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      return response.json();
    })
    .then(result => {
      console.log("Success:", result);
      // Reload zahtjevi after successful response
      loadZahtjevi();
    })
    .catch(error => {
      console.error("Error:", error);
    });
  }

  function showPopup(message) {
    const popup = document.createElement("div");
    popup.classList.add("popup");
    popup.textContent = message;
    document.body.appendChild(popup);
    setTimeout(() => {
      popup.remove();
    }, 3000);
  }

  // Initial load of upiti and zahtjevi
  checkIfAdmin();

  // Učitavanje detalja nekretnine
  loadNekretninaDetails();

  // Prikazivanje prvih 3 upita
  // loadNextUpiti();
  loadUpiti();
  loadZahtjevi();
  loadPonude();

  // Dodavanje event listenera za link lokacije
  const lokacijaLink = document.querySelector("#nekretnina-lokacija");
  if (lokacijaLink) {
    lokacijaLink.addEventListener("click", function (event) {
      event.preventDefault();
      const lokacija = event.target.getAttribute("data-lokacija");
      window.location.href = `topNekretnine.html?lokacija=${encodeURIComponent(lokacija)}`;
    });
  }

  
  
  const tipInteresovanja = document.getElementById("tip-interesovanja");
  const upitFields = document.getElementById("upit-fields");
  const zahtjevFields = document.getElementById("zahtjev-fields");
  const ponudaFields = document.getElementById("ponuda-fields");

  tipInteresovanja.addEventListener("change", function () {
    const selectedType = tipInteresovanja.value;
    upitFields.style.display = selectedType === "upit" ? "block" : "none";
    zahtjevFields.style.display = selectedType === "zahtjev" ? "block" : "none";
    ponudaFields.style.display = selectedType === "ponuda" ? "block" : "none";
  });
  
  const form = document.getElementById("interesovanje-form");
  form.addEventListener("submit", function (event) {
    event.preventDefault();

    const formData = new FormData(form);
    const tipInteresovanja = formData.get("tip-interesovanja");
    const nekretninaId = new URLSearchParams(window.location.search).get("id");

    let url = `/nekretnina/${nekretninaId}/${tipInteresovanja}`;
    let data = {};

    if (tipInteresovanja === "upit") {
      data.tekst_upita = formData.get("upit-tekst");
    } else if (tipInteresovanja === "zahtjev") {
      data.tekst = formData.get("zahtjev-tekst");
      data.trazeniDatum = formData.get("zahtjev-datum");
    } else if (tipInteresovanja === "ponuda") {
      data.tekst = formData.get("ponuda-tekst");
      data.cijenaPonude = formData.get("ponuda-cijena");
      data.datumPonude = formData.get("ponuda-datum");
      data.idVezanePonude = formData.get("id-vezane-ponude");
    }

    fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify(data)
    })
    .then(response => {
      if (response.status === 401) {
        showPopup("Morate biti ulogovani da biste dodali upit, zahtjev ili ponudu.");
        throw new Error("Neautorizovan pristup");
      }
      return response.json();
    })
    .then(result => {
      console.log("Success:", result);
      showPopup("Komentar uspješno dodan.");
      // Reload upiti, zahtjevi, and ponude after successful submission
      loadUpiti();
      loadZahtjevi();
      loadPonude();
    })
    .catch(error => {
      console.error("Error:", error);
    });
  });


  // Initial display setup
  tipInteresovanja.dispatchEvent(new Event("change"));
});

