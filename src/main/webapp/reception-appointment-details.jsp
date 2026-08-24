<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="model.Appointment"%>

<%
    // =========================
    // LOGIN CHECK
    // =========================

    if (session.getAttribute("user") == null) {

        response.sendRedirect("login.jsp");
        return;
    }


    // =========================
    // GET APPOINTMENT
    // =========================

    Appointment appointment =
            (Appointment) request.getAttribute("appointment");


    if (appointment == null) {

        response.sendRedirect(
                "search-appointment.jsp?error=notfound"
        );

        return;
    }
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>Appointment Details</title>

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

.details-box {
    max-width: 950px;
    margin: 50px auto;
    background: white;
    padding: 35px;
    border-radius: 15px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.10);
}

.page-header {
    background:
        linear-gradient(
            135deg,
            #1e88e5,
            #1565c0
        );

    color: white;
    padding: 25px;
    border-radius: 12px;
    margin-bottom: 25px;
}

.info-card {
    background: #f8f9fa;
    border-left: 5px solid #1565c0;
    border-radius: 10px;
    padding: 20px;
    margin-bottom: 20px;
}

.info-label {
    font-size: 13px;
    color: #6c757d;
    font-weight: bold;
    text-transform: uppercase;
}

.info-value {
    font-size: 17px;
    color: #212529;
    margin-top: 5px;
}

.status {
    padding: 7px 15px;
    border-radius: 20px;
    color: white;
    font-weight: bold;
    display: inline-block;
}

</style>

</head>

<body>

<div class="container">

    <div class="details-box">

        <!-- HEADER -->

        <div class="page-header">

            <h3 class="mb-1">

                <i class="bi bi-calendar2-check"></i>

                Appointment Details

            </h3>

            <p class="mb-0">

                Complete appointment information

            </p>

        </div>


        <!-- APPOINTMENT ID -->

        <div class="alert alert-primary">

            <strong>

                Appointment ID:

            </strong>

            #<%= appointment.getAppointmentId() %>

        </div>


        <!-- APPOINTMENT INFORMATION -->

        <div class="info-card">

            <h5 class="mb-4">

                <i class="bi bi-calendar-event-fill"></i>

                Appointment Information

            </h5>


            <div class="row">


                <!-- PATIENT -->

                <div class="col-md-6 mb-4">

                    <div class="info-label">

                        Patient

                    </div>

                    <div class="info-value">

                        <%= appointment.getPatientName() != null
                                ? appointment.getPatientName()
                                : "Patient ID: "
                                + appointment.getPatientId() %>

                    </div>

                </div>


                <!-- DENTIST -->

                <div class="col-md-6 mb-4">

                    <div class="info-label">

                        Dentist

                    </div>

                    <div class="info-value">

                        <%= appointment.getDentistName() != null
                                ? "Dr. " +
                                appointment.getDentistName()
                                : "Dentist ID: "
                                + appointment.getDentistId() %>

                    </div>

                </div>


                <!-- TREATMENT -->

                <div class="col-md-4 mb-4">

                    <div class="info-label">

                        Treatment

                    </div>

                    <div class="info-value">

                        <%= appointment.getTreatment() != null
                                ? appointment.getTreatment()
                                : "N/A" %>

                    </div>

                </div>


                <!-- DATE -->

                <div class="col-md-4 mb-4">

                    <div class="info-label">

                        Appointment Date

                    </div>

                    <div class="info-value">

                        <%= appointment.getAppointmentDate() %>

                    </div>

                </div>


                <!-- TIME -->

                <div class="col-md-4 mb-4">

                    <div class="info-label">

                        Appointment Time

                    </div>

                    <div class="info-value">

                        <%= appointment.getAppointmentTime() %>

                    </div>

                </div>


                <!-- STATUS -->

                <div class="col-md-6 mb-4">

                    <div class="info-label">

                        Status

                    </div>

                    <div class="info-value">

                        <%
                            String status =
                                    appointment.getStatus();
                        %>

                        <% if ("Completed".equalsIgnoreCase(status)) { %>

                            <span class="badge bg-success px-3 py-2">

                                Completed

                            </span>

                        <% } else if ("Confirmed".equalsIgnoreCase(status)) { %>

                            <span class="badge bg-primary px-3 py-2">

                                Confirmed

                            </span>

                        <% } else if ("Pending".equalsIgnoreCase(status)) { %>

                            <span class="badge bg-warning text-dark px-3 py-2">

                                Pending

                            </span>

                        <% } else if ("Cancelled".equalsIgnoreCase(status)) { %>

                            <span class="badge bg-danger px-3 py-2">

                                Cancelled

                            </span>

                        <% } else { %>

                            <span class="badge bg-secondary px-3 py-2">

                                <%= status != null
                                        ? status
                                        : "Unknown" %>

                            </span>

                        <% } %>

                    </div>

                </div>


                <!-- NOTES -->

                <div class="col-md-12">

                    <div class="info-label">

                        Notes

                    </div>

                    <div class="info-value">

                        <%= appointment.getNotes() != null
                                && !appointment.getNotes()
                                        .trim()
                                        .isEmpty()
                                ? appointment.getNotes()
                                : "No additional notes." %>

                    </div>

                </div>


            </div>

        </div>


        <!-- BUTTONS -->

        <div class="d-flex gap-2 mt-4 flex-wrap">


            <a href="search-appointment.jsp"
               class="btn btn-primary">

                <i class="bi bi-search"></i>

                Search Another

            </a>


            <a href="ReceptionAppointmentServlet"
               class="btn btn-secondary">

                <i class="bi bi-calendar-event"></i>

                All Appointments

            </a>


            <a href="receptionist-dashboard.jsp"
               class="btn btn-dark">

                <i class="bi bi-house"></i>

                Dashboard

            </a>


        </div>

    </div>

</div>

</body>

</html>