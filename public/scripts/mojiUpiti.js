document.addEventListener('DOMContentLoaded', function () {
    const upitiContainer = document.getElementById('upiti-container');

    PoziviAjax.getMojiUpiti((error, data) => {
        if (error) {
            upitiContainer.innerHTML = '<p>Greška prilikom dohvatanja upita.</p>';
        } else if (data.length === 0) {
            upitiContainer.innerHTML = '<p>Nemate upita.</p>';
        } else {
            data.forEach(upit => {
                const upitElement = document.createElement('div');
                upitElement.classList.add('upit');
                upitElement.innerHTML = `
                    <div class="upit-box">
                        <p><strong>ID Nekretnine:</strong> ${upit.id_nekretnine}</p>
                        <p><strong>Tekst Upita:</strong> ${upit.tekst_upita}</p>
                    </div>
                `;
                upitiContainer.appendChild(upitElement);
            });
        }
    });
});