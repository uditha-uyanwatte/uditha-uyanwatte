<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.PatientDashboardDAO" %>
<%@ page import="model.User" %>
<%@ page import="model.Appointment"%>





<%
if (session.getAttribute("user") == null) {
    response.sendRedirect("login.jsp");
    return;
}

User loggedUser = (User) session.getAttribute("user");

PatientDashboardDAO patientDAO =
        new PatientDashboardDAO();

int userId = loggedUser.getId();

int patientId =
        patientDAO.getPatientIdByUserId(userId);

int upcomingAppointments =
        patientDAO.getUpcomingAppointments(patientId);

Appointment upcomingAppointment =
        patientDAO.getUpcomingAppointment(patientId);


int completedTreatments =
        patientDAO.getCompletedTreatments(patientId);

int totalBills =
        patientDAO.getTotalBills(patientId);

double totalPaid =
        patientDAO.getTotalPaidAmount(patientId);

double pendingAmount =
        patientDAO.getPendingAmount(patientId);
%>
<%
    // =========================
    // LOGIN CHECK
    // =========================

    if (session.getAttribute("user") == null) {

        response.sendRedirect("login.jsp");
        return;

    }

    String fullName =
            (String) session.getAttribute("fullName");

    String username =
            (String) session.getAttribute("username");

    String role =
            (String) session.getAttribute("role");

    if (fullName == null || fullName.trim().isEmpty()) {
        fullName = username;
    }
%>


<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Patient Dashboard | Sunrise Dental Clinic</title>


    <!-- Bootstrap -->

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">


    <!-- Bootstrap Icons -->

    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">


    <!-- Main CSS -->

    <link
        rel="stylesheet"
        href="assets/css/style.css">



</head>


<body>


<div class="patient-dashboard">


    <!-- =========================
         TOP BAR
    ========================= -->

    <div class="patient-topbar">

        <div class="container">

            <div class="d-flex justify-content-between align-items-center">


                <a href="index.jsp"
                   class="patient-logo">

                    <i class="bi bi-heart-pulse-fill"></i>

                    Sunrise Dental

                </a>


                <div class="patient-user">

                    <div>

                        <div class="patient-user-name">
                            <%= fullName %>
                        </div>

                        <div class="patient-user-role">
                            Patient
                        </div>

                    </div>


                    <div class="patient-avatar">

                        <i class="bi bi-person-fill"></i>

                    </div>


                    <a href="LogoutServlet"
                       class="logout-btn">

                        <i class="bi bi-box-arrow-right"></i>

                        Logout

                    </a>

                </div>

            </div>

        </div>

    </div>


    <!-- =========================
         MAIN CONTENT
    ========================= -->

    <div class="container">


        <!-- Welcome -->

        <div class="patient-welcome">

            <h1>
                Welcome back, <%= fullName %> 👋
            </h1>

            <p>
                Manage your appointments and keep track of
                your dental care with Sunrise Dental Clinic.
            </p>


            <a href="patient-appointment.jsp"
               class="book-btn">

                <i class="bi bi-calendar-plus"></i>

                Book Appointment

            </a>

        </div>


        <!-- =========================
             STATS
        ========================= -->

        <div class="row">


            <div class="col-lg-4 col-md-6">

                <div class="patient-stat">

                    <div class="stat-icon">

                        <i class="bi bi-calendar-check"></i>

                    </div>

                    <h3><%= upcomingAppointments %></h3>

                    <p>Upcoming Appointments</p>

                </div>

            </div>


            <div class="col-lg-4 col-md-6">

                <div class="patient-stat">

                    <div class="stat-icon">

                        <i class="bi bi-heart-pulse"></i>

                    </div>

                    <h3><%= completedTreatments %></h3>

                    <p>Completed Treatments</p>

                </div>

            </div>


            <div class="col-lg-4 col-md-6">

                <div class="patient-stat">

                    <div class="patient-stat">

                    <div class="stat-icon">

                        <i class="bi bi-receipt"></i>

                    </div>

                    <h3><%= totalBills %></h3>

                    <p>Total Bills</p>

                </div>

            </div>

        </div>


        <!-- =========================
             LOWER CONTENT
        ========================= -->

        <div class="row">


            <!-- Upcoming Appointment -->

            <div class="col-lg-7">

                <div class="patient-card">

                    <div class="patient-card-header">

                        <h4>
                            Upcoming Appointment
                        </h4>

                        <a href="appointments.jsp"
                           class="view-link">

                            View All

                        </a>

                    </div>


                   <div class="appointment-box">

<% if (upcomingAppointment != null) { %>

    <div class="appointment-date">

        <div class="appointment-icon">
            <i class="bi bi-calendar-event"></i>
        </div>

        <div>

            <h5>
                <%= upcomingAppointment.getAppointmentDate() %>
            </h5>

            <p>
                <i class="bi bi-clock"></i>
                <%= upcomingAppointment.getAppointmentTime() %>
            </p>

            <p>
                <i class="bi bi-person-badge"></i>
                Dr. <%= upcomingAppointment.getDentistName() %>
            </p>

            <p>
                <i class="bi bi-heart-pulse"></i>
                <%= upcomingAppointment.getTreatment() %>
            </p>

            <span class="badge bg-warning text-dark">
                <%= upcomingAppointment.getStatus() %>
            </span>

        </div>

    </div>

    <a href="appointments.jsp"
       class="btn btn-info text-white mt-3">

        View Appointment

    </a>

<% } else { %>

    <div class="appointment-date">

        <div class="appointment-icon">
            <i class="bi bi-calendar-event"></i>
        </div>

        <div>

            <h5>
                No Upcoming Appointment
            </h5>

            <p>
                You don't have any scheduled
                appointments yet.
            </p>

        </div>

    </div>

    <a href="patient-appointment.jsp"
       class="btn btn-info text-white mt-3">

        Book Your Appointment

    </a>

<% } %>

</div>

                </div>

            </div>


            <!-- Quick Actions -->

            <div class="col-lg-5">

                <div class="patient-card">

                    <div class="patient-card-header">

                        <h4>
                            Quick Actions
                        </h4>

                    </div>


                    <a href="patient-appointment.jsp"
                       class="quick-action">

                        <i class="bi bi-calendar-plus"></i>

                        <div>

                            <strong>
                                Book Appointment
                            </strong>

                            <small>
                                Schedule your next visit
                            </small>

                        </div>

                    </a>


                   <a href="my-appointments.jsp"
   class="quick-action">

                        <i class="bi bi-calendar2-check"></i>

                        <div>

                            <strong>
                                My Appointments
                            </strong>

                            <small>
                                View your appointments
                            </small>

                        </div>

                    </a>


                    <a href="my-profile.jsp"
                       class="quick-action">

                        <i class="bi bi-person-vcard"></i>

                        <div>

                            <strong>
                                My Profile
                            </strong>

                            <small>
                                View your personal information
                            </small>

                        </div>

                    </a>


                </div>

            </div>

        </div>


        <!-- =========================
             PROFILE INFORMATION
        ========================= -->

        <div class="row">


            <div class="col-lg-12">

                <div class="patient-card">

                    <div class="patient-card-header">

                        <h4>
                            My Account
                        </h4>

                        <span class="badge bg-info">
                            <%= role %>
                        </span>

                    </div>


                    <div class="profile-row">

                        <span class="profile-label">
                            Full Name
                        </span>

                        <span class="profile-value">
                            <%= fullName %>
                        </span>

                    </div>


                    <div class="profile-row">

                        <span class="profile-label">
                            Username
                        </span>

                        <span class="profile-value">
                            <%= username %>
                        </span>

                    </div>


                    <div class="profile-row">

                        <span class="profile-label">
                            Account Type
                        </span>

                        <span class="profile-value">
                            Patient
                        </span>

                    </div>


                </div>

            </div>

        </div>


    </div>

</div>


<!-- Bootstrap JS -->

<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>


</body>

</html>