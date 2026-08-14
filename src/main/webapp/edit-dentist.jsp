<%@page import="dao.DentistDAO"%>
<%@page import="model.Dentist"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
if(session.getAttribute("username")==null){
    response.sendRedirect("login.jsp");
    return;
}

int id=Integer.parseInt(request.getParameter("id"));

DentistDAO dao=new DentistDAO();
Dentist d=dao.getDentistById(id);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Dentist</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="assets/css/style.css">
</head>

<body class="<%= session.getAttribute("theme") != null ? session.getAttribute("theme") : "light" %>">

<jsp:include page="includes/sidebar.jsp"/>
<jsp:include page="includes/navbar.jsp"/>

<div class="main-content container">

<div class="card shadow">

<div class="card-header">
<h3>Edit Dentist</h3>
</div>

<div class="card-body">

<form action="EditDentistServlet" method="post">

<input type="hidden" name="id" value="<%=d.getDentistId()%>">

<div class="row">

<div class="col-md-6 mb-3">
<label>First Name</label>
<input type="text"
name="firstName"
class="form-control"
value="<%=d.getFirstName()%>"
required>
</div>

<div class="col-md-6 mb-3">
<label>Last Name</label>
<input type="text"
name="lastName"
class="form-control"
value="<%=d.getLastName()%>"
required>
</div>

<div class="col-md-6 mb-3">
<label>Specialization</label>
<input type="text"
name="specialization"
class="form-control"
value="<%=d.getSpecialization()%>"
required>
</div>

<div class="col-md-6 mb-3">
<label>Phone</label>
<input type="text"
name="phone"
class="form-control"
value="<%=d.getPhone()%>">
</div>

<div class="col-md-12 mb-3">
<label>Email</label>
<input type="email"
name="email"
class="form-control"
value="<%=d.getEmail()%>">
</div>

</div>

<button class="btn btn-primary">
Update Dentist
</button>

<a href="dentists.jsp" class="btn btn-secondary">
Cancel
</a>

</form>

</div>

</div>

</div>

</body>
</html>