<%@ page import="dao.BillingDAO" %>
<%@ page import="model.Billing" %>

<%@ page contentType="text/html;charset=UTF-8" %>

<%

    if (session.getAttribute("user") == null) {

        response.sendRedirect("login.jsp");

        return;
    }


    String billIdParam =
            request.getParameter("billId");


    if (billIdParam == null ||
        billIdParam.trim().isEmpty()) {

        response.sendRedirect(
                "PatientBillingServlet"
        );

        return;
    }


    int billId =
            Integer.parseInt(billIdParam);


    BillingDAO billingDAO =
            new BillingDAO();


    Billing bill =
            billingDAO.getBillById(billId);


    if (bill == null) {

        response.sendRedirect(
                "PatientBillingServlet"
        );

        return;
    }


    // Only paid bills can generate receipt

    if (!"Paid".equalsIgnoreCase(
            bill.getPaymentStatus())) {

        response.sendRedirect(
                "PatientBillingServlet?error=notPaid"
        );

        return;
    }

%>


<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Payment Receipt #<%= bill.getBillId() %>
    </title>


    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">


    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
        rel="stylesheet">


    <style>

        body {

            background: #f2f7fa;

            font-family:
                Arial,
                Helvetica,
                sans-serif;

        }


        .receipt-wrapper {

            max-width: 800px;

            margin: 40px auto;

        }


        .receipt {

            background: white;

            border-radius: 18px;

            box-shadow:
                0 10px 35px
                rgba(0,0,0,0.08);

            overflow: hidden;

        }


        .receipt-header {

            background:
                linear-gradient(
                    135deg,
                    #062d3b,
                    #087f9d
                );

            color: white;

            padding: 35px;

        }


        .clinic-name {

            font-size: 27px;

            font-weight: 800;

            margin-bottom: 3px;

        }


        .clinic-subtitle {

            opacity: 0.85;

            font-size: 14px;

        }


        .receipt-title {

            text-align: right;

        }


        .receipt-title h2 {

            margin: 0;

            font-weight: 800;

        }


        .receipt-title span {

            opacity: 0.8;

        }


        .receipt-body {

            padding: 35px;

        }


        .patient-section {

            background: #f5fbfd;

            border-radius: 12px;

            padding: 20px;

            margin-bottom: 25px;

        }


        .section-title {

            font-size: 13px;

            font-weight: 700;

            color: #73808a;

            text-transform: uppercase;

            margin-bottom: 8px;

        }


        .patient-name {

            font-size: 20px;

            font-weight: 700;

            color: #092b3a;

        }


        .invoice-table {

            width: 100%;

            border-collapse: collapse;

            margin-top: 20px;

        }


        .invoice-table th {

            background: #f3f7f9;

            color: #53636d;

            padding: 14px;

            text-align: left;

            font-size: 14px;

        }


        .invoice-table td {

            padding: 16px 14px;

            border-bottom:
                1px solid #e9eef1;

        }


        .amount {

            text-align: right;

            font-weight: 700;

        }


        .total-row td {

            border-top:
                2px solid #dce7eb;

            border-bottom: none;

            font-size: 20px;

            font-weight: 800;

        }


        .total-amount {

            color: #0a9b68;

            text-align: right;

        }


        .paid-badge {

            display: inline-block;

            background: #d1fae5;

            color: #087443;

            padding: 7px 14px;

            border-radius: 30px;

            font-size: 13px;

            font-weight: 700;

        }


        .receipt-footer {

            text-align: center;

            padding: 25px 35px 35px;

            color: #718096;

        }


        .thank-you {

            color: #092b3a;

            font-weight: 700;

            margin-bottom: 5px;

        }


        .receipt-actions {

            max-width: 800px;

            margin: 20px auto;

            display: flex;

            gap: 10px;

            justify-content: center;

        }


        .print-btn {

            background: #11bddd;

            color: white;

            border: none;

            padding: 11px 22px;

            border-radius: 9px;

            font-weight: 700;

        }


        .back-btn {

            padding: 11px 22px;

            border-radius: 9px;

            font-weight: 700;

        }


        @media print {

            body {

                background: white;

            }


            .receipt-wrapper {

                margin: 0;

                max-width: 100%;

            }


            .receipt {

                box-shadow: none;

                border-radius: 0;

            }


            .receipt-actions {

                display: none;

            }


        }


        @media (max-width: 600px) {

            .receipt-header {

                padding: 25px;

            }


            .receipt-body {

                padding: 25px;

            }


            .receipt-title {

                text-align: left;

                margin-top: 20px;

            }


        }

    </style>

</head>


<body>


<div class="container">

    <div class="receipt-wrapper">


        <!-- RECEIPT -->

        <div class="receipt">


            <!-- HEADER -->

            <div class="receipt-header">

                <div class="row">


                    <div class="col-md-7">

                        <div class="clinic-name">

                            SUNRISE

                        </div>

                        <div class="clinic-subtitle">

                            Dental Clinic

                        </div>

                    </div>


                    <div class="col-md-5 receipt-title">

                        <h2>

                            PAYMENT RECEIPT

                        </h2>

                        <span>

                            Bill #<%= bill.getBillId() %>

                        </span>

                    </div>


                </div>

            </div>


            <!-- BODY -->

            <div class="receipt-body">


                <!-- PATIENT -->

                <div class="patient-section">


                    <div class="section-title">

                        Patient

                    </div>


                    <div class="patient-name">

                        <%= bill.getPatientName() %>

                    </div>


                </div>


                <!-- BILL DETAILS -->

                <table class="invoice-table">

                    <thead>

                        <tr>

                            <th>
                                Description
                            </th>

                            <th>
                                Payment Date
                            </th>

                            <th class="text-end">
                                Amount
                            </th>

                        </tr>

                    </thead>


                    <tbody>

                        <tr>

                            <td>

                                <strong>

                                    <%= bill.getTreatmentName() %>

                                </strong>

                                <br>

                                <small class="text-muted">

                                    Dental Treatment

                                </small>

                            </td>


                            <td>

                                <%= bill.getPaymentDate() %>

                            </td>


                            <td class="amount">

                                Rs.

                                <%= String.format(
                                        "%,.2f",
                                        bill.getAmount()
                                ) %>

                            </td>

                        </tr>


                        <tr class="total-row">

                            <td colspan="2">

                                Total Paid

                            </td>


                            <td class="total-amount">

                                Rs.

                                <%= String.format(
                                        "%,.2f",
                                        bill.getAmount()
                                ) %>

                            </td>

                        </tr>

                    </tbody>

                </table>


                <!-- STATUS -->

                <div class="text-end mt-4">

                    <span class="paid-badge">

                        <i class="bi bi-check-circle-fill"></i>

                        PAYMENT PAID

                    </span>

                </div>


            </div>


            <!-- FOOTER -->

            <div class="receipt-footer">

                <div class="thank-you">

                    Thank you for choosing Sunrise Dental Clinic.

                </div>

                <div>

                    This is a computer-generated payment receipt.

                </div>

            </div>


        </div>

    </div>


    <!-- ACTIONS -->

    <div class="receipt-actions">


        <a
            href="PatientBillingServlet"
            class="btn btn-outline-secondary back-btn">

            <i class="bi bi-arrow-left"></i>

            Back to Bills

        </a>


        <button
            type="button"
            class="print-btn"
            onclick="window.print()">

            <i class="bi bi-printer-fill"></i>

            Print Receipt

        </button>


    </div>

</div>


</body>

</html>