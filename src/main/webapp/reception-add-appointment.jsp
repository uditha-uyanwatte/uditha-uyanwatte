<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>

<%@ page import="dao.PatientDAO"%>
<%@ page import="dao.DentistDAO"%>
<%@ page import="dao.TreatmentDAO"%>

<%@ page import="model.Patient"%>
<%@ page import="model.Dentist"%>
<%@ page import="model.Treatment"%>

<%

    // =========================================
    // LOGIN CHECK
    // =========================================

    if (session.getAttribute("username") == null) {

        response.sendRedirect("login.jsp");

        return;
    }


    // =========================================
    // GET PATIENTS
    // =========================================

    PatientDAO patientDAO = new PatientDAO();

    List<Patient> patients =
            patientDAO.getAllPatients();


    // =========================================
    // GET DENTISTS
    // =========================================

    DentistDAO dentistDAO = new DentistDAO();

    List<Dentist> dentists =
            dentistDAO.getAllDentists();


    // =========================================
    // GET TREATMENTS
    // =========================================

    TreatmentDAO treatmentDAO =
            new TreatmentDAO();

    List<Treatment> treatments =
            treatmentDAO.getAllTreatments();

%>


<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta
    name="viewport"
    content="width=device-width, initial-scale=1">

<title>Book Appointment</title>


<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet">


<link
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
    rel="stylesheet">


<style>

body {

    background: #f4f6f9;

    font-family: Arial, sans-serif;

}


.appointment-box {

    max-width: 900px;

    margin: 50px auto;

    background: white;

    padding: 35px;

    border-radius: 15px;

    box-shadow:
        0 5px 20px
        rgba(0,0,0,0.10);

}


.page-header {

    background:
        linear-gradient(
            135deg,
            #1e88e5,
            #1565c0
        );

    color: white;

    padding: 20px;

    border-radius: 12px;

    margin-bottom: 30px;

}


.form-label {

    font-weight: 600;

}


.price-box {

    background: #eaf4ff;

    border: 1px solid #b6dcff;

    border-radius: 10px;

    padding: 15px;

    margin-top: 10px;

    display: none;

}


.price-label {

    color: #555;

    font-size: 14px;

}


.price-value {

    color: #1565c0;

    font-size: 24px;

    font-weight: bold;

}

</style>

</head>


<body>


<div class="container">


    <div class="appointment-box">


        <!-- =====================================
             HEADER
        ====================================== -->

        <div class="page-header">

            <h3 class="mb-1">

                <i class="bi bi-calendar-plus"></i>

                Book Appointment

            </h3>


            <p class="mb-0">

                Create a new patient appointment

            </p>

        </div>



        <!-- =====================================
             FORM
        ====================================== -->

        <form
            action="ReceptionAddAppointmentServlet"
            method="post">


            <div class="row">


                <!-- =================================
                     PATIENT
                ================================== -->

                <div class="col-md-6 mb-3">

                    <label class="form-label">

                        Select Patient

                    </label>


                    <select
                        name="patientId"
                        class="form-select"
                        required>

                        <option value="">

                            Select Patient

                        </option>


                        <%

                            if (patients != null) {

                                for (
                                    Patient patient :
                                    patients
                                ) {

                        %>

                            <option
                                value="<%= patient.getPatientId() %>">

                                <%= patient.getFirstName() %>
                                <%= patient.getLastName() %>

                            </option>

                        <%

                                }

                            }

                        %>

                    </select>

                </div>



                <!-- =================================
                     DENTIST
                ================================== -->

                <div class="col-md-6 mb-3">

                    <label class="form-label">

                        Select Dentist

                    </label>


                    <select
                        name="dentistId"
                        class="form-select"
                        required>

                        <option value="">

                            Select Dentist

                        </option>


                        <%

                            if (dentists != null) {

                                for (
                                    Dentist dentist :
                                    dentists
                                ) {

                        %>

                            <option
                                value="<%= dentist.getDentistId() %>">

                                Dr.
                                <%= dentist.getFirstName() %>
                                <%= dentist.getLastName() %>

                            </option>

                        <%

                                }

                            }

                        %>

                    </select>

                </div>



                <!-- =================================
                     TREATMENT
                ================================== -->

                <div class="col-md-6 mb-3">

                    <label class="form-label">

                        Select Treatment

                    </label>


                    <select
                        id="treatmentId"
                        name="treatmentId"
                        class="form-select"
                        required>


                        <option value="">

                            Select Treatment

                        </option>


                        <%

                            if (treatments != null) {

                                for (
                                    Treatment treatment :
                                    treatments
                                ) {

                        %>

                            <option

                                value="<%= treatment.getTreatmentId() %>"

                                data-name="<%= treatment.getTreatmentName() %>"

                                data-price="<%= treatment.getCost() %>">

                                <%= treatment.getTreatmentName() %>

                            </option>

                        <%

                                }

                            }

                        %>

                    </select>


                    <!-- Hidden treatment name -->

                    <input
                        type="hidden"
                        id="treatmentName"
                        name="treatment">


                    <!-- Hidden treatment price -->

                    <input
                        type="hidden"
                        id="treatmentPrice"
                        name="amount">


                    <!-- PRICE DISPLAY -->

                    <div
                        id="priceBox"
                        class="price-box">


                        <div class="price-label">

                            Treatment Price

                        </div>


                        <div
                            id="priceValue"
                            class="price-value">

                            Rs. 0.00

                        </div>


                    </div>


                </div>



                <!-- =================================
                     DATE
                ================================== -->

                <div class="col-md-6 mb-3">

                    <label class="form-label">

                        Appointment Date

                    </label>


                    <input
                        type="date"
                        name="appointmentDate"
                        class="form-control"
                        required>

                </div>



                <!-- =================================
                     TIME
                ================================== -->

                <div class="col-md-6 mb-3">

                    <label class="form-label">

                        Appointment Time

                    </label>


                    <input
                        type="time"
                        name="appointmentTime"
                        class="form-control"
                        required>

                </div>



                <!-- =================================
                     STATUS
                ================================== -->

                <div class="col-md-6 mb-3">

                    <label class="form-label">

                        Status

                    </label>


                    <select
                        name="status"
                        class="form-select"
                        required>


                        <option value="Pending">

                            Pending

                        </option>


                        <option value="Confirmed">

                            Confirmed

                        </option>


                    </select>

                </div>



                <!-- =================================
                     NOTES
                ================================== -->

                <div class="col-md-12 mb-3">

                    <label class="form-label">

                        Notes

                    </label>


                    <textarea
                        name="notes"
                        class="form-control"
                        rows="4"
                        placeholder="Enter additional notes"></textarea>

                </div>


            </div>



            <!-- =====================================
                 BUTTONS
            ====================================== -->

            <div class="mt-4">


                <a
                    href="ReceptionAppointmentServlet"
                    class="btn btn-secondary">

                    <i class="bi bi-arrow-left"></i>

                    Cancel

                </a>


                <button
                    type="submit"
                    class="btn btn-primary">

                    <i class="bi bi-calendar-check"></i>

                    Book Appointment

                </button>


            </div>


        </form>


    </div>


</div>



<!-- =========================================
     TREATMENT PRICE SCRIPT
========================================= -->

<script>

const treatmentSelect =
    document.getElementById("treatmentId");


const treatmentName =
    document.getElementById("treatmentName");


const treatmentPrice =
    document.getElementById("treatmentPrice");


const priceBox =
    document.getElementById("priceBox");


const priceValue =
    document.getElementById("priceValue");



treatmentSelect.addEventListener(
    "change",
    function() {


        const selectedOption =
            this.options[
                this.selectedIndex
            ];


        if (
            this.value === ""
        ) {


            priceBox.style.display =
                "none";


            treatmentName.value =
                "";


            treatmentPrice.value =
                "";


            return;

        }


        const name =
            selectedOption.getAttribute(
                "data-name"
            );


        const price =
            selectedOption.getAttribute(
                "data-price"
            );



        // Set hidden treatment name

        treatmentName.value =
            name;


        // Set hidden price

        treatmentPrice.value =
            price;



        // Display price

        priceValue.innerText =
            "Rs. " +
            parseFloat(price).toFixed(2);


        priceBox.style.display =
            "block";


    }
);

</script>


</body>

</html>