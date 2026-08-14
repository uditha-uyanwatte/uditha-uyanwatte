




<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ page import="java.util.List" %>
<%@ page import="dao.PatientDAO" %>
<%@ page import="model.Patient" %>

<%
if(session.getAttribute("user")==null){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Patients</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

<link rel="stylesheet" href="assets/css/style.css">

</head>

<body class="<%= session.getAttribute("theme") != null ? session.getAttribute("theme") : "light" %>">

<jsp:include page="includes/sidebar.jsp"/>
<jsp:include page="includes/navbar.jsp"/>

<div class="main-content">

<div class="container-fluid p-4">

    <div class="page-header mb-4">

        <div>

            <h2><i class="bi bi-people-fill"></i> Patients</h2>

            <p>Manage all patient records and registrations.</p>

        </div>

    </div>

<div class="table-card mb-4">

    <h4 class="mb-4">

        <i class="bi bi-person-plus-fill text-info"></i>

        Add New Patient

    </h4>

<% if(request.getParameter("success")!=null){ %>

<div class="alert alert-success">

Patient Added Successfully!

</div>

<% } %>

<% if(request.getParameter("error")!=null){ %>

<div class="alert alert-danger">

Failed to Add Patient!

</div>

<% } %>

<% if(request.getParameter("deleted") != null){ %>

<div class="alert alert-success">
    Patient Deleted Successfully!
</div>

<% } %>

<% if(request.getParameter("updated") != null){ %>

<div class="alert alert-success">
    Patient Updated Successfully!
</div>

<% } %>

<form action="AddPatientServlet" method="post">

<div class="row">

<div class="col-md-6 mb-3">

<label>First Name</label>

<input type="text" name="firstName" class="form-control" required>

</div>

<div class="col-md-6 mb-3">

<label>Last Name</label>

<input type="text" name="lastName" class="form-control" required>

</div>

<div class="col-md-6 mb-3">

<label>Gender</label>

<select name="gender" class="form-select">

<option>Male</option>
<option>Female</option>

</select>

</div>

<div class="col-md-6 mb-3">

<label>Date of Birth</label>

<input type="date" name="dateOfBirth" class="form-control">

</div>

<div class="col-md-6 mb-3">

<label>Phone</label>

<input type="text" name="phone" class="form-control">

</div>

<div class="col-md-6 mb-3">

<label>Email</label>

<input type="email" name="email" class="form-control">

</div>

<div class="col-12 mb-3">

<label>Address</label>

<textarea name="address" class="form-control"></textarea>

</div>

<div class="col-12">

<button class="save-btn">
    <i class="bi bi-check2-circle"></i>
    Save Patient
</button>

</div>

</div>



</form>
</div>
<hr class="my-5">

<div class="table-card">

    <div class="d-flex justify-content-between align-items-center mb-4">

        <h4>
            <i class="bi bi-card-list text-info"></i>
            Patient Records
        </h4>

        <span class="badge bg-info">
            Patient Records
        </span>

    </div>
<%
PatientDAO patientDAO = new PatientDAO();

String keyword = request.getParameter("search");

List<Patient> patientList;

if(keyword != null && !keyword.trim().isEmpty()){

    patientList = patientDAO.searchPatients(keyword);

}else{

    patientList = patientDAO.getAllPatients();

}


%>
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
                    placeholder="Search patient by Name, Phone or Email..."
                    value="<%= keyword == null ? "" : keyword %>">

            </div>

        </div>

        <div class="col-lg-2 d-grid">

            <button class="btn btn-info fw-bold">

                <i class="bi bi-search"></i>

                Search

            </button>

        </div>

    </div>

</form>

<div class="mt-3">

    <a href="patients.jsp" class="btn btn-outline-light">

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

        <th>Gender</th>

        <th>Date of Birth</th>

        <th>Phone</th>

        <th>Email</th>

        <th>Address</th>

        <th class="text-center">Actions</th>

    </tr>

    </thead>

    <tbody>

    <%
    for(Patient p : patientList){
    %>

    <tr>

        <td>
            <span class="patient-id">
                #<%= p.getPatientId() %>
            </span>
        </td>

        <td>

            <div class="d-flex align-items-center">

                <div class="patient-avatar">

                    <i class="bi bi-person-fill"></i>

                </div>

                <div class="ms-3">

                    <strong>

                        <%= p.getFirstName() %> <%= p.getLastName() %>

                    </strong>

                </div>

            </div>

        </td>

        <td>

        <% if("Male".equalsIgnoreCase(p.getGender())){ %>

            <span class="badge bg-primary">Male</span>

        <% }else{ %>

            <span class="badge bg-danger">Female</span>

        <% } %>

        </td>

        <td><%= p.getDateOfBirth() %></td>

        <td><%= p.getPhone() %></td>

        <td><%= p.getEmail() %></td>

        <td><%= p.getAddress() %></td>

        <td class="text-center">

            <a href="edit-patient.jsp?id=<%=p.getPatientId()%>"
               class="btn btn-warning btn-sm rounded-circle me-2">

                <i class="bi bi-pencil"></i>

            </a>

            <a href="DeletePatientServlet?id=<%=p.getPatientId()%>"
               class="btn btn-danger btn-sm rounded-circle"
               onclick="return confirm('Delete this patient?');">

                <i class="bi bi-trash"></i>

            </a>

        </td>

    </tr>

    <% } %>

    </tbody>

</table>

</div>

</div>

</div>


</div>

</div>

</body>

</html>