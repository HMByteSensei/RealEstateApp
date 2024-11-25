document.addEventListener("DOMContentLoaded", function () {
  const glavniElement = document.getElementById("upiti");
  const sviElementi = Array.from(document.querySelectorAll("#upiti .upit"));
  const carousel = postaviCarousel(glavniElement, sviElementi);

  if (carousel) {
    document.getElementById("prev").addEventListener("click", function () {
      // console.log("Kliknuto na lijevu");
      carousel.fnLijevo();
    });
    document.getElementById("next").addEventListener("click", function () {
      // console.log("Kliknuto na desnu");
      carousel.fnDesno();
    });
  }
});
