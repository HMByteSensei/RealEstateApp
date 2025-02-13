function postaviCarousel(glavniElement, sviElementi, indeks = 0) {
  if (!glavniElement || !Array.isArray(sviElementi) || sviElementi.length === 0) {
    return null;
  }

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
    if (indeks === 0) {
      indeks = sviElementi.length - 1;
    } else {
      indeks = (indeks - 1 + sviElementi.length) % sviElementi.length;
    }
    prikaziElement();
  }

  function updateElements(noviElementi) {
    sviElementi = noviElementi;
    prikaziElement();
  }

  prikaziElement();

  return {
    fnLijevo,
    fnDesno,
    updateElements,
  };
}