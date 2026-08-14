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

PatientDAO patientDAO = new PatientDAO();
DentistDAO dentistDAO = new DentistDAO();

List<Patient> patients = patientDAO.getAllPatients();
List<Dentist> dentists = dentistDAO.getAllDentists();
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Appointment Management</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link rel="stylesheet" href="assets/css/style.css">

</head>

<body class="<%= session.getAttribute("theme") != null ? session.getAttribute("theme") : "light" %>">

<jsp:include page="includes/sidebar.jsp"/>
<jsp:include page="includes/navbar.jsp"/>

<div class="main-content">

<div class="container-fluid p-4">

<div class="page-header mb-4">

    <div>

        <h2>

            <i class="bi bi-calendar2-check-fill"></i>

            Appointments

        </h2>

        <p>

            Manage appointments, schedules and treatments.

        </p>

    </div>

</div>

<% if(request.getParameter("success")!=null){ %>

<div class="alert alert-success">

Appointment Added Successfully.

</div>

<% } %>

<% if(request.getParameter("updated")!=null){ %>

<div class="alert alert-warning">

Appointment Updated Successfully.

</div>

<% } %>

<% if(request.getParameter("deleted")!=null){ %>

<div class="alert alert-danger">

Appointment Deleted Successfully.

</div>

<% } %>

<div class="table-card mb-4">

<h4 class="mb-4">

<i class="bi bi-calendar-plus-fill text-info"></i>

Add New Appointment

</h4>

<form action="AddAppointmentServlet" method="post">

<div class="row">

<div class="col-md-6 mb-3">

<label class="form-label">

Patient

</label>

<select
name="patientId"
class="form-select"
required>

<option value="">

Select Patient

</option>

<%
for(Patient p : patients){
%>

<option value="<%=p.getPatientId()%>">

<%=p.getFirstName()%> <%=p.getLastName()%>

</option>

<%
}
%>

</select>

</div>

<div class="col-md-6 mb-3">

<label class="form-label">

Dentist

</label>

<select
name="dentistId"
class="form-select"
required>

<option value="">

Select Dentist

</option>

<%
for(Dentist d : dentists){
%>

<option value="<%=d.getDentistId()%>">

Dr. <%=d.getFirstName()%> <%=d.getLastName()%>

</option>

<%
}
%>

</select>

</div>

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

<div class="col-md-6 mb-3">

<label class="form-label">

Status

</label>

<select
name="status"
class="form-select">

<option>Pending</option>

<option>Confirmed</option>

<option>Completed</option>

<option>Cancelled</option>

</select>

</div>

<div class="col-md-6 mb-3">

<label class="form-label">

Treatment

</label>

<input
type="text"
name="treatment"
class="form-control"
placeholder="Treatment Type"
required>

</div>

<div class="col-12 mb-3">

<label class="form-label">

Notes

</label>

<textarea
name="notes"
class="form-control"
rows="4"></textarea>

</div>

<div class="col-12">

<button
type="submit"
class="save-btn">

<i class="bi bi-check2-circle"></i>

Save Appointment

</button>

</div>

</div>

</form>

</div>

<%
AppointmentDAO appointmentDAO = new AppointmentDAO();

String keyword = request.getParameter("search");

List<Appointment> appointments;

if(keyword != null && !keyword.trim().isEmpty()){

appointments = appointmentDAO.searchAppointments(keyword);

}else{

appointments = appointmentDAO.getAllAppointments();

}
%>
<div class="table-card">

    <div class="d-flex justify-content-between align-items-center mb-4">

        <h4>

            <i class="bi bi-calendar-check-fill text-info"></i>

            Appointment Records

        </h4>

        <span class="badge bg-info">

            <%= appointments.size() %> Appointments

        </span>

    </div>

    <form method="get">

        <div class="row g-3 align-items-center">

            <div class="col-lg-10">

                <div class="input-group">

                    <span class="input-group-text bg-dark border-info text-info">

                        <i class="bi bi-search"></i>

                    </span>

                    <input
                        type="text"
                        name="search"
                        class="form-control search-input"
                        placeholder="Search by Patient, Dentist, Date, Treatment..."
                        value="<%= keyword == null ? "" : keyword %>">

                </div>

            </div>

            <div class="col-lg-2 d-grid">

                <button
                    type="submit"
                    class="btn btn-info fw-bold">

                    <i class="bi bi-search"></i>

                    Search

                </button>

            </div>

        </div>

    </form>

    <div class="mt-3">

        <a href="appointments.jsp"
           class="btn btn-outline-light">

            <i class="bi bi-arrow-clockwise"></i>

            Reset

        </a>

    </div>

    <hr class="my-4">

    <div class="table-responsive">

    <table class="table patient-table align-middle">

        <thead>

        <tr>

            <th>ID</th>

            <th>Patient</th>

            <th>Dentist</th>

            <th>Date</th>

            <th>Time</th>

            <th>Status</th>

            <th>Treatment</th>

            <th>Notes</th>

            <th class="text-center">Actions</th>

        </tr>

        </thead>

        <tbody>
<%
for(Appointment a : appointments){

    Patient patient = patientDAO.getPatientById(a.getPatientId());
    Dentist dentist = dentistDAO.getDentistById(a.getDentistId());
%>

<tr>

    <td>

        <span class="patient-id">

            #<%=a.getAppointmentId()%>

        </span>

    </td>

    <td>

        <div class="d-flex align-items-center">

            <div class="patient-avatar">

                <i class="bi bi-person-fill"></i>

            </div>

            <div class="ms-3">

                <strong>

                    <%=patient.getFirstName()%> <%=patient.getLastName()%>

                </strong>

            </div>

        </div>

    </td>

    <td>

        <div class="d-flex align-items-center">

            <div class="patient-avatar">

                <i class="bi bi-person-badge-fill"></i>

            </div>

            <div class="ms-3">

                <strong>

                    Dr. <%=dentist.getFirstName()%> <%=dentist.getLastName()%>

                </strong>

            </div>

        </div>

    </td>

    <td>

        <%=a.getAppointmentDate()%>

    </td>

    <td>

        <%=a.getAppointmentTime()%>

    </td>

    <td>

    <%
    if("Completed".equalsIgnoreCase(a.getStatus())){
    %>

        <span class="badge bg-success">

            Completed

        </span>

    <%
    }else if("Confirmed".equalsIgnoreCase(a.getStatus())){
    %>

        <span class="badge bg-primary">

            Confirmed

        </span>

    <%
    }else if("Pending".equalsIgnoreCase(a.getStatus())){
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

    <td>

        <%=a.getTreatment()%>

    </td>

    <td>

        <%=a.getNotes()%>

    </td>

    <td class="text-center">

        <a href="edit-appointment.jsp?id=<%=a.getAppointmentId()%>"

           class="btn btn-warning btn-sm rounded-circle me-2">

            <i class="bi bi-pencil"></i>

        </a>

        <a href="DeleteAppointmentServlet?id=<%=a.getAppointmentId()%>"

           class="btn btn-danger btn-sm rounded-circle"

           onclick="return confirm('Delete this appointment?');">

            <i class="bi bi-trash"></i>

        </a>

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

</body>

</html>