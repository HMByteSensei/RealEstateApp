function postaviCarousel(glavniElement, sviElementi, indeks = 0, loadNextUpiti) {
  if (!glavniElement || !Array.isArray(sviElementi) || sviElementi.length === 0) {
    return null;
  }

  let allUpitiLoaded = false;

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

  function isAtEnd() {
    return indeks === sviElementi.length - 1;
  }

  function updateElements(noviElementi) {
    sviElementi = noviElementi;
    prikaziElement();
  }

  prikaziElement();

  return {
    fnLijevo,
    fnDesno,
    isAtEnd,
    updateElements,
  };
}