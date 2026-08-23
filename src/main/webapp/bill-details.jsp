<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ page import="model.Billing"%>

<%
    Billing bill =
            (Billing) request.getAttribute("bill");
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>Bill Details</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">

<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
      rel="stylesheet">

<style>

body {
    background: #f4f6f9;
}

.receipt-card {
    max-width: 850px;
    margin: auto;
    border: none;
    border-radius: 15px;
    overflow: hidden;
}

.receipt-header {
    background: linear-gradient(
        135deg,
        #0d6efd,
        #084298
    );
    color: white;
    padding: 30px;
}

.receipt-title {
    font-size: 28px;
    font-weight: 700;
}

.receipt-subtitle {
    opacity: 0.85;
    margin-bottom: 0;
}

.receipt-info {
    padding: 30px;
}

.bill-number {
    font-size: 14px;
    color: #6c757d;
}

.total-box {
    background: #f8f9fa;
    border-radius: 12px;
    padding: 20px;
}

.total-amount {
    font-size: 28px;
    font-weight: bold;
    color: #198754;
}

.action-buttons {
    padding: 20px 30px 30px;
}

@media print {

    body {
        background: white;
    }

    .no-print {
        display: none !important;
    }

    .receipt-card {
        box-shadow: none !important;
        border: none !important;
    }

}

</style>

</head>

<body>

<div class="container py-5">

<% if (bill != null) { %>

<div class="card shadow receipt-card">

    <!-- ================= HEADER ================= -->

    <div class="receipt-header">

        <div class="row align-items-center">

            <div class="col-md-8">

                <h1 class="receipt-title">

                    <i class="bi bi-hospital"></i>

                    Sunrise Dental Clinic

                </h1>

                <p class="receipt-subtitle">

                    Patient Treatment Payment Receipt

                </p>

            </div>

            <div class="col-md-4 text-md-end mt-3 mt-md-0">

                <div class="bill-number">

                    Bill Number

                </div>

                <h3>

                    #<%= bill.getBillId() %>

                </h3>

            </div>

        </div>

    </div>


    <!-- ================= BODY ================= -->

    <div class="receipt-info">

        <div class="row mb-4">

            <div class="col-md-6">

                <h6 class="text-muted">

                    PATIENT

                </h6>

                <h4>

                    <%= bill.getPatientName() %>

                </h4>

                <p class="mb-0">

                    Patient ID:
                    <%= bill.getPatientId() %>

                </p>

            </div>


            <div class="col-md-6 text-md-end">

                <h6 class="text-muted">

                    PAYMENT INFORMATION

                </h6>

                <p class="mb-1">

                    <strong>Status:</strong>

                    <span class="badge
                    <%= "Paid".equalsIgnoreCase(
                            bill.getPaymentStatus()
                        )
                        ? "bg-success"
                        : "bg-warning text-dark"
                    %>">

                        <%= bill.getPaymentStatus() %>

                    </span>

                </p>

                <p>

                    <strong>Date:</strong>

                    <%= bill.getPaymentDate() %>

                </p>

            </div>

        </div>


        <!-- ================= APPOINTMENT ================= -->

        <div class="row mb-4">

            <div class="col-md-6">

                <h6 class="text-muted">

                    APPOINTMENT ID

                </h6>

                <h5>

                    #<%= bill.getAppointmentId() %>

                </h5>

            </div>

        </div>


        <!-- ================= TREATMENT TABLE ================= -->

        <div class="table-responsive">

            <table class="table table-bordered">

                <thead class="table-light">

                    <tr>

                        <th>

                            Treatment

                        </th>

                        <th class="text-end">

                            Amount (LKR)

                        </th>

                    </tr>

                </thead>

                <tbody>

                    <tr>

                        <td>

                            <%= bill.getTreatmentName() %>

                        </td>

                        <td class="text-end">

                            Rs.
                            <%= String.format(
                                    "%,.2f",
                                    bill.getAmount()
                                )
                            %>

                        </td>

                    </tr>

                </tbody>

            </table>

        </div>


        <!-- ================= TOTAL ================= -->

        <div class="total-box text-end mt-4">

            <div class="text-muted">

                TOTAL AMOUNT

            </div>

            <div class="total-amount">

                Rs.
                <%= String.format(
                        "%,.2f",
                        bill.getAmount()
                    )
                %>

            </div>

        </div>


        <!-- ================= FOOTER ================= -->

        <div class="text-center mt-5 text-muted">

            <p class="mb-1">

                Thank you for choosing
                Sunrise Dental Clinic.

            </p>

            <small>

                Please keep this receipt
                for your records.

            </small>

        </div>

    </div>


    <!-- ================= BUTTONS ================= -->

    <div class="action-buttons
                d-flex
                justify-content-between
                no-print">

        <a href="appointments.jsp"
           class="btn btn-secondary">

            <i class="bi bi-arrow-left"></i>

            Back

        </a>


        <button type="button"
                class="btn btn-primary"
                onclick="window.print()">

            <i class="bi bi-printer"></i>

            Print Bill

        </button>

    </div>

</div>

<% } else { %>

<div class="alert alert-danger">

    Bill details not found.

</div>

<a href="appointments.jsp"
   class="btn btn-secondary">

    Back

</a>

<% } %>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>