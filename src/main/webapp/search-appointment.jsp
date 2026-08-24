<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // Receptionist login check
    if (session.getAttribute("username") == null) {

        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>Search Appointment</title>

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

.search-box {
    max-width: 650px;
    margin: 80px auto;
    background: white;
    padding: 35px;
    border-radius: 15px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.10);
}

.page-header {
    background: linear-gradient(135deg, #1e88e5, #1565c0);
    color: white;
    padding: 25px;
    border-radius: 12px;
    margin-bottom: 30px;
}

</style>

</head>

<body>

<div class="container">

    <div class="search-box">

        <!-- HEADER -->

        <div class="page-header">

            <h3 class="mb-1">

                <i class="bi bi-search"></i>

                Search Appointment

            </h3>

            <p class="mb-0">

                Search appointment details using Appointment ID

            </p>

        </div>


        <!-- ERROR MESSAGE -->

        <%
            String error =
                    request.getParameter("error");

            if ("invalid".equals(error)) {
        %>

            <div class="alert alert-danger">

                Please enter a valid Appointment ID.

            </div>

        <%
            } else if ("notfound".equals(error)) {
        %>

            <div class="alert alert-warning">

                Appointment not found.

            </div>

        <%
            }
        %>


        <!-- SEARCH FORM -->

        <form action="ReceptionSearchAppointmentServlet"
              method="get">

            <div class="mb-4">

                <label class="form-label">

                    <i class="bi bi-hash"></i>

                    Appointment ID

                </label>

                <input type="number"
                       name="id"
                       class="form-control form-control-lg"
                       placeholder="Enter Appointment ID"
                       min="1"
                       required>

            </div>


            <div class="d-flex gap-2">

                <a href="receptionist-dashboard.jsp"
                   class="btn btn-secondary">

                    <i class="bi bi-arrow-left"></i>

                    Back

                </a>


                <button type="submit"
                        class="btn btn-primary">

                    <i class="bi bi-search"></i>

                    Search Appointment

                </button>

            </div>

        </form>

    </div>

</div>

</body>

</html>