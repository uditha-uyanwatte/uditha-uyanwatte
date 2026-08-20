<%@ page import="java.util.List" %>
<%@ page import="model.Dentist" %>
<%@ page import="model.Appointment" %>

<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Dentist dentist =
            (Dentist) request.getAttribute("dentist");

    List<Appointment> appointments =
            (List<Appointment>) request.getAttribute("appointments");

    if (dentist == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Dentist Dashboard | Sunrise Dental</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: #eefaff;
            color: #092b38;
        }

        /* =========================
           SIDEBAR
        ========================= */

        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: 250px;
            height: 100vh;
            background: #062f38;
            color: white;
            padding: 25px 18px;
            z-index: 1000;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 23px;
            font-weight: 800;
            margin-bottom: 40px;
        }

        .logo-icon {
            width: 42px;
            height: 42px;
            background: #18c7e8;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 22px;
        }

        .nav-item {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 14px 16px;
            border-radius: 12px;
            margin-bottom: 8px;
            color: #c8e1e7;
            text-decoration: none;
            font-weight: 600;
        }

        .nav-item:hover,
        .nav-item.active {
            background: #0c5360;
            color: #20d4f1;
        }

        .nav-item i {
            font-size: 19px;
        }

        .logout {
            position: absolute;
            bottom: 25px;
            left: 18px;
            right: 18px;
            color: #ff9e9e;
        }

        /* =========================
           MAIN
        ========================= */

        .main {
            margin-left: 250px;
            padding: 30px 40px;
        }

        /* =========================
           TOP BAR
        ========================= */

        .topbar {
            background: white;
            border-radius: 18px;
            padding: 18px 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            box-shadow: 0 8px 30px rgba(0, 60, 80, 0.06);
        }

        .topbar-title {
            font-size: 24px;
            font-weight: 800;
        }

        .doctor-profile {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .doctor-avatar {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            background: #18c7e8;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 23px;
        }

        .doctor-name {
            font-weight: 800;
        }

        .doctor-role {
            color: #78909c;
            font-size: 13px;
        }

        /* =========================
           WELCOME
        ========================= */

        .welcome {
            background: linear-gradient(
                135deg,
                #07353e,
                #095563
            );
            border-radius: 22px;
            padding: 30px;
            color: white;
            margin-bottom: 28px;
            position: relative;
            overflow: hidden;
        }

        .welcome h2 {
            font-weight: 800;
            margin-bottom: 8px;
        }

        .welcome p {
            margin: 0;
            color: #bde7ef;
        }

        .welcome-icon {
            position: absolute;
            right: 45px;
            top: 20px;
            font-size: 100px;
            color: rgba(32, 212, 241, 0.15);
        }

        /* =========================
           STAT CARDS
        ========================= */

        .stat-card {
            background: white;
            border-radius: 18px;
            padding: 22px;
            box-shadow: 0 8px 25px rgba(0, 60, 80, 0.06);
            height: 100%;
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 14px;
            background: #dff9ff;
            color: #08bada;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-bottom: 15px;
        }

        .stat-number {
            font-size: 30px;
            font-weight: 800;
        }

        .stat-label {
            color: #758892;
            font-weight: 600;
        }

        /* =========================
           APPOINTMENTS
        ========================= */

        .section-card {
            background: white;
            border-radius: 20px;
            padding: 25px;
            margin-top: 28px;
            box-shadow: 0 8px 30px rgba(0, 60, 80, 0.06);
        }

        .section-title {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 22px;
        }

        .section-title h4 {
            margin: 0;
            font-weight: 800;
        }

        .appointment-table {
            width: 100%;
            border-collapse: collapse;
        }

        .appointment-table th {
            background: #f1fbfd;
            color: #4d6973;
            padding: 15px;
            font-size: 14px;
            text-align: left;
        }

        .appointment-table td {
            padding: 16px 15px;
            border-bottom: 1px solid #edf3f5;
            vertical-align: middle;
        }

        .appointment-table tr:hover {
            background: #fbfeff;
        }

        .patient-name {
            font-weight: 800;
        }

        .patient-icon {
            width: 40px;
            height: 40px;
            border-radius: 12px;
            background: #dff9ff;
            color: #0bbdda;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-right: 10px;
        }

        /* =========================
           STATUS
        ========================= */

        .status {
            padding: 7px 13px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 800;
            display: inline-block;
        }

        .pending {
            background: #fff3cd;
            color: #946c00;
        }

        .confirmed {
            background: #dcecff;
            color: #1260a0;
        }

        .completed {
            background: #d9f8e8;
            color: #16804b;
        }

        .cancelled {
            background: #ffe0e0;
            color: #c62828;
        }

        /* =========================
           BUTTONS
        ========================= */

        .action-btn {
            border: none;
            border-radius: 9px;
            padding: 7px 10px;
            margin-right: 4px;
            font-size: 13px;
            font-weight: 700;
        }

        .confirm-btn {
            background: #d9f8e8;
            color: #16804b;
        }

        .complete-btn {
            background: #dcecff;
            color: #1260a0;
        }

        .cancel-btn {
            background: #ffe0e0;
            color: #c62828;
        }

        .action-btn:hover {
            opacity: 0.8;
        }

        .empty {
            text-align: center;
            padding: 50px;
            color: #8399a1;
        }

        /* =========================
           RESPONSIVE
        ========================= */

        @media(max-width: 900px) {

            .sidebar {
                width: 75px;
                padding: 20px 10px;
            }

            .logo span,
            .nav-item span {
                display: none;
            }

            .nav-item {
                justify-content: center;
            }

            .main {
                margin-left: 75px;
                padding: 20px;
            }

            .appointment-table {
                min-width: 1000px;
            }

            .table-wrapper {
                overflow-x: auto;
            }
        }

    </style>

</head>

<body>

<!-- =========================
     SIDEBAR
========================= -->

<div class="sidebar">

    <div class="logo">

        <div class="logo-icon">
            <i class="bi bi-heart-pulse-fill"></i>
        </div>

        <span>Sunrise Dental</span>

    </div>


    <a href="DentistDashboardServlet"
       class="nav-item active">

        <i class="bi bi-grid-1x2-fill"></i>

        <span>Dashboard</span>

    </a>


    <a href="DentistDashboardServlet"
       class="nav-item">

        <i class="bi bi-calendar2-check-fill"></i>

        <span>Appointments</span>

    </a>


    <a href="patient-records.jsp"
       class="nav-item">

        <i class="bi bi-people-fill"></i>

        <span>Patients</span>

    </a>


    <a href="profile.jsp"
       class="nav-item">

        <i class="bi bi-person-circle"></i>

        <span>My Profile</span>

    </a>


    <a href="LogoutServlet"
       class="nav-item logout">

        <i class="bi bi-box-arrow-right"></i>

        <span>Logout</span>

    </a>

</div>


<!-- =========================
     MAIN
========================= -->

<div class="main">

    <!-- TOP BAR -->

    <div class="topbar">

        <div class="topbar-title">

            Dentist Dashboard

        </div>

        <div class="doctor-profile">

            <div class="doctor-avatar">

                <i class="bi bi-person-badge-fill"></i>

            </div>

            <div>

                <div class="doctor-name">

                    Dr. <%= dentist.getFirstName() %>
                    <%= dentist.getLastName() %>

                </div>

                <div class="doctor-role">

                    <%= dentist.getSpecialization() %>

                </div>

            </div>

        </div>

    </div>


    <!-- WELCOME -->

    <div class="welcome">

        <h2>
            Welcome, Dr.
            <%= dentist.getFirstName() %>
        </h2>

        <p>
            Manage your appointments and patient visits
            from your dashboard.
        </p>

        <i class="bi bi-heart-pulse-fill welcome-icon"></i>

    </div>


    <!-- =========================
         STATISTICS
    ========================= -->

    <div class="row g-4">

        <%

            int total = 0;
            int pending = 0;
            int confirmed = 0;
            int completed = 0;

            if (appointments != null) {

                total = appointments.size();

                for (Appointment a : appointments) {

                    if ("Pending".equalsIgnoreCase(
                            a.getStatus())) {

                        pending++;

                    } else if ("Confirmed".equalsIgnoreCase(
                            a.getStatus())) {

                        confirmed++;

                    } else if ("Completed".equalsIgnoreCase(
                            a.getStatus())) {

                        completed++;
                    }
                }
            }
        %>


        <div class="col-lg-3 col-md-6">

            <div class="stat-card">

                <div class="stat-icon">
                    <i class="bi bi-calendar-check"></i>
                </div>

                <div class="stat-number">
                    <%= total %>
                </div>

                <div class="stat-label">
                    Total Appointments
                </div>

            </div>

        </div>


        <div class="col-lg-3 col-md-6">

            <div class="stat-card">

                <div class="stat-icon">
                    <i class="bi bi-hourglass-split"></i>
                </div>

                <div class="stat-number">
                    <%= pending %>
                </div>

                <div class="stat-label">
                    Pending
                </div>

            </div>

        </div>


        <div class="col-lg-3 col-md-6">

            <div class="stat-card">

                <div class="stat-icon">
                    <i class="bi bi-check-circle"></i>
                </div>

                <div class="stat-number">
                    <%= confirmed %>
                </div>

                <div class="stat-label">
                    Confirmed
                </div>

            </div>

        </div>


        <div class="col-lg-3 col-md-6">

            <div class="stat-card">

                <div class="stat-icon">
                    <i class="bi bi-check2-all"></i>
                </div>

                <div class="stat-number">
                    <%= completed %>
                </div>

                <div class="stat-label">
                    Completed
                </div>

            </div>

        </div>

    </div>


    <!-- =========================
         APPOINTMENT TABLE
    ========================= -->

    <div class="section-card">

        <div class="section-title">

            <h4>

                <i class="bi bi-calendar2-week text-info"></i>

                My Appointments

            </h4>

            <span class="badge bg-info">

                <%= total %> Appointments

            </span>

        </div>


        <div class="table-wrapper">

            <table class="appointment-table">

                <thead>

                <tr>

                    <th>ID</th>

                    <th>Patient</th>

                    <th>Date</th>

                    <th>Time</th>

                    <th>Treatment</th>

                    <th>Notes</th>

                    <th>Status</th>

                    <th>Actions</th>

                </tr>

                </thead>


                <tbody>

                <%

                    if (appointments != null &&
                        !appointments.isEmpty()) {

                        for (Appointment a :
                                appointments) {

                            String status =
                                    a.getStatus();

                %>

                <tr>

                    <!-- ID -->

                    <td>

                        <strong>
                            #<%= a.getAppointmentId() %>
                        </strong>

                    </td>


                    <!-- PATIENT -->

                    <td>

                        <div class="d-flex align-items-center">

                            <div class="patient-icon">

                                <i class="bi bi-person-fill"></i>

                            </div>

                            <div class="patient-name">

                                <%= a.getPatientName() != null
                                    ? a.getPatientName()
                                    : "Patient" %>

                            </div>

                        </div>

                    </td>


                    <!-- DATE -->

                    <td>

                        <strong>
                            <%= a.getAppointmentDate() %>
                        </strong>

                    </td>


                    <!-- TIME -->

                    <td>

                        <i class="bi bi-clock text-info"></i>

                        <%= a.getAppointmentTime() %>

                    </td>


                    <!-- TREATMENT -->

                    <td>

                        <%= a.getTreatment() != null
                            ? a.getTreatment()
                            : "-" %>

                    </td>


                    <!-- NOTES -->

                    <td>

                        <%= a.getNotes() != null &&
                            !a.getNotes().isEmpty()
                            ? a.getNotes()
                            : "-" %>

                    </td>


                    <!-- STATUS -->

                    <td>

                        <%

                            if ("Pending".equalsIgnoreCase(
                                    status)) {

                        %>

                            <span class="status pending">
                                Pending
                            </span>

                        <%

                            } else if (
                                "Confirmed".equalsIgnoreCase(
                                    status)) {

                        %>

                            <span class="status confirmed">
                                Confirmed
                            </span>

                        <%

                            } else if (
                                "Completed".equalsIgnoreCase(
                                    status)) {

                        %>

                            <span class="status completed">
                                Completed
                            </span>

                        <%

                            } else {

                        %>

                            <span class="status cancelled">
                                Cancelled
                            </span>

                        <%

                            }

                        %>

                    </td>


                    <!-- ACTIONS -->

                    <td>

                        <%

                            if (!"Completed".equalsIgnoreCase(
                                    status) &&
                                !"Cancelled".equalsIgnoreCase(
                                    status)) {

                        %>

                        <form
                            action="UpdateAppointmentStatusServlet"
                            method="post"
                            style="display:inline;">

                            <input
                                type="hidden"
                                name="appointmentId"
                                value="<%= a.getAppointmentId() %>">

                            <input
                                type="hidden"
                                name="status"
                                value="Confirmed">

                            <button
                                type="submit"
                                class="action-btn confirm-btn">

                                <i class="bi bi-check-circle"></i>

                                Confirm

                            </button>

                        </form>


                        <form
                            action="UpdateAppointmentStatusServlet"
                            method="post"
                            style="display:inline;">

                            <input
                                type="hidden"
                                name="appointmentId"
                                value="<%= a.getAppointmentId() %>">

                            <input
                                type="hidden"
                                name="status"
                                value="Completed">

                            <button
                                type="submit"
                                class="action-btn complete-btn">

                                <i class="bi bi-check2-all"></i>

                                Complete

                            </button>

                        </form>


                        <form
                            action="UpdateAppointmentStatusServlet"
                            method="post"
                            style="display:inline;">

                            <input
                                type="hidden"
                                name="appointmentId"
                                value="<%= a.getAppointmentId() %>">

                            <input
                                type="hidden"
                                name="status"
                                value="Cancelled">

                            <button
                                type="submit"
                                class="action-btn cancel-btn"
                                onclick="return confirm('Cancel this appointment?');">

                                <i class="bi bi-x-circle"></i>

                                Cancel

                            </button>

                        </form>

                        <%

                            } else {

                        %>

                            <span class="text-muted">
                                No actions
                            </span>

                        <%

                            }

                        %>

                    </td>

                </tr>

                <%

                        }

                    } else {

                %>

                <tr>

                    <td colspan="8"
                        class="empty">

                        <i class="bi bi-calendar-x"
                           style="font-size:45px;"></i>

                        <br><br>

                        No appointments found.

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

</body>

</html>