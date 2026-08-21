<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="model.Billing" %>

<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Billing> bills =
            (List<Billing>) request.getAttribute("bills");

    if (bills == null) {
        response.sendRedirect("PatientBillingServlet");
        return;
    }

    String fullName =
            (String) session.getAttribute("fullName");

    if (fullName == null) {
        fullName =
                (String) session.getAttribute("username");
    }
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>My Bills | Sunrise Dental Clinic</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <link rel="stylesheet"
          href="assets/css/style.css">

</head>

<body>

<div class="patient-dashboard">

    <!-- TOP BAR -->

    <div class="patient-topbar">

        <div class="container">

            <div class="d-flex
                        justify-content-between
                        align-items-center">

                <a href="user-dashboard.jsp"
                   class="patient-logo">

                    <i class="bi bi-heart-pulse-fill"></i>

                    Sunrise Dental

                </a>

                <div class="patient-user">

                    <div>

                        <div class="patient-user-name">

                            <%= fullName %>

                        </div>

                        <div class="patient-user-role">

                            Patient

                        </div>

                    </div>

                    <a href="LogoutServlet"
                       class="btn btn-outline-danger ms-3">

                        <i class="bi bi-box-arrow-right"></i>

                        Logout

                    </a>

                </div>

            </div>

        </div>

    </div>


    <!-- CONTENT -->

    <div class="container py-5">

        <div class="d-flex
                    justify-content-between
                    align-items-center
                    mb-4">

            <div>

                <h2 class="fw-bold">

                    <i class="bi bi-receipt text-info"></i>

                    My Bills

                </h2>

                <p class="text-muted mb-0">

                    View your invoices and make payments.

                </p>

            </div>

            <a href="user-dashboard.jsp"
               class="btn btn-outline-info">

                <i class="bi bi-arrow-left"></i>

                Dashboard

            </a>

        </div>


        <!-- SUCCESS -->

        <% if ("success".equals(
                request.getParameter("payment"))) { %>

            <div class="alert alert-success">

                <i class="bi bi-check-circle-fill"></i>

                Payment completed successfully.

            </div>

        <% } %>


        <!-- FAILED -->

        <% if ("failed".equals(
                request.getParameter("payment"))) { %>

            <div class="alert alert-danger">

                Payment failed. Please try again.

            </div>

        <% } %>


        <!-- INVALID -->

        <% if ("invalid".equals(
                request.getParameter("error"))) { %>

            <div class="alert alert-danger">

                Invalid bill or unauthorized access.

            </div>

        <% } %>


        <div class="row g-4">

            <%
                if (bills.isEmpty()) {
            %>

                <div class="col-12">

                    <div class="card shadow-sm border-0 p-5 text-center">

                        <i class="bi bi-receipt display-3 text-muted"></i>

                        <h4 class="mt-3">

                            No Bills Available

                        </h4>

                        <p class="text-muted">

                            Your invoices will appear here
                            when the clinic creates them.

                        </p>

                    </div>

                </div>

            <%
                }

                for (Billing bill : bills) {
            %>

            <div class="col-md-6 col-lg-4">

                <div class="card shadow-sm border-0 h-100">

                    <div class="card-body p-4">

                        <div class="d-flex
                                    justify-content-between
                                    align-items-center
                                    mb-3">

                            <span class="text-muted">

                                Invoice #

                                <%= bill.getBillId() %>

                            </span>

                            <% if ("Paid".equalsIgnoreCase(
                                    bill.getPaymentStatus())) {
                            %>

                                <span class="badge bg-success">

                                    <i class="bi bi-check-circle"></i>

                                    Paid

                                </span>

                            <% } else { %>

                                <span class="badge bg-warning text-dark">

                                    <i class="bi bi-clock"></i>

                                    Pending

                                </span>

                            <% } %>

                        </div>


                        <h5 class="fw-bold">

                            <%= bill.getTreatmentName() %>

                        </h5>


                        <hr>


                        <div class="mb-2">

                            <small class="text-muted">

                                Patient

                            </small>

                            <div class="fw-semibold">

                                <%= bill.getPatientName() %>

                            </div>

                        </div>


                        <div class="mb-2">

                            <small class="text-muted">

                                Payment Date

                            </small>

                            <div>

                                <%= bill.getPaymentDate() %>

                            </div>

                        </div>


                        <div class="mb-4">

                            <small class="text-muted">

                                Amount

                            </small>

                            <div class="fs-4 fw-bold text-info">

                                Rs.

                                <%= String.format(
                                    "%,.2f",
                                    bill.getAmount()
                                ) %>

                            </div>

                        </div>


                        <% if ("Paid".equalsIgnoreCase(
                                bill.getPaymentStatus())) {
                        %>

                            <button
                                class="btn btn-success w-100"
                                disabled>

                                <i class="bi bi-check-circle-fill"></i>

                                Payment Completed

                            </button>

                        <% } else { %>

                            <form
                                action="PayBillServlet"
                                method="post"
                                onsubmit="return confirm(
                                    'Confirm payment of Rs. <%= String.format("%,.2f", bill.getAmount()) %>?'
                                );">

                                <input
                                    type="hidden"
                                    name="billId"
                                    value="<%= bill.getBillId() %>">

                                <button
                                    type="submit"
                                    class="btn btn-info w-100 fw-bold">

                                    <i class="bi bi-credit-card"></i>

                                    Pay Now

                                </button>

                            </form>

                        <% } %>

                    </div>

                </div>

            </div>

            <%
                }
            %>

        </div>

    </div>

</div>

</body>

</html>