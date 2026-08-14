<%@page import="java.util.List"%>
<%@page import="dao.PatientDAO"%>
<%@page import="dao.DentistDAO"%>
<%@page import="dao.AppointmentDAO"%>
<%@page import="model.Patient"%>
<%@page import="model.Dentist"%>
<%@page import="model.Appointment"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
if(session.getAttribute("username")==null){
    response.sendRedirect("login.jsp");
    return;
}

int id = Integer.parseInt(request.getParameter("id"));

AppointmentDAO appointmentDAO = new AppointmentDAO();
Appointment appointment = appointmentDAO.getAppointmentById(id);

PatientDAO patientDAO = new PatientDAO();
DentistDAO dentistDAO = new DentistDAO();

List<Patient> patients = patientDAO.getAllPatients();
List<Dentist> dentists = dentistDAO.getAllDentists();
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Edit Appointment</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="assets/css/style.css">

</head>

<body class="<%= session.getAttribute("theme") != null ? session.getAttribute("theme") : "light" %>">

<jsp:include page="includes/sidebar.jsp"/>
<jsp:include page="includes/navbar.jsp"/>

<div class="main-content container">

<div class="card shadow">

<div class="card-header bg-warning">

<h4>Edit Appointment</h4>

</div>

<div class="card-body">

<form action="EditAppointmentServlet" method="post">

<input type="hidden"
name="id"
value="<%=appointment.getAppointmentId()%>">

<div class="row">
<div class="col-md-6 mb-3">

<label>Patient</label>

<select name="patientId"
class="form-select"
required>

<%
for(Patient p : patients){
%>

<option value="<%=p.getPatientId()%>"
<%=appointment.getPatientId()==p.getPatientId()?"selected":""%>>

<%=p.getFirstName()%> <%=p.getLastName()%>

</option>

<%
}
%>

</select>

</div>
<div class="col-md-6 mb-3">

<label>Dentist</label>

<select name="dentistId"
class="form-select"
required>

<%
for(Dentist d : dentists){
%>

<option value="<%=d.getDentistId()%>"
<%=appointment.getDentistId()==d.getDentistId()?"selected":""%>>

Dr. <%=d.getFirstName()%> <%=d.getLastName()%>

</option>

<%
}
%>

</select>

</div>
<div class="col-md-6 mb-3">

<label>Date</label>

<input type="date"
name="appointmentDate"
class="form-control"
value="<%=appointment.getAppointmentDate()%>"
required>

</div>

<div class="col-md-6 mb-3">

<label>Time</label>

<input type="time"
name="appointmentTime"
class="form-control"
value="<%=appointment.getAppointmentTime()%>"
required>

</div>
<div class="col-md-6 mb-3">

<label>Status</label>

<select name="status" class="form-select">

<option value="Pending"
<%=appointment.getStatus().equals("Pending")?"selected":""%>>
Pending
</option>

<option value="Confirmed"
<%=appointment.getStatus().equals("Confirmed")?"selected":""%>>
Confirmed
</option>

<option value="Completed"
<%=appointment.getStatus().equals("Completed")?"selected":""%>>
Completed
</option>

<option value="Cancelled"
<%=appointment.getStatus().equals("Cancelled")?"selected":""%>>
Cancelled
</option>

</select>

</div>
<div class="col-md-6 mb-3">

<label>Treatment</label>

<input type="text"
name="treatment"
class="form-control"
value="<%=appointment.getTreatment()%>"
required>

</div>

<div class="col-md-12 mb-3">

<label>Notes</label>

<textarea
name="notes"
rows="4"
class="form-control"><%=appointment.getNotes()%></textarea>

</div>

</div>

<button class="btn btn-primary">
Update Appointment
</button>

<a href="appointments.jsp"
class="btn btn-secondary">
Cancel
</a>

</form>

</div>

</div>

</div>

</body>
</html>