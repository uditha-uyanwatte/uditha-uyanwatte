<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="dao.BillingDAO"%>
<%@ page import="model.Billing"%>
<%@ page import="java.util.List"%>

<%

    // =========================================
    // LOGIN CHECK
    // =========================================

    if (session.getAttribute("username") == null) {

        response.sendRedirect("login.jsp");

        return;
    }


    // =========================================
    // GET ALL BILLING RECORDS
    // =========================================

    BillingDAO billingDAO = new BillingDAO();

    List<Billing> bills = billingDAO.getAllBills();

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta
    name="viewport"
    content="width=device-width, initial-scale=1">

<title>Reception Billing</title>


<!-- BOOTSTRAP CSS -->

<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet">


<!-- BOOTSTRAP ICONS -->

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

    background:
        linear-gradient(
            135deg,
            #1e88e5,
            #1565c0
        );

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


.action-buttons {

    display: flex;

    gap: 8px;

    flex-wrap: wrap;
}


@media print {

    body * {

        visibility: hidden;
    }

}

</style>

</head>


<body>


<div class="container">

    <div class="container-box">


        <!-- =========================================
             PAGE HEADER
        ========================================== -->

        <div class="page-header">

            <h2 class="mb-1">

                <i class="bi bi-receipt"></i>

                Billing & Payments

            </h2>


            <p class="mb-0">

                View and manage patient billing information

            </p>

        </div>



        <!-- =========================================
             BUTTONS
        ========================================== -->

        <div class="mb-4">

            <a
                href="receptionist-dashboard.jsp"
                class="btn btn-secondary">

                <i class="bi bi-arrow-left"></i>

                Back to Dashboard

            </a>


            <a
                href="reception-add-billing.jsp"
                class="btn btn-primary">

                <i class="bi bi-plus-circle"></i>

                Create Bill

            </a>

        </div>



        <!-- =========================================
             BILLING TABLE
        ========================================== -->

        <div class="table-responsive">


            <table
                class="table table-hover table-bordered align-middle">


                <!-- TABLE HEADER -->

                <thead class="table-dark">

                    <tr>

                        <th>Bill ID</th>

                        <th>Patient</th>

                        <th>Treatment</th>

                        <th>Amount</th>

                        <th>Payment Status</th>

                        <th>Payment Date</th>

                        <th>Actions</th>

                    </tr>

                </thead>



                <!-- TABLE BODY -->

                <tbody>


                <%

                    if (
                        bills != null &&
                        !bills.isEmpty()
                    ) {

                        for (
                            Billing bill : bills
                        ) {


                            String patientName =
                                bill.getPatientName() != null
                                ? bill.getPatientName()
                                : "N/A";


                            String treatmentName =
                                bill.getTreatmentName() != null
                                ? bill.getTreatmentName()
                                : "N/A";


                            String paymentStatus =
                                bill.getPaymentStatus() != null
                                ? bill.getPaymentStatus()
                                : "N/A";


                            String paymentDate =
                                bill.getPaymentDate() != null
                                ? bill.getPaymentDate()
                                : "N/A";

                %>


                    <tr>


                        <!-- BILL ID -->

                        <td>

                            #<%= bill.getBillId() %>

                        </td>



                        <!-- PATIENT -->

                        <td>

                            <%= patientName %>

                        </td>



                        <!-- TREATMENT -->

                        <td>

                            <%= treatmentName %>

                        </td>



                        <!-- AMOUNT -->

                        <td>

                            Rs.
                            <%= String.format(
                                "%.2f",
                                bill.getAmount()
                            ) %>

                        </td>



                        <!-- PAYMENT STATUS -->

                        <td>

                            <span
                                class="status
                                <%= paymentStatus %>">

                                <%= paymentStatus %>

                            </span>

                        </td>



                        <!-- PAYMENT DATE -->

                        <td>

                            <%= paymentDate %>

                        </td>



                        <!-- =========================================
                             ACTIONS
                        ========================================== -->

                        <td>


                            <div class="action-buttons">


                                <!-- PRINT RECEIPT BUTTON -->

                                <button

                                    type="button"

                                    class="
                                        btn
                                        btn-sm
                                        btn-success
                                        print-receipt-btn
                                    "

                                    data-bill-id="<%= bill.getBillId() %>"

                                    data-patient="<%= patientName %>"

                                    data-treatment="<%= treatmentName %>"

                                    data-amount="<%= String.format(
                                        "%.2f",
                                        bill.getAmount()
                                    ) %>"

                                    data-status="<%= paymentStatus %>"

                                    data-date="<%= paymentDate %>">

                                    <i class="bi bi-printer"></i>

                                    Print Receipt

                                </button>


                            </div>


                        </td>


                    </tr>


                <%

                        }

                    } else {

                %>


                    <!-- NO RECORDS -->

                    <tr>

                        <td
                            colspan="7"
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



<!-- =========================================
     RECEIPT PRINT JAVASCRIPT
========================================= -->

<script>


document
    .querySelectorAll(".print-receipt-btn")
    .forEach(function(button) {


        button.addEventListener(
            "click",
            function() {


                // =========================================
                // GET DATA FROM BUTTON
                // =========================================

                const billId =

                    button.getAttribute(
                        "data-bill-id"
                    );


                const patientName =

                    button.getAttribute(
                        "data-patient"
                    );


                const treatmentName =

                    button.getAttribute(
                        "data-treatment"
                    );


                const amount =

                    button.getAttribute(
                        "data-amount"
                    );


                const paymentStatus =

                    button.getAttribute(
                        "data-status"
                    );


                const paymentDate =

                    button.getAttribute(
                        "data-date"
                    );



                // =========================================
                // OPEN RECEIPT WINDOW
                // =========================================

                const receiptWindow =

                    window.open(
                        "",
                        "Print Receipt",
                        "width=800,height=700"
                    );



                // =========================================
                // WRITE RECEIPT
                // =========================================

                receiptWindow.document.write(`

                    <!DOCTYPE html>

                    <html>

                    <head>

                        <meta charset="UTF-8">

                        <title>
                            Sunrise Dental Clinic Receipt
                        </title>


                        <style>


                            body {

                                font-family:
                                    Arial,
                                    sans-serif;

                                padding: 40px;

                                color: #333;

                                background: #ffffff;

                            }


                            .receipt {

                                max-width: 700px;

                                margin: auto;

                                border:
                                    1px solid
                                    #ddd;

                                padding: 30px;

                                border-radius: 10px;

                            }


                            .header {

                                text-align: center;

                                border-bottom:
                                    2px solid
                                    #1565c0;

                                padding-bottom: 15px;

                                margin-bottom: 25px;

                            }


                            .header h2 {

                                margin-bottom: 5px;

                            }


                            .header p {

                                margin-top: 5px;

                                color: #666;

                            }


                            table {

                                width: 100%;

                                border-collapse:
                                    collapse;

                            }


                            th,
                            td {

                                border:
                                    1px solid
                                    #ddd;

                                padding: 12px;

                                text-align: left;

                            }


                            th {

                                background:
                                    #f4f6f9;

                                width: 40%;

                            }


                            .total {

                                font-size: 22px;

                                font-weight: bold;

                                color: #1565c0;

                            }


                            .footer {

                                text-align: center;

                                margin-top: 30px;

                                color: #666;

                            }


                            @media print {

                                body {

                                    padding: 0;

                                }


                                .receipt {

                                    border: none;

                                }

                            }


                        </style>

                    </head>


                    <body>


                        <div class="receipt">


                            <!-- RECEIPT HEADER -->

                            <div class="header">

                                <h2>

                                    Sunrise Dental Clinic

                                </h2>


                                <p>

                                    Patient Payment Receipt

                                </p>

                            </div>



                            <!-- RECEIPT DETAILS -->

                            <table>


                                <tr>

                                    <th>

                                        Bill ID

                                    </th>


                                    <td>

                                        #\${billId}

                                    </td>

                                </tr>



                                <tr>

                                    <th>

                                        Patient Name

                                    </th>


                                    <td>

                                        \${patientName}

                                    </td>

                                </tr>



                                <tr>

                                    <th>

                                        Treatment

                                    </th>


                                    <td>

                                        \${treatmentName}

                                    </td>

                                </tr>



                                <tr>

                                    <th>

                                        Payment Status

                                    </th>


                                    <td>

                                        \${paymentStatus}

                                    </td>

                                </tr>



                                <tr>

                                    <th>

                                        Payment Date

                                    </th>


                                    <td>

                                        \${paymentDate}

                                    </td>

                                </tr>



                                <tr>

                                    <th>

                                        Total Amount

                                    </th>


                                    <td
                                        class="total">

                                        Rs.
                                        \${amount}

                                    </td>

                                </tr>


                            </table>



                            <!-- FOOTER -->

                            <div class="footer">


                                <p>

                                    Thank you for choosing
                                    Sunrise Dental Clinic.

                                </p>


                                <p>

                                    This is a
                                    computer-generated receipt.

                                </p>


                            </div>


                        </div>


                    </body>


                    </html>

                `);



                // =========================================
                // CLOSE DOCUMENT
                // =========================================

                receiptWindow.document.close();



                // =========================================
                // PRINT RECEIPT
                // =========================================

                setTimeout(
                    function() {

                        receiptWindow.print();

                    },
                    500
                );


            }

        );


    });


</script>


</body>

</html>