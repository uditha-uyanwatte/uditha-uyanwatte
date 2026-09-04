<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="dao.PatientDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Patient" %>

<%
    // LOGIN CHECK
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // RECEPTIONIST ROLE CHECK
    String role = (String) session.getAttribute("role");

    if (!"RECEPTIONIST".equalsIgnoreCase(role)) {
        response.sendRedirect("login.jsp");
        return;
    }

    // GET ALL PATIENTS
    PatientDAO patientDAO = new PatientDAO();
    List<Patient> patients = patientDAO.getAllPatients();

    String message = request.getParameter("message");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Patient Management - Sunrise Dental Clinic</title>

<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet">

<link
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
    rel="stylesheet">

<style>

body {
    background-color: #f4f7fb;
    font-family: Arial, sans-serif;
}

/* =========================
   SIDEBAR
========================= */

.sidebar {
    min-height: 100vh;
    background: #12304a;
    color: white;
    padding: 25px 15px;
}

.sidebar h3 {
    text-align: center;
    margin-bottom: 35px;
    font-weight: bold;
}

.sidebar a {
    color: #dce6ef;
    text-decoration: none;
    display: block;
    padding: 13px 15px;
    margin-bottom: 8px;
    border-radius: 8px;
    transition: 0.3s;
}

.sidebar a:hover,
.sidebar a.active {
    background: #1f5f8b;
    color: white;
}

/* =========================
   MAIN CONTENT
========================= */

.main-content {
    padding: 30px;
}

.page-title {
    font-weight: bold;
    color: #12304a;
}

.management-card {
    border: none;
    border-radius: 15px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
}

.table-card {
    border: none;
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
}

.table thead th {
    background: #12304a;
    color: white;
}

.add-btn {
    border-radius: 8px;
    padding: 10px 18px;
}

</style>

</head>

<body>

<div class="container-fluid">

<div class="row">

<!-- =========================
     SIDEBAR
========================= -->

<div class="col-md-3 col-lg-2 sidebar">

    <h3>
        <i class="bi bi-heart-pulse"></i>
        Sunrise Dental
    </h3>

    <a href="receptionist-dashboard.jsp">
        <i class="bi bi-grid"></i>
        Dashboard
    </a>

    <a href="ReceptionAppointmentServlet">
        <i class="bi bi-calendar-check"></i>
        Appointments
    </a>

    <a href="reception-add-appointment.jsp">
        <i class="bi bi-calendar-plus"></i>
        Book Appointment
    </a>

    <a href="receptionPatients.jsp" class="active">
        <i class="bi bi-people"></i>
        Patients
    </a>

    <a href="receptionDentists.jsp">
        <i class="bi bi-person-badge"></i>
        Dentists
    </a>

    <a href="search-appointment.jsp">
        <i class="bi bi-search"></i>
        Search Appointment Details
    </a>

    <a href="receptionBilling.jsp">
        <i class="bi bi-credit-card"></i>
        Billing
    </a>

    <a href="help.jsp">
        <i class="bi bi-question-circle"></i>
        Help & Support
    </a>

    <hr>

    <a href="LogoutServlet">
        <i class="bi bi-box-arrow-right"></i>
        Logout
    </a>

</div>


<!-- =========================
     MAIN CONTENT
========================= -->

<div class="col-md-9 col-lg-10 main-content">


    <!-- PAGE HEADER -->

    <div class="d-flex justify-content-between align-items-center mb-4">

        <div>

            <h2 class="page-title">

                <i class="bi bi-people-fill"></i>
                Patient Management

            </h2>

            <p class="text-muted mb-0">

                Register and manage patient information

            </p>

        </div>


        <button
            class="btn btn-primary add-btn"
            data-bs-toggle="modal"
            data-bs-target="#addPatientModal">

            <i class="bi bi-person-plus-fill"></i>
            Add New Patient

        </button>

    </div>


    <!-- SUCCESS MESSAGE -->

    <% if (message != null && !message.trim().isEmpty()) { %>

        <div class="alert alert-success alert-dismissible fade show">

            <i class="bi bi-check-circle-fill"></i>

            <%= message %>

            <button
                type="button"
                class="btn-close"
                data-bs-dismiss="alert">
            </button>

        </div>

    <% } %>


    <!-- ERROR MESSAGE -->

    <% if (error != null && !error.trim().isEmpty()) { %>

        <div class="alert alert-danger alert-dismissible fade show">

            <i class="bi bi-exclamation-triangle-fill"></i>

            <%= error %>

            <button
                type="button"
                class="btn-close"
                data-bs-dismiss="alert">
            </button>

        </div>

    <% } %>


    <!-- SEARCH CARD -->

    <div class="card management-card mb-4">

        <div class="card-body">

            <div class="row align-items-center">

                <div class="col-md-7">

                    <div class="input-group">

                        <span class="input-group-text">

                            <i class="bi bi-search"></i>

                        </span>

                        <input
                            type="text"
                            id="patientSearch"
                            class="form-control"
                            placeholder="Search by patient name, phone or email...">

                    </div>

                </div>


                <div class="col-md-5 text-md-end mt-3 mt-md-0">

                    <span class="badge bg-primary fs-6 p-2">

                        Total Patients:
                        <%= patients != null ? patients.size() : 0 %>

                    </span>

                </div>

            </div>

        </div>

    </div>


    <!-- PATIENT TABLE -->

    <div class="card table-card">

        <div class="card-header bg-white py-3">

            <h5 class="mb-0">

                <i class="bi bi-card-list"></i>
                Registered Patients

            </h5>

        </div>


        <div class="card-body">

            <div class="table-responsive">

                <table
                    class="table table-hover align-middle"
                    id="patientTable">

                    <thead>

                    <tr>

                        <th>Patient ID</th>
                        <th>Full Name</th>
                        <th>Date of Birth</th>
                        <th>Gender</th>
                        <th>Phone</th>
                        <th>Email</th>
                        <th>Address</th>

                    </tr>

                    </thead>


                    <tbody>

                    <%
                    if (patients != null && !patients.isEmpty()) {

                        for (Patient patient : patients) {
                    %>

                    <tr>

                        <!-- PATIENT ID -->

                        <td>

                            <strong>

                                #<%= patient.getPatientId() %>

                            </strong>

                        </td>


                        <!-- FULL NAME -->

                        <td>

                            <strong>

                                <%= patient.getFirstName() %>
                                <%= patient.getLastName() %>

                            </strong>

                        </td>


                        <!-- DATE OF BIRTH -->

                        <td>

                            <%= patient.getDateOfBirth() %>

                        </td>


                        <!-- GENDER -->

                        <td>

                            <span class="badge bg-info text-dark">

                                <%= patient.getGender() %>

                            </span>

                        </td>


                        <!-- PHONE -->

                        <td>

                            <%= patient.getPhone() %>

                        </td>


                        <!-- EMAIL -->

                        <td>

                            <%= patient.getEmail() != null
                                ? patient.getEmail()
                                : "-" %>

                        </td>


                        <!-- ADDRESS -->

                        <td>

                            <%= patient.getAddress() != null
                                ? patient.getAddress()
                                : "-" %>

                        </td>

                    </tr>

                    <%
                        }
                    } else {
                    %>

                    <tr>

                        <td
                            colspan="7"
                            class="text-center text-muted py-4">

                            <i class="bi bi-person-x fs-4"></i>

                            <br>

                            No patients found.

                        </td>

                    </tr>

                    <%
                    }
                    %>

                    </tbody>

                </table>

            </div>

        </div>

    </div>


</div>

</div>

</div>


<!-- =========================
     ADD PATIENT MODAL
========================= -->

<div
    class="modal fade"
    id="addPatientModal"
    tabindex="-1">

    <div class="modal-dialog modal-lg">

        <div class="modal-content">

            <!-- MODAL HEADER -->

            <div class="modal-header bg-primary text-white">

                <h5 class="modal-title">

                    <i class="bi bi-person-plus-fill"></i>
                    Register New Patient

                </h5>

                <button
                    type="button"
                    class="btn-close btn-close-white"
                    data-bs-dismiss="modal">
                </button>

            </div>


            <!-- FORM -->

            <form
                action="AddPatientServlet"
                method="post">

                <div class="modal-body">

                    <div class="row">


                        <!-- FIRST NAME -->

                        <div class="col-md-6 mb-3">

                            <label class="form-label">

                                First Name

                            </label>

                            <input
                                type="text"
                                name="firstName"
                                class="form-control"
                                required>

                        </div>


                        <!-- LAST NAME -->

                        <div class="col-md-6 mb-3">

                            <label class="form-label">

                                Last Name

                            </label>

                            <input
                                type="text"
                                name="lastName"
                                class="form-control"
                                required>

                        </div>


                        <!-- DATE OF BIRTH -->

                        <div class="col-md-6 mb-3">

                            <label class="form-label">

                                Date of Birth

                            </label>

                            <input
                                type="date"
                                name="dateOfBirth"
                                class="form-control"
                                required>

                        </div>


                        <!-- GENDER -->

                        <div class="col-md-6 mb-3">

                            <label class="form-label">

                                Gender

                            </label>

                            <select
                                name="gender"
                                class="form-select"
                                required>

                                <option value="">

                                    Select Gender

                                </option>

                                <option value="Male">

                                    Male

                                </option>

                                <option value="Female">

                                    Female

                                </option>

                                <option value="Other">

                                    Other

                                </option>

                            </select>

                        </div>


                        <!-- PHONE -->

                        <div class="col-md-6 mb-3">

                            <label class="form-label">

                                Phone Number

                            </label>

                            <input
                                type="tel"
                                name="phone"
                                class="form-control"
                                required>

                        </div>


                        <!-- EMAIL -->

                        <div class="col-md-6 mb-3">

                            <label class="form-label">

                                Email Address

                            </label>

                            <input
                                type="email"
                                name="email"
                                class="form-control">

                        </div>


                        <!-- ADDRESS -->

                        <div class="col-12 mb-3">

                            <label class="form-label">

                                Address

                            </label>

                            <textarea
                                name="address"
                                class="form-control"
                                rows="3"
                                required></textarea>

                        </div>


                    </div>

                </div>


                <!-- MODAL FOOTER -->

                <div class="modal-footer">

                    <button
                        type="button"
                        class="btn btn-secondary"
                        data-bs-dismiss="modal">

                        Cancel

                    </button>


                    <button
                        type="submit"
                        class="btn btn-primary">

                        <i class="bi bi-person-check-fill"></i>

                        Register Patient

                    </button>

                </div>

            </form>

        </div>

    </div>

</div>


<!-- BOOTSTRAP JS -->

<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>


<!-- SEARCH FUNCTION -->

<script>

document
    .getElementById("patientSearch")
    .addEventListener("keyup", function () {

        let searchText =
            this.value.toLowerCase();

        let rows =
            document.querySelectorAll(
                "#patientTable tbody tr"
            );

        rows.forEach(function (row) {

            let rowText =
                row.textContent.toLowerCase();

            if (rowText.includes(searchText)) {

                row.style.display = "";

            } else {

                row.style.display = "none";

            }

        });

    });

</script>

</body>
</html>