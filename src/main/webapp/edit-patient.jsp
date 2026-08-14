<%@ page import="dao.PatientDAO" %>
<%@ page import="model.Patient" %>

<%
if(session.getAttribute("user")==null){
    response.sendRedirect("login.jsp");
    return;
}

int id = Integer.parseInt(request.getParameter("id"));

PatientDAO dao = new PatientDAO();
Patient patient = dao.getPatientById(id);
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Edit Patient</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="<%= session.getAttribute("theme") != null ? session.getAttribute("theme") : "light" %>">

<h2>Edit Patient</h2>

<form action="EditPatientServlet" method="post">

<input type="hidden" name="patientId" value="<%=patient.getPatientId()%>">

<div class="mb-3">
<label>First Name</label>
<input type="text" class="form-control"
name="firstName"
value="<%=patient.getFirstName()%>">
</div>

<div class="mb-3">
<label>Last Name</label>
<input type="text"
class="form-control"
name="lastName"
value="<%=patient.getLastName()%>">
</div>

<div class="mb-3">

<label>Gender</label>

<select class="form-select" name="gender">

<option <%=patient.getGender().equals("Male")?"selected":""%>>Male</option>

<option <%=patient.getGender().equals("Female")?"selected":""%>>Female</option>

</select>

</div>

<div class="mb-3">
<label>Date of Birth</label>
<input type="date"
class="form-control"
name="dateOfBirth"
value="<%=patient.getDateOfBirth()%>">
</div>

<div class="mb-3">
<label>Phone</label>
<input type="text"
class="form-control"
name="phone"
value="<%=patient.getPhone()%>">
</div>

<div class="mb-3">
<label>Email</label>
<input type="email"
class="form-control"
name="email"
value="<%=patient.getEmail()%>">
</div>

<div class="mb-3">
<label>Address</label>
<textarea class="form-control"
name="address"><%=patient.getAddress()%></textarea>
</div>

<button class="btn btn-success">
Update Patient
</button>

<a href="patients.jsp" class="btn btn-secondary">
Cancel
</a>

</form>

</body>
</html>