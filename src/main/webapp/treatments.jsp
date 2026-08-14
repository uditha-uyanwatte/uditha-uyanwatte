<%@page import="java.util.List"%>
<%@page import="dao.AppointmentDAO"%>
<%@page import="dao.TreatmentDAO"%>
<%@page import="model.Appointment"%>
<%@page import="model.Treatment"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
if(session.getAttribute("username")==null){
    response.sendRedirect("login.jsp");
    return;
}

AppointmentDAO appointmentDAO = new AppointmentDAO();
TreatmentDAO treatmentDAO = new TreatmentDAO();

List<Appointment> appointments = appointmentDAO.getAllAppointments();
String keyword = request.getParameter("search");

List<Treatment> treatments;

if(keyword != null && !keyword.trim().isEmpty()){

    treatments = treatmentDAO.searchTreatments(keyword);

}else{

    treatments = treatmentDAO.getAllTreatments();

}
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Treatment Management</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link rel="stylesheet" href="assets/css/style.css">

</head>

<body class="<%= session.getAttribute("theme") != null ? session.getAttribute("theme") : "light" %>">

<jsp:include page="includes/sidebar.jsp"/>
<jsp:include page="includes/navbar.jsp"/>

<div class="main-content container-fluid">

<h2 class="mb-4">Treatment Management</h2>

<% if(request.getParameter("success")!=null){ %>
<div class="alert alert-success">Treatment added successfully.</div>
<% } %>

<% if(request.getParameter("updated")!=null){ %>
<div class="alert alert-warning">Treatment updated successfully.</div>
<% } %>

<% if(request.getParameter("deleted")!=null){ %>
<div class="alert alert-danger">Treatment deleted successfully.</div>
<% } %>

<div class="card shadow mb-4">

<div class="card-header bg-primary text-white">
<h5>Add Treatment</h5>
</div>

<div class="card-body">

<form action="AddTreatmentServlet" method="post">

<div class="row">

<div class="col-md-6 mb-3">

<label>Appointment</label>

<select name="appointmentId" class="form-select" required>

<option value="">Select Appointment</option>

<%
for(Appointment a : appointments){
%>

<option value="<%=a.getAppointmentId()%>">
Appointment #<%=a.getAppointmentId()%>
</option>

<%
}
%>

</select>

</div>

<div class="col-md-6 mb-3">

<label>Treatment Name</label>

<input type="text"
name="treatmentName"
class="form-control"
required>

</div>

<div class="col-md-12 mb-3">

<label>Description</label>

<textarea
name="description"
rows="3"
class="form-control"></textarea>

</div>

<div class="col-md-6 mb-3">

<label>Cost</label>

<input
type="number"
step="0.01"
name="cost"
class="form-control"
required>

</div>

</div>

<button class="btn btn-primary">

<i class="bi bi-plus-circle"></i>

Add Treatment

</button>

</form>

</div>

</div>
<div class="card shadow">

<div class="card-header bg-dark text-white">

<h5>All Treatments</h5>

</div>

<div class="card-body">

<form method="get" class="row mb-3">

    <div class="col-md-10">

        <input
            type="text"
            name="search"
            class="form-control"
            placeholder="Search by Treatment Name, Description or Cost..."
            value="<%= keyword == null ? "" : keyword %>">

    </div>

    <div class="col-md-2 d-grid">

        <button type="submit" class="btn btn-primary">
            <i class="bi bi-search"></i> Search
        </button>

    </div>
<a href="treatments.jsp" class="btn btn-secondary mb-3">
    <i class="bi bi-arrow-clockwise"></i> Reset
</a>
</form>



<table class="table table-bordered table-hover">

<thead class="table-primary">

<tr>

<th>ID</th>
<th>Appointment</th>
<th>Name</th>
<th>Description</th>
<th>Cost</th>
<th width="180">Actions</th>

</tr>

</thead>

<tbody>

<%
for(Treatment t : treatments){
%>

<tr>

<td><%=t.getTreatmentId()%></td>

<td>Appointment #<%=t.getAppointmentId()%></td>

<td><%=t.getTreatmentName()%></td>

<td><%=t.getDescription()%></td>

<td><%=String.format("%.2f", t.getCost())%></td>

<td>

<a href="edit-treatment.jsp?id=<%=t.getTreatmentId()%>"
class="btn btn-warning btn-sm">

<i class="bi bi-pencil-square"></i>

Edit

</a>

<a href="DeleteTreatmentServlet?id=<%=t.getTreatmentId()%>"
class="btn btn-danger btn-sm"
onclick="return confirm('Delete this treatment?')">

<i class="bi bi-trash"></i>

Delete

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

</body>

</html>