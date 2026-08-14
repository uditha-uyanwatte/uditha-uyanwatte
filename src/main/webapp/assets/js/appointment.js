// Search Appointment

const search = document.getElementById("appointmentSearch");

if (search) {

    search.addEventListener("keyup", function () {

        const value = this.value.toLowerCase();

        const rows = document.querySelectorAll("#appointmentTable tbody tr");

        rows.forEach(function(row){

            row.style.display =
                row.innerText.toLowerCase().includes(value)
                ? ""
                : "none";

        });

    });

}

// Confirm Delete

document.querySelectorAll(".btn-danger").forEach(function(btn){

    btn.addEventListener("click", function(e){

        if(!confirm("Are you sure you want to delete this appointment?")){

            e.preventDefault();

        }

    });

});