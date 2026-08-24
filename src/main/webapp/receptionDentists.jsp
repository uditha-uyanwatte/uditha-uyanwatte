<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="dao.DentistDAO"%>
<%@ page import="model.Dentist"%>
<%@ page import="java.util.List"%>

<%
    // Login check
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Get all dentists
    DentistDAO dentistDAO = new DentistDAO();
    List<Dentist> dentists = dentistDAO.getAllDentists();
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>Reception Dentists</title>

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

                <i class="bi bi-person-badge"></i>
                Dentists

            </h2>

            <p class="mb-0">
                View available dentist information
            </p>

        </div>


        <!-- BACK BUTTON -->

        <div class="mb-4">

            <a href="receptionist-dashboard.jsp"
               class="btn btn-secondary">

                <i class="bi bi-arrow-left"></i>
                Back to Dashboard

            </a>

        </div>


        <!-- DENTIST TABLE -->

        <div class="table-responsive">

            <table
                class="table table-hover table-bordered align-middle">

                <thead class="table-dark">

                    <tr>

                        <th>Dentist ID</th>

                        <th>Full Name</th>

                        <th>Specialization</th>

                        <th>Phone</th>

                        <th>Email</th>

                    </tr>

                </thead>

                <tbody>

                <%
                    if (dentists != null && !dentists.isEmpty()) {

                        for (Dentist dentist : dentists) {
                %>

                    <tr>

                        <td>
                            #<%= dentist.getDentistId() %>
                        </td>

                        <td>
                            Dr. <%= dentist.getFirstName() %>
                            <%= dentist.getLastName() %>
                        </td>

                        <td>
                            <%= dentist.getSpecialization() %>
                        </td>

                        <td>
                            <%= dentist.getPhone() %>
                        </td>

                        <td>
                            <%= dentist.getEmail() %>
                        </td>

                    </tr>

                <%
                        }

                    } else {
                %>

                    <tr>

                        <td colspan="5"
                            class="text-center text-muted">

                            <i class="bi bi-person-x"></i>

                            No dentists found.

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