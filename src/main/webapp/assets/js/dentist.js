const searchInput = document.getElementById("dentistSearch");

if (searchInput) {

    searchInput.addEventListener("keyup", function () {

        const filter = this.value.toLowerCase();

        const rows = document.querySelectorAll("#dentistTable tbody tr");

        rows.forEach(function(row){

            row.style.display =
                row.innerText.toLowerCase().includes(filter)
                ? ""
                : "none";

        });

    });

}