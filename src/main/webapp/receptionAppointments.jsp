<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.Appointment"%>

<%
if (session.getAttribute("username") == null) {
    response.sendRedirect("login.jsp");
    return;
}

List<Appointment> appointments =
    (List<Appointment>) request.getAttribute("appointments");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reception Appointments</title>

<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet">

<style>
body {
    background: #f4f6f9;
    font-family: Arial, sans-serif;
}

.container-box {
    background: white;
    margin: 40px auto;
    padding: 30px;
    border-radius: 15px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.08);
}

.page-header {
    background: linear-gradient(135deg, #1e88e5, #1565c0);
    color: white;
    padding: 20px;
    border-radius: 12px;
    margin-bottom: 25px;
}

.status {
    padding: 5px 12px;
    border-radius: 20px;
    font-size: 13px;
    font-weight: bold;
    color: white;
}

.Pending {
    background: #f0ad00;
}

.Confirmed {
    background: #0d6efd;
}

.Completed {
    background: #198754;
}

.Cancelled {
    background: #dc3545;
}
</style>

</head>

<body>

<div class="container">

    <div class="container-box">

        <div class="page-header">
            <h2 class="mb-1">📅 Appointments</h2>
            <p class="mb-0">
                Manage and view patient appointments
            </p>
        </div>

        <div class="mb-4">
            <a href="receptionDashboard.jsp"
               class="btn btn-secondary">
                ← Back to Dashboard
            </a>

            <a href="AddAppointmentServlet"
               class="btn btn-primary">
                + Book Appointment
            </a>
        </div>

        <div class="table-responsive">

            <table class="table table-hover table-bordered align-middle">

                <thead class="table-dark">
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
                if (appointments != null && !appointments.isEmpty()) {

                    for (Appointment appointment : appointments) {
                %>

                    <tr>

                        <td>
                            #<%= appointment.getAppointmentId() %>
                        </td>

                        <td>
                            <%= appointment.getPatientName() != null
                                ? appointment.getPatientName()
                                : "N/A" %>
                        </td>

                        <td>
                            <%= appointment.getDentistName() != null
                                ? appointment.getDentistName()
                                : "N/A" %>
                        </td>

                        <td>
                            <%= appointment.getAppointmentDate() %>
                        </td>

                        <td>
                            <%= appointment.getAppointmentTime() %>
                        </td>

                        <td>

                            <span class="status
                                <%= appointment.getStatus() %>">

                                <%= appointment.getStatus() %>

                            </span>

                        </td>

                    </tr>

                <%
                    }
                } else {
                %>

                    <tr>
                        <td colspan="6"
                            class="text-center text-muted">

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