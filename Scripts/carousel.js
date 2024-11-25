function postaviCarousel(glavniElement, sviElementi, indeks = 0) {
  if (
    !glavniElement ||
    !Array.isArray(sviElementi) ||
    sviElementi.length === 0 ||
    indeks < 0 ||
    indeks >= sviElementi.length
  ) {
    return null;
  }

  // za prikaz trenutnog elementa
  function prikaziElement() {
    glavniElement.innerHTML = "";
    const noviElement = sviElementi[indeks].cloneNode(true);
    glavniElement.appendChild(noviElement);
  }

  function fnDesno() {
    indeks = (indeks + 1) % sviElementi.length;
    prikaziElement();
  }

  function fnLijevo() {
    indeks = (indeks - 1 + sviElementi.length) % sviElementi.length;
    prikaziElement();
  }

  prikaziElement();

  return {
    fnLijevo,
    fnDesno,
  };
}
