<%@page import="dao.PatientDAO"%>
<%@page import="model.Patient"%>

<%
int id = Integer.parseInt(request.getParameter("id"));

PatientDAO dao = new PatientDAO();

Patient p = dao.getPatientById(id);
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Patient Details</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

<link rel="stylesheet" href="css/dashboard.css">
<link rel="stylesheet" href="css/patient.css">

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

<img src="images/user.png"
width="130"
height="130"
class="rounded-circle mb-3">

<h3>

<%=p.getFirstName()%>

<%=p.getLastName()%>

</h3>

<p class="text-muted">

Patient ID :

<%=p.getPatientId()%>

</p>

<hr>

<div class="row">

<div class="col-6">

<h6>

Gender

</h6>

<p>

<%=p.getGender()%>

</p>

</div>

<div class="col-6">

<h6>

DOB

</h6>

<p>

<%= p.getDateOfBirth() %>

</p>

</div>

</div>

<a href="edit-patient.jsp?id=<%=p.getPatientId()%>"
class="btn btn-warning w-100 mt-3">

<i class="bi bi-pencil-square"></i>

Edit Patient

</a>

</div>

</div>

</div>

<div class="col-lg-8">

    <div class="card shadow border-0 rounded-4 mb-4">

        <div class="card-header bg-white">

            <h4 class="fw-bold">
                Personal Information
            </h4>

        </div>

        <div class="card-body">

            <div class="row">

                <div class="col-md-6 mb-3">

                    <label class="fw-bold">First Name</label>

                    <input type="text"
                           class="form-control"
                           value="<%=p.getFirstName()%>"
                           readonly>

                </div>

                <div class="col-md-6 mb-3">

                    <label class="fw-bold">Last Name</label>

                    <input type="text"
                           class="form-control"
                           value="<%=p.getLastName()%>"
                           readonly>

                </div>

                <div class="col-md-6 mb-3">

                    <label class="fw-bold">Phone</label>

                    <input type="text"
                           class="form-control"
                           value="<%=p.getPhone()%>"
                           readonly>

                </div>

                <div class="col-md-6 mb-3">

                    <label class="fw-bold">Email</label>

                    <input type="text"
                           class="form-control"
                           value="<%=p.getEmail()%>"
                           readonly>

                </div>

                <div class="col-md-12">

                    <label class="fw-bold">Address</label>

                    <textarea class="form-control"
                              rows="3"
                              readonly><%=p.getAddress()%></textarea>

                </div>

            </div>

        </div>

    </div>

<div class="card shadow border-0 rounded-4">

    <div class="card-header bg-white">

        <h4 class="fw-bold">

            Appointment History

        </h4>

    </div>

    <div class="card-body">

        <table class="table table-hover">

            <thead class="table-light">

            <tr>

                <th>Date</th>

                <th>Doctor</th>

                <th>Treatment</th>

                <th>Status</th>

            </tr>

            </thead>

            <tbody>

                <tr>

                    <td>15-07-2026</td>

                    <td>Dr. Perera</td>

                    <td>Dental Cleaning</td>

                    <td>

                        <span class="badge bg-success">

                            Completed

                        </span>

                    </td>

                </tr>

                <tr>

                    <td>20-07-2026</td>

                    <td>Dr. Silva</td>

                    <td>Root Canal</td>

                    <td>

                        <span class="badge bg-warning">

                            Pending

                        </span>

                    </td>

                </tr>

            </tbody>

        </table>

    </div>

</div>

</div>

</div>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>