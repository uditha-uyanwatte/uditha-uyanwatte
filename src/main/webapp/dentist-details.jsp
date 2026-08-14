<%@page import="dao.DentistDAO"%>
<%@page import="model.Dentist"%>

<%
int id = Integer.parseInt(request.getParameter("id"));

DentistDAO dao = new DentistDAO();

Dentist d = dao.getDentistById(id);
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Dentist Details</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

<link rel="stylesheet" href="css/dashboard.css">
<link rel="stylesheet" href="css/dentist.css">

</head>

<body class="<%= session.getAttribute("theme") != null ? session.getAttribute("theme") : "light" %>">

<div class="wrapper">

<jsp:include page="includes/sidebar.jsp"/>

<div class="main-content">

<jsp:include page="includes/navbar.jsp"/>

<div class="container-fluid mt-4">
<div class="row">

<div class="col-lg-4">

<div class="card shadow border-0 rounded-4">

<div class="card-body text-center">

<img src="images/doctor.png"
     width="120"
     class="rounded-circle mb-3">

<h3>

Dr. <%=d.getFirstName()%> <%=d.getLastName()%>

</h3>

<p class="text-muted">

<%=d.getSpecialization()%>

</p>


<hr>

<a href="edit-dentist.jsp?id=<%=d.getDentistId()%>"
class="btn btn-primary">

<i class="bi bi-pencil-square"></i>

Edit Dentist

</a>

</div>

</div>

</div>
<div class="col-lg-8">

<div class="card shadow border-0 rounded-4">

<div class="card-header bg-white">

<h4>

Dentist Information

</h4>

</div>

<div class="card-body">

<div class="row">

<div class="col-md-6 mb-3">

<label class="fw-bold">

Phone

</label>

<input
class="form-control"
value="<%=d.getPhone()%>"
readonly>

</div>

<div class="col-md-6 mb-3">

<label class="fw-bold">

Email

</label>

<input
class="form-control"
value="<%=d.getEmail()%>"
readonly>

</div>





</div>

</div>

</div>

</div>

</div>
</div>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>