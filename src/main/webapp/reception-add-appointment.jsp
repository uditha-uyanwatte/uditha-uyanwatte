<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="dao.PatientDAO"%>
<%@ page import="dao.DentistDAO"%>
<%@ page import="model.Patient"%>
<%@ page import="model.Dentist"%>

<%
    // Login check
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Get patients
    PatientDAO patientDAO = new PatientDAO();
    List<Patient> patients = patientDAO.getAllPatients();

    // Get dentists
    DentistDAO dentistDAO = new DentistDAO();
    List<Dentist> dentists = dentistDAO.getAllDentists();
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
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
    box-shadow: 0 5px 20px rgba(0,0,0,0.10);
}

.page-header {
    background: linear-gradient(135deg, #1e88e5, #1565c0);
    color: white;
    padding: 20px;
    border-radius: 12px;
    margin-bottom: 30px;
}

.form-label {
    font-weight: 600;
}

</style>

</head>

<body>

<div class="container">

    <div class="appointment-box">

        <!-- HEADER -->

        <div class="page-header">

            <h3 class="mb-1">

                <i class="bi bi-calendar-plus"></i>
                Book Appointment

            </h3>

            <p class="mb-0">
                Create a new patient appointment
            </p>

        </div>


        <!-- FORM -->

        <form action="ReceptionAddAppointmentServlet"
              method="post">

            <div class="row">


                <!-- PATIENT -->

                <div class="col-md-6 mb-3">

                    <label class="form-label">
                        Select Patient
                    </label>

                    <select name="patientId"
                            class="form-select"
                            required>

                        <option value="">
                            Select Patient
                        </option>

                        <%
                            if (patients != null) {

                                for (Patient patient : patients) {
                        %>

                            <option value="<%= patient.getPatientId() %>">

                                <%= patient.getFirstName() %>
                                <%= patient.getLastName() %>

                            </option>

                        <%
                                }
                            }
                        %>

                    </select>

                </div>


                <!-- DENTIST -->

                <div class="col-md-6 mb-3">

                    <label class="form-label">
                        Select Dentist
                    </label>

                    <select name="dentistId"
                            class="form-select"
                            required>

                        <option value="">
                            Select Dentist
                        </option>

                        <%
                            if (dentists != null) {

                                for (Dentist dentist : dentists) {
                        %>

                            <option value="<%= dentist.getDentistId() %>">

                                Dr. <%= dentist.getFirstName() %>
                                <%= dentist.getLastName() %>

                            </option>

                        <%
                                }
                            }
                        %>

                    </select>

                </div>


                <!-- TREATMENT -->

                <div class="col-md-6 mb-3">

                    <label class="form-label">
                        Treatment
                    </label>

                    <input type="text"
                           name="treatment"
                           class="form-control"
                           placeholder="Enter treatment"
                           required>

                </div>


                <!-- DATE -->

                <div class="col-md-6 mb-3">

                    <label class="form-label">
                        Appointment Date
                    </label>

                    <input type="date"
                           name="appointmentDate"
                           class="form-control"
                           required>

                </div>


                <!-- TIME -->

                <div class="col-md-6 mb-3">

                    <label class="form-label">
                        Appointment Time
                    </label>

                    <input type="time"
                           name="appointmentTime"
                           class="form-control"
                           required>

                </div>


                <!-- STATUS -->

                <div class="col-md-6 mb-3">

                    <label class="form-label">
                        Status
                    </label>

                    <select name="status"
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


                <!-- NOTES -->

                <div class="col-md-12 mb-3">

                    <label class="form-label">
                        Notes
                    </label>

                    <textarea name="notes"
                              class="form-control"
                              rows="4"
                              placeholder="Enter additional notes"></textarea>

                </div>

            </div>


            <!-- BUTTONS -->

            <div class="mt-4">

                <a href="ReceptionAppointmentServlet"
                   class="btn btn-secondary">

                    <i class="bi bi-arrow-left"></i>
                    Cancel

                </a>

                <button type="submit"
                        class="btn btn-primary">

                    <i class="bi bi-calendar-check"></i>
                    Book Appointment

                </button>

            </div>

        </form>

    </div>

</div>

</body>

</html>