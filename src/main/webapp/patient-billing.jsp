<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="model.Billing" %>


<%
String paid = request.getParameter("paid");
String error = request.getParameter("error");

if ("1".equals(paid)) {
%>

<div class="alert alert-success">
    Payment completed successfully!
</div>

<%
} else if ("payment".equals(error)) {
%>

<div class="alert alert-danger">
    Payment failed!
</div>

<%
}
%>

<%

    if (session.getAttribute("user") == null) {

        response.sendRedirect("login.jsp");
        return;
    }


    List<Billing> bills =
            (List<Billing>) request.getAttribute("bills");


    Double totalAmount =
            (Double) request.getAttribute("totalAmount");


    Double totalPaid =
            (Double) request.getAttribute("totalPaid");


    Double pendingAmount =
            (Double) request.getAttribute("pendingAmount");


    if (totalAmount == null) {
        totalAmount = 0.0;
    }

    if (totalPaid == null) {
        totalPaid = 0.0;
    }

    if (pendingAmount == null) {
        pendingAmount = 0.0;
    }

%>


<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        My Bills | Sunrise Dental Clinic
    </title>


    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">


    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">


    <link
        rel="stylesheet"
        href="assets/css/style.css">


    <style>

        .billing-page {

            padding: 35px 0;

        }


        .billing-header {

            margin-bottom: 30px;

        }


        .billing-header h2 {

            font-weight: 700;

            color: #092b3a;

        }


        .billing-header p {

            color: #718096;

        }


        .billing-summary {

            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 20px;

            margin-bottom: 30px;

        }


        .billing-summary-card {

            background: white;

            border-radius: 18px;

            padding: 25px;

            box-shadow:
                0 8px 25px rgba(0,0,0,0.06);

        }


        .billing-summary-icon {

            width: 50px;

            height: 50px;

            border-radius: 14px;

            background: #e5faff;

            color: #0dcaf0;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 22px;

            margin-bottom: 15px;

        }


        .billing-summary-card h3 {

            font-size: 28px;

            font-weight: 700;

            margin: 0;

            color: #092b3a;

        }


        .billing-summary-card p {

            margin: 5px 0 0;

            color: #718096;

        }


        .bill-card {

            background: white;

            border-radius: 20px;

            padding: 25px;

            margin-bottom: 20px;

            box-shadow:
                0 8px 25px rgba(0,0,0,0.06);

            border: 1px solid #edf2f7;

        }


        .bill-top {

            display: flex;

            justify-content:
                space-between;

            align-items: center;

            margin-bottom: 20px;

        }


        .bill-id {

            font-weight: 700;

            color: #092b3a;

        }


        .bill-info {

            display: grid;

            grid-template-columns:
                repeat(4, 1fr);

            gap: 20px;

        }


        .bill-info-item span {

            display: block;

            font-size: 13px;

            color: #718096;

            margin-bottom: 5px;

        }


        .bill-info-item strong {

            color: #092b3a;

        }


        .bill-amount {

            font-size: 22px;

            font-weight: 700;

            color: #0aa678;

        }


        .pay-btn {

            background: #20c4e8;

            color: white;

            border: none;

            border-radius: 10px;

            padding: 11px 22px;

            font-weight: 700;

        }


        .pay-btn:hover {

            background: #0aaed0;

            color: white;

        }


        .empty-bills {

            background: white;

            border-radius: 20px;

            padding: 60px 20px;

            text-align: center;

            box-shadow:
                0 8px 25px rgba(0,0,0,0.05);

        }


        .empty-bills i {

            font-size: 55px;

            color: #20c4e8;

        }


        @media(max-width: 900px) {

            .billing-summary {

                grid-template-columns:
                    1fr;

            }


            .bill-info {

                grid-template-columns:
                    1fr 1fr;

            }

        }


        @media(max-width: 600px) {

            .bill-info {

                grid-template-columns:
                    1fr;

            }


            .bill-top {

                flex-direction: column;

                align-items: flex-start;

                gap: 10px;

            }

        }

    </style>

</head>


<body>


<div class="patient-dashboard">


    <!-- TOP BAR -->

    <div class="patient-topbar">

        <div class="container">

            <div class="d-flex
                        justify-content-between
                        align-items-center">


                <a href="dashboard.jsp"
                   class="patient-logo">

                    <i class="bi bi-heart-pulse-fill"></i>

                    Sunrise Dental

                </a>


                <div class="patient-user">

                    <div>

                        <div class="patient-user-name">

                            <%= session.getAttribute("fullName") %>

                        </div>

                        <div class="patient-user-role">

                            Patient

                        </div>

                    </div>


                    <div class="patient-avatar">

                        <i class="bi bi-person-fill"></i>

                    </div>


                    <a href="LogoutServlet"
                       class="logout-btn">

                        <i class="bi bi-box-arrow-right"></i>

                        Logout

                    </a>

                </div>

            </div>

        </div>

    </div>



    <!-- MAIN -->

    <div class="container billing-page">


        <!-- HEADER -->

        <div class="billing-header">

            <h2>

                <i class="bi bi-receipt-cutoff"></i>

                My Bills

            </h2>

            <p>

                View your dental invoices and manage
                your payments.

            </p>

        </div>



        <!-- SUCCESS -->

        <% if (request.getParameter("paid") != null) { %>

            <div class="alert alert-success">

                <i class="bi bi-check-circle-fill"></i>

                Payment completed successfully.

            </div>

        <% } %>



        <!-- ERROR -->

        <% if (request.getParameter("error") != null) { %>

            <div class="alert alert-danger">

                <i class="bi bi-exclamation-circle-fill"></i>

                Unable to process the payment.

                Please try again.

            </div>

        <% } %>



        <!-- SUMMARY -->

        <div class="billing-summary">


            <!-- TOTAL -->

            <div class="billing-summary-card">

                <div class="billing-summary-icon">

                    <i class="bi bi-receipt"></i>

                </div>

                <h3>

                    Rs.
                    <%= String.format(
                            "%,.2f",
                            totalAmount
                    ) %>

                </h3>

                <p>

                    Total Bills

                </p>

            </div>



            <!-- PAID -->

            <div class="billing-summary-card">

                <div class="billing-summary-icon">

                    <i class="bi bi-check-circle"></i>

                </div>

                <h3 class="text-success">

                    Rs.
                    <%= String.format(
                            "%,.2f",
                            totalPaid
                    ) %>

                </h3>

                <p>

                    Total Paid

                </p>

            </div>



            <!-- PENDING -->

            <div class="billing-summary-card">

                <div class="billing-summary-icon">

                    <i class="bi bi-clock"></i>

                </div>

                <h3 class="text-warning">

                    Rs.
                    <%= String.format(
                            "%,.2f",
                            pendingAmount
                    ) %>

                </h3>

                <p>

                    Pending Amount

                </p>

            </div>


        </div>

<!-- BILL LIST -->

<% if (bills != null && !bills.isEmpty()) { %>

    <% for (Billing bill : bills) { %>

        <div class="bill-card">

            <!-- TOP -->

            <div class="bill-top">

                <div class="bill-id">

                    <i class="bi bi-receipt"></i>

                    Bill #<%= bill.getBillId() %>

                </div>


                <% if ("Paid".equalsIgnoreCase(
                        bill.getPaymentStatus())) { %>

                    <span class="badge bg-success">

                        <i class="bi bi-check-circle-fill"></i>

                        Paid

                    </span>

                <% } else { %>

                    <span class="badge bg-warning text-dark">

                        <i class="bi bi-clock-fill"></i>

                        Pending

                    </span>

                <% } %>

            </div>


            <!-- BILL DETAILS -->

            <div class="bill-info">


                <!-- TREATMENT -->

                <div class="bill-info-item">

                    <span>
                        Treatment
                    </span>

                    <strong>
                        <%= bill.getTreatmentName() %>
                    </strong>

                </div>


                <!-- AMOUNT -->

                <div class="bill-info-item">

                    <span>
                        Amount
                    </span>

                    <div class="bill-amount">

                        Rs.

                        <%= String.format(
                                "%,.2f",
                                bill.getAmount()
                        ) %>

                    </div>

                </div>


                <!-- DATE -->

                <div class="bill-info-item">

                    <span>
                        Payment Date
                    </span>

                    <strong>
                        <%= bill.getPaymentDate() %>
                    </strong>

                </div>


                <!-- ACTION -->

                <div class="bill-info-item">

                    <span>
                        Action
                    </span>

                    <div class="d-flex gap-2 flex-wrap">


                        <!-- VIEW BILL -->

                        <button
                            type="button"
                            class="btn btn-outline-info"
                            data-bs-toggle="modal"
                            data-bs-target="#billModal<%= bill.getBillId() %>">

                            <i class="bi bi-eye-fill"></i>

                            View Bill

                        </button>


                        <!-- PAYMENT -->

                        <% if ("Paid".equalsIgnoreCase(
                                bill.getPaymentStatus())) { %>

                            <button
                                type="button"
                                class="btn btn-outline-success"
                                disabled>

                                <i class="bi bi-check-circle-fill"></i>

                                Paid

                            </button>

                        <% } else { %>

                            <form
                                action="PaymentServlet"
                                method="get"
                                onsubmit="return confirmPayment();">

                                <input
                                    type="hidden"
                                    name="billId"
                                    value="<%= bill.getBillId() %>">

                                <button
                                    type="submit"
                                    class="pay-btn">

                                    <i class="bi bi-credit-card-fill"></i>

                                    Pay Now

                                </button>

                            </form>

                        <% } %>

                    </div>

                </div>


            </div>
            <!-- END BILL INFO -->


            <!-- ================================================= -->
            <!-- VIEW BILL MODAL -->
            <!-- ================================================= -->

            <div
                class="modal fade"
                id="billModal<%= bill.getBillId() %>"
                tabindex="-1"
                aria-hidden="true">

                <div class="modal-dialog modal-dialog-centered">

                    <div class="modal-content">


                        <!-- MODAL HEADER -->

                        <div class="modal-header">

                            <h5 class="modal-title">

                                <i class="bi bi-receipt-cutoff text-info"></i>

                                Bill #<%= bill.getBillId() %>

                            </h5>


                            <button
                                type="button"
                                class="btn-close"
                                data-bs-dismiss="modal">

                            </button>

                        </div>


                        <!-- MODAL BODY -->

                        <div class="modal-body">


                            <!-- PATIENT -->

                            <div class="mb-3">

                                <small class="text-muted">

                                    Patient

                                </small>

                                <h5>

                                    <%= session.getAttribute("fullName") %>

                                </h5>

                            </div>


                            <!-- TREATMENT -->

                            <div class="mb-3">

                                <small class="text-muted">

                                    Treatment

                                </small>

                                <h5>

                                    <%= bill.getTreatmentName() %>

                                </h5>

                            </div>


                            <!-- AMOUNT -->

                            <div class="mb-3">

                                <small class="text-muted">

                                    Amount

                                </small>

                                <h4 class="text-success fw-bold">

                                    Rs.

                                    <%= String.format(
                                            "%,.2f",
                                            bill.getAmount()
                                    ) %>

                                </h4>

                            </div>


                            <!-- PAYMENT DATE -->

                            <div class="mb-3">

                                <small class="text-muted">

                                    Payment Date

                                </small>

                                <div>

                                    <strong>

                                        <%= bill.getPaymentDate() %>

                                    </strong>

                                </div>

                            </div>


                            <!-- STATUS -->

                            <div>

                                <small class="text-muted">

                                    Payment Status

                                </small>

                                <div class="mt-2">


                                    <% if ("Paid".equalsIgnoreCase(
        bill.getPaymentStatus())) { %>

    <a
        href="receipt.jsp?billId=<%= bill.getBillId() %>"
        class="btn btn-outline-success">

        <i class="bi bi-receipt"></i>

        Receipt

    </a>

<% } else { %>
                                  

                                        <span class="badge bg-warning text-dark">

                                            <i class="bi bi-clock-fill"></i>

                                            Pending

                                        </span>

                                    <% } %>


                                </div>

                            </div>


                        </div>


                        <!-- MODAL FOOTER -->

                        <div class="modal-footer">


                            <button
                                type="button"
                                class="btn btn-secondary"
                                data-bs-dismiss="modal">

                                Close

                            </button>


                            <% if (!"Paid".equalsIgnoreCase(
                                    bill.getPaymentStatus())) { %>


                                <form
                                    action="PaymentServlet"
                                    method="get"
                                    onsubmit="return confirmPayment();">

                                    <input
                                        type="hidden"
                                        name="billId"
                                        value="<%= bill.getBillId() %>">


                                    <button
                                        type="submit"
                                        class="pay-btn">

                                        <i class="bi bi-credit-card-fill"></i>

                                        Pay This Bill

                                    </button>

                                </form>


                            <% } %>


                        </div>

                    </div>

                </div>

            </div>
            <!-- END VIEW BILL MODAL -->


        </div>
        <!-- END BILL CARD -->


    <% } %>


<% } else { %>


    <!-- EMPTY -->

    <div class="empty-bills">

        <i class="bi bi-receipt"></i>

        <h4 class="mt-3">

            No Bills Available

        </h4>

        <p>

            You don't have any billing records yet.

        </p>


        <a
            href="dashboard.jsp"
            class="btn btn-info text-white">

            <i class="bi bi-arrow-left"></i>

            Back to Dashboard

        </a>

    </div>


<% } %>
        
        


    </div>

</div>



<script>

    function confirmPayment() {

        return confirm(
            "Are you sure you want to pay this bill?"
        );

    }

</script>


<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>


</body>

</html>