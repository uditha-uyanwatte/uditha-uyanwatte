<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="dao.PatientDAO"%>
<%@ page import="model.Patient"%>
<%@ page import="java.util.List"%>

<%
    // Login check
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Get all patients
    PatientDAO patientDAO = new PatientDAO();
    List<Patient> patients = patientDAO.getAllPatients();
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>Reception Patients</title>

<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet">

<link
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
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

.table th {
    white-space: nowrap;
}

</style>

</head>

<body>

<div class="container">

    <div class="container-box">

        <!-- HEADER -->

        <div class="page-header">

            <h2 class="mb-1">

                <i class="bi bi-people"></i>
                Patients

            </h2>

            <p class="mb-0">
                View and manage patient information
            </p>

        </div>


        <!-- BUTTONS -->

        <div class="mb-4">

            <a href="receptionist-dashboard.jsp"
               class="btn btn-secondary">

                <i class="bi bi-arrow-left"></i>
                Back to Dashboard

            </a>

        </div>


        <!-- PATIENT TABLE -->

        <div class="table-responsive">

            <table
                class="table table-hover table-bordered align-middle">

                <thead class="table-dark">

                    <tr>

                        <th>Patient ID</th>

                        <th>Full Name</th>

                        <th>Gender</th>

                        <th>Phone</th>

                        <th>Email</th>

                        <th>Action</th>

                    </tr>

                </thead>

                <tbody>

                <%
                    if (patients != null && !patients.isEmpty()) {

                        for (Patient patient : patients) {
                %>

                    <tr>

                        <td>
                            #<%= patient.getPatientId() %>
                        </td>
<td>
    <%= patient.getFirstName() %>
    <%= patient.getLastName() %>
</td>

                        <td>
                            <%= patient.getGender() %>
                        </td>

                        <td>
                            <%= patient.getPhone() %>
                        </td>

                        <td>
                            <%= patient.getEmail() %>
                        </td>

                        <td>

                            <a href="patient-details.jsp?id=<%= patient.getPatientId() %>"
                               class="btn btn-sm btn-info text-white">

                                <i class="bi bi-eye"></i>
                                View

                            </a>

                        </td>

                    </tr>

                <%
                        }

                    } else {
                %>

                    <tr>

                        <td colspan="6"
                            class="text-center text-muted">

                            <i class="bi bi-person-x"></i>

                            No patients found.

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
