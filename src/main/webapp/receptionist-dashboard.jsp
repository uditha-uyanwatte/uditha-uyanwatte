<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="dao.AppointmentDAO" %>
<%@ page import="dao.PatientDAO" %>
<%@ page import="dao.DentistDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Appointment" %>
<%@ page import="model.Patient" %>
<%@ page import="model.Dentist" %>

<%
    // =========================
    // LOGIN CHECK
    // =========================
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // =========================
    // RECEPTIONIST ROLE CHECK
    // =========================
    String role = (String) session.getAttribute("role");

    if (!"RECEPTIONIST".equalsIgnoreCase(role)) {
        response.sendRedirect("login.jsp");
        return;
    }

    // =========================
    // DAO OBJECTS
    // =========================
    AppointmentDAO appointmentDAO = new AppointmentDAO();
    PatientDAO patientDAO = new PatientDAO();
    DentistDAO dentistDAO = new DentistDAO();

    // =========================
    // GET DATA
    // =========================
    List<Appointment> appointments =
            appointmentDAO.getAllAppointments();

    List<Patient> patients =
            patientDAO.getAllPatients();

    List<Dentist> dentists =
            dentistDAO.getAllDentists();

    // =========================
    // STATISTICS
    // =========================
    int totalAppointments = appointments.size();

    int pendingAppointments = 0;

    int completedAppointments = 0;

    for (Appointment appointment : appointments) {

        if ("Pending".equalsIgnoreCase(
                appointment.getStatus())) {

            pendingAppointments++;

        } else if ("Completed".equalsIgnoreCase(
                appointment.getStatus())) {

            completedAppointments++;
        }
    }

    int totalPatients = patients.size();
    int totalDentists = dentists.size();

    String fullName =
            (String) session.getAttribute("fullName");

    if (fullName == null) {
        fullName = "Receptionist";
    }
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>Receptionist Dashboard</title>

<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet">

<link
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
    rel="stylesheet">

<style>

body {
    background: #f4f7fb;
    font-family: Arial, sans-serif;
}

/* SIDEBAR */

.sidebar {
    min-height: 100vh;
    background: #12304a;
    color: white;
    padding: 25px 15px;
}

.sidebar h3 {
    text-align: center;
    margin-bottom: 35px;
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

.main-content {
    padding: 30px;
}

/* HEADER */

.dashboard-header {
    margin-bottom: 30px;
}

.dashboard-header h2 {
    font-weight: bold;
    color: #12304a;
}

/* STAT CARDS */

.stat-card {
    border: none;
    border-radius: 15px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
    transition: 0.3s;
}

.stat-card:hover {
    transform: translateY(-5px);
}

.stat-icon {
    font-size: 35px;
}

/* TABLE */

.dashboard-table {
    border-radius: 15px;
    overflow: hidden;
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
        Sunrise
    </h3>

    <a href="receptionist-dashboard.jsp"
       class="active">

        <i class="bi bi-grid"></i>
        Dashboard

    </a>

    <a href="appointments.jsp">

        <i class="bi bi-calendar-check"></i>
        Appointments

    </a>

    <a href="reception-add-appointment.jsp">

        <i class="bi bi-calendar-plus"></i>
        Book Appointment

    </a>

    <a href="receptionPatients.jsp">

    <i class="bi bi-people"></i>
    Patients

</a>

    <a href="receptionDentists.jsp">

        <i class="bi bi-person-badge"></i>
        Dentists

    </a>

    <a href="receptionBilling.jsp">

        <i class="bi bi-credit-card"></i>
        Billing

    </a>
    
    <a href="help.jsp" >
   <i class="bi bi-credit-card"></i>
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

    <!-- HEADER -->

    <div class="dashboard-header">

        <h2>
            Welcome,
            <%= fullName %> 👋
        </h2>

        <p class="text-muted">
            Receptionist Dashboard Overview
        </p>

    </div>


    <!-- =========================
         STATISTICS
    ========================= -->

    <div class="row g-4 mb-4">


        <!-- TOTAL APPOINTMENTS -->

        <div class="col-md-6 col-xl-3">

            <div class="card stat-card p-3">

                <div class="d-flex
                            justify-content-between
                            align-items-center">

                    <div>

                        <small class="text-muted">
                            Total Appointments
                        </small>

                        <h3 class="mt-2">
                            <%= totalAppointments %>
                        </h3>

                    </div>

                    <i class="bi bi-calendar-check
                              text-primary
                              stat-icon"></i>

                </div>

            </div>

        </div>


        <!-- PENDING -->

        <div class="col-md-6 col-xl-3">

            <div class="card stat-card p-3">

                <div class="d-flex
                            justify-content-between
                            align-items-center">

                    <div>

                        <small class="text-muted">
                            Pending
                        </small>

                        <h3 class="mt-2">
                            <%= pendingAppointments %>
                        </h3>

                    </div>

                    <i class="bi bi-hourglass-split
                              text-warning
                              stat-icon"></i>

                </div>

            </div>

        </div>


        <!-- COMPLETED -->

        <div class="col-md-6 col-xl-3">

            <div class="card stat-card p-3">

                <div class="d-flex
                            justify-content-between
                            align-items-center">

                    <div>

                        <small class="text-muted">
                            Completed
                        </small>

                        <h3 class="mt-2">
                            <%= completedAppointments %>
                        </h3>

                    </div>

                    <i class="bi bi-check-circle
                              text-success
                              stat-icon"></i>

                </div>

            </div>

        </div>


        <!-- PATIENTS -->

        <div class="col-md-6 col-xl-3">

            <div class="card stat-card p-3">

                <div class="d-flex
                            justify-content-between
                            align-items-center">

                    <div>

                        <small class="text-muted">
                            Total Patients
                        </small>

                        <h3 class="mt-2">
                            <%= totalPatients %>
                        </h3>

                    </div>

                    <i class="bi bi-people
                              text-danger
                              stat-icon"></i>

                </div>

            </div>

        </div>

    </div>


    <!-- =========================
         QUICK ACTIONS
    ========================= -->

    <div class="card
                shadow-sm
                border-0
                mb-4">

        <div class="card-body">

            <h5 class="mb-3">
                Quick Actions
            </h5>

            <a href="reception-add-appointment.jsp"
               class="btn btn-primary me-2">

                <i class="bi bi-calendar-plus"></i>
                Book Appointment

            </a>

            <a href="ReceptionAppointmentServlet"
               class="btn btn-outline-primary me-2">

                <i class="bi bi-calendar-check"></i>
                View Appointments

            </a>

            <a href="receptionBilling.jsp"
               class="btn btn-outline-success">

                <i class="bi bi-receipt"></i>
                View Billing

            </a>

        </div>

    </div>


    <!-- =========================
         RECENT APPOINTMENTS
    ========================= -->

    <div class="card
                shadow-sm
                border-0
                dashboard-table">

        <div class="card-header bg-white">

            <h5 class="mb-0">
                Recent Appointments
            </h5>

        </div>

        <div class="card-body">

            <div class="table-responsive">

                <table class="table table-hover">

                    <thead>

                    <tr>

                        <th>ID</th>

                        <th>Patient</th>

                        <th>Dentist</th>

                        <th>Date</th>

                        <th>Time</th>

                        <th>Status</th>

                    </tr>

                    </thead>

                    <tbody>

                    <%
                        int count = 0;

                        for (Appointment appointment :
                                appointments) {

                            if (count >= 5) {
                                break;
                            }

                            count++;
                    %>

                    <tr>

                        <td>
                            #<%= appointment.getAppointmentId() %>
                        </td>

                        <td>
                            <%= appointment.getPatientName() %>
                        </td>

                        <td>
                            <%= appointment.getDentistName() %>
                        </td>

                        <td>
                            <%= appointment.getAppointmentDate() %>
                        </td>

                        <td>
                            <%= appointment.getAppointmentTime() %>
                        </td>

                        <td>

                            <%
                                String status =
                                        appointment.getStatus();
                            %>

                            <% if ("Completed"
                                    .equalsIgnoreCase(status)) { %>

                                <span class="badge bg-success">
                                    Completed
                                </span>

                            <% } else if ("Pending"
                                    .equalsIgnoreCase(status)) { %>

                                <span class="badge bg-warning
                                             text-dark">
                                    Pending
                                </span>

                            <% } else { %>

                                <span class="badge bg-danger">

                                    <%= status %>

                                </span>

                            <% } %>

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

</body>

</html>