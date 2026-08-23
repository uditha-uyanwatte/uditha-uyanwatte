<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="dao.AppointmentDAO" %>
<%@ page import="model.Appointment" %>

<%
String id = request.getParameter("id");

Appointment appointment = null;

if(id != null){
    AppointmentDAO dao = new AppointmentDAO();
    appointment = dao.getAppointmentById(Integer.parseInt(id));
}
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Appointment Details</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
rel="stylesheet">

</head>

<body class="<%= session.getAttribute("theme") != null ? session.getAttribute("theme") : "light" %>">

<div class="container py-5">

<% if(appointment != null){ %>

<div class="card shadow">

<div class="card-header bg-primary text-white">

<h3>

<i class="bi bi-calendar-check"></i>

Appointment Details

</h3>

</div>

<div class="card-body">

<table class="table table-bordered">

<tr>
<th width="220">Appointment ID</th>
<td><%=appointment.getAppointmentId()%></td>
</tr>

<tr>
<th>Patient ID</th>
<td><%=appointment.getPatientId()%></td>
</tr>

<tr>
<th>Dentist ID</th>
<td><%=appointment.getDentistId()%></td>
</tr>

<tr>
<th>Appointment Date</th>
<td><%=appointment.getAppointmentDate()%></td>
</tr>

<tr>
<th>Appointment Time</th>
<td><%=appointment.getAppointmentTime()%></td>
</tr>

<tr>
<th>Treatment</th>
<td><%=appointment.getTreatment()%></td>
</tr>

<tr>
<th>Status</th>
<td>

<%
String status = appointment.getStatus();

if("Completed".equalsIgnoreCase(status)){
%>

<span class="badge bg-success">
Completed
</span>

<%
}else if("Pending".equalsIgnoreCase(status)){
%>

<span class="badge bg-warning text-dark">
Pending
</span>

<%
}else{
%>

<span class="badge bg-danger">
Cancelled
</span>

<%
}
%>

</td>
</tr>

<tr>
<th>Notes</th>
<td><%=appointment.getNotes()%></td>
</tr>

</table>

<div class="mt-4">

    <!-- BACK BUTTON -->
    <a href="appointments.jsp"
       class="btn btn-secondary">

        <i class="bi bi-arrow-left"></i>
        Back

    </a>


    <!-- EDIT BUTTON -->
    <a href="edit-appointment.jsp?id=<%=appointment.getAppointmentId()%>"
       class="btn btn-warning">

        <i class="bi bi-pencil-square"></i>
        Edit

    </a>


    <!-- GENERATE BILL BUTTON -->
    <a href="GenerateBillServlet?appointmentId=<%=appointment.getAppointmentId()%>"
       class="btn btn-success">

        <i class="bi bi-receipt"></i>
        Generate Bill

    </a>

</div>

</div>

</div>

<% } else { %>

<div class="alert alert-danger">

Appointment not found.

</div>

<a href="appointments.jsp"
class="btn btn-secondary">

Back

</a>

<% } %>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>