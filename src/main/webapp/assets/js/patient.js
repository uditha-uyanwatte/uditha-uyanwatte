// Search Patient Table

document.addEventListener("DOMContentLoaded", function () {

    const input = document.getElementById("searchInput");

    if (!input) return;

    input.addEventListener("keyup", function () {

        const filter = input.value.toLowerCase();

        const rows = document.querySelectorAll("#patientTable tbody tr");

        rows.forEach(function(row){

            row.style.display = row.innerText.toLowerCase().includes(filter)
                ? ""
                : "none";

        });

    });

});