<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="dao.BillingDAO"%>
<%@ page import="model.Billing"%>
<%@ page import="java.util.List"%>

<%
    // Login check
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Get all billing records
    BillingDAO billingDAO = new BillingDAO();
    List<Billing> bills = billingDAO.getAllBills();
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>Reception Billing</title>

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

.status {
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 13px;
    font-weight: bold;
    color: white;
    display: inline-block;
}

.Paid {
    background: #198754;
}

.Pending {
    background: #f0ad00;
}

.Unpaid {
    background: #dc3545;
}

</style>

</head>

<body>

<div class="container">

    <div class="container-box">

        <!-- HEADER -->

        <div class="page-header">

            <h2 class="mb-1">

                <i class="bi bi-receipt"></i>
                Billing & Payments

            </h2>

            <p class="mb-0">
                View and manage patient billing information
            </p>

        </div>


        <!-- BUTTONS -->

        <div class="mb-4">

            <a href="receptionist-dashboard.jsp"
               class="btn btn-secondary">

                <i class="bi bi-arrow-left"></i>
                Back to Dashboard

            </a>

            <a href="reception-add-billing.jsp"
               class="btn btn-primary">

                <i class="bi bi-plus-circle"></i>
                Create Bill

            </a>

        </div>


        <!-- BILLING TABLE -->

        <div class="table-responsive">

            <table class="table table-hover table-bordered align-middle">

                <thead class="table-dark">

                    <tr>

                        <th>Bill ID</th>

                        <th>Patient</th>

                        <th>Treatment</th>

                        <th>Amount</th>

                        <th>Payment Status</th>

                        <th>Payment Date</th>

                    </tr>

                </thead>

                <tbody>

                <%
                    if (bills != null && !bills.isEmpty()) {

                        for (Billing bill : bills) {
                %>

                    <tr>

                        <td>
                            #<%= bill.getBillId() %>
                        </td>

                        <td>
                            <%= bill.getPatientName() != null
                                ? bill.getPatientName()
                                : "N/A" %>
                        </td>

                        <td>
                            <%= bill.getTreatmentName() != null
                                ? bill.getTreatmentName()
                                : "N/A" %>
                        </td>

                        <td>
                            Rs. <%= String.format("%.2f", bill.getAmount()) %>
                        </td>

                        <td>

                            <span class="status
                                <%= bill.getPaymentStatus() %>">

                                <%= bill.getPaymentStatus() %>

                            </span>

                        </td>

                        <td>
                            <%= bill.getPaymentDate() != null
                                ? bill.getPaymentDate()
                                : "N/A" %>
                        </td>

                    </tr>

                <%
                        }

                    } else {
                %>

                    <tr>

                        <td colspan="6"
                            class="text-center text-muted">

                            <i class="bi bi-receipt-cutoff"></i>

                            No billing records found.

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