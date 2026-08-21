<%@page import="java.util.List"%>
<%@page import="dao.PatientDAO"%>
<%@page import="dao.TreatmentDAO"%>
<%@page import="model.Patient"%>
<%@page import="model.Treatment"%>
<%@page import="dao.BillingDAO"%>
<%@page import="model.Billing"%>
<%@page language="java"
        contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    PatientDAO patientDAO = new PatientDAO();
    TreatmentDAO treatmentDAO = new TreatmentDAO();

    List<Patient> patients = patientDAO.getAllPatients();
    List<Treatment> treatments = treatmentDAO.getAllTreatments();

    BillingDAO billingDAO = new BillingDAO();

    String keyword = request.getParameter("search");

    List<Billing> bills;

    if (keyword != null && !keyword.trim().isEmpty()) {

        bills = billingDAO.searchBills(keyword);

    } else {

        bills = billingDAO.getAllBills();
    }
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Billing Management</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <link
        rel="stylesheet"
        href="assets/css/style.css">

</head>


<body class="<%= session.getAttribute("theme") != null
        ? session.getAttribute("theme")
        : "light" %>">


<jsp:include page="includes/sidebar.jsp"/>

<jsp:include page="includes/navbar.jsp"/>


<div class="main-content">

<div class="container-fluid p-4">


<!-- =========================
     PAGE HEADER
========================= -->

<div class="page-header mb-4">

    <div>

        <h2>

            <i class="bi bi-cash-coin"></i>

            Billing

        </h2>

        <p>

            Manage invoices and patient payments.

        </p>

    </div>

</div>


<!-- =========================
     SUCCESS MESSAGE
========================= -->

<% if(request.getParameter("success") != null){ %>

<div class="alert alert-success">

    <i class="bi bi-check-circle-fill"></i>

    Bill Added Successfully.

</div>

<% } %>


<!-- =========================
     UPDATE MESSAGE
========================= -->

<% if(request.getParameter("updated") != null){ %>

<div class="alert alert-warning">

    <i class="bi bi-pencil-square"></i>

    Bill Updated Successfully.

</div>

<% } %>


<!-- =========================
     DELETE MESSAGE
========================= -->

<% if(request.getParameter("deleted") != null){ %>

<div class="alert alert-danger">

    <i class="bi bi-trash-fill"></i>

    Bill Deleted Successfully.

</div>

<% } %>


<!-- =========================
     ERROR MESSAGES
========================= -->

<% if(request.getParameter("error") != null){ %>

<div class="alert alert-danger">

    <i class="bi bi-exclamation-triangle-fill"></i>

    <%
        String error =
                request.getParameter("error");

        if("empty".equals(error)) {

            out.print(
                "Please fill in all required fields."
            );

        } else if("amount".equals(error)) {

            out.print(
                "Please enter a valid amount."
            );

        } else if("patient".equals(error)) {

            out.print(
                "Selected patient was not found."
            );

        } else if("treatment".equals(error)) {

            out.print(
                "Selected treatment was not found."
            );

        } else if("invalid".equals(error)) {

            out.print(
                "Invalid billing information."
            );

        } else {

            out.print(
                "Unable to create the invoice."
            );
        }
    %>

</div>

<% } %>


<!-- =========================
     CREATE INVOICE
========================= -->

<div class="table-card mb-4">

    <h4 class="mb-4">

        <i class="bi bi-receipt-cutoff text-info"></i>

        Create New Invoice

    </h4>


    <form
        action="AddBillingServlet"
        method="post"
        onsubmit="return validateBillingForm();">


        <div class="row">


            <!-- PATIENT -->

            <div class="col-md-6 mb-3">

                <label class="form-label">

                    Patient

                </label>

                <select
                    name="patientId"
                    id="patientId"
                    class="form-select"
                    required>

                    <option value="">

                        Select Patient

                    </option>


                    <% for(Patient p : patients){ %>

                    <option
                        value="<%= p.getPatientId() %>">

                        <%= p.getFirstName() %>
                        <%= p.getLastName() %>

                    </option>

                    <% } %>

                </select>

            </div>


            <!-- TREATMENT -->

            <div class="col-md-6 mb-3">

                <label class="form-label">

                    Treatment

                </label>

                <select
                    name="treatmentId"
                    id="treatmentId"
                    class="form-select"
                    required
                    onchange="setTreatmentCost();">

                    <option value="">

                        Select Treatment

                    </option>


                    <% for(Treatment t : treatments){ %>

                    <option
                        value="<%= t.getTreatmentId() %>"
                        data-cost="<%= t.getCost() %>">

                        <%= t.getTreatmentName() %>

                        -
                        Rs.
                        <%= String.format(
                                "%,.2f",
                                t.getCost()
                           ) %>

                    </option>

                    <% } %>

                </select>

            </div>


            <!-- AMOUNT -->

            <div class="col-md-6 mb-3">

                <label class="form-label">

                    Amount (Rs.)

                </label>

                <input
                    type="number"
                    step="0.01"
                    min="0.01"
                    name="amount"
                    id="amount"
                    class="form-control"
                    placeholder="Enter Amount"
                    required>

                <small class="text-muted">

                    Treatment cost will be loaded automatically.

                </small>

            </div>


            <!-- PAYMENT STATUS -->

            <div class="col-md-6 mb-3">

                <label class="form-label">

                    Payment Status

                </label>

                <select
                    name="paymentStatus"
                    class="form-select"
                    required>

                    <option value="Pending">

                        Pending

                    </option>

                    <option value="Paid">

                        Paid

                    </option>

                </select>

            </div>


            <!-- PAYMENT DATE -->

            <div class="col-md-6 mb-4">

                <label class="form-label">

                    Payment Date

                </label>

                <input
                    type="date"
                    name="paymentDate"
                    id="paymentDate"
                    class="form-control"
                    required>

            </div>


            <!-- SAVE -->

            <div class="col-12">

                <button
                    type="submit"
                    class="save-btn">

                    <i class="bi bi-check2-circle"></i>

                    Save Invoice

                </button>

            </div>

        </div>

    </form>

</div>


<!-- =========================
     INVOICE RECORDS
========================= -->

<div class="table-card">


    <div class="d-flex
                justify-content-between
                align-items-center
                mb-4">

        <h4>

            <i class="bi bi-receipt text-info"></i>

            Invoice Records

        </h4>


        <span class="badge bg-info">

            <%= bills.size() %>

            Bills

        </span>

    </div>


    <!-- SEARCH -->

    <form method="get">

        <div class="row g-3">


            <div class="col-lg-10">

                <div class="input-group">

                    <span
                        class="input-group-text
                               bg-dark
                               border-info
                               text-info">

                        <i class="bi bi-search"></i>

                    </span>


                    <input
                        type="text"
                        name="search"
                        class="form-control search-input"
                        placeholder="Search Amount, Status or Date..."
                        value="<%= keyword == null
                                ? ""
                                : keyword %>">

                </div>

            </div>


            <div class="col-lg-2 d-grid">

                <button
                    type="submit"
                    class="btn btn-info fw-bold">

                    <i class="bi bi-search"></i>

                    Search

                </button>

            </div>

        </div>

    </form>


    <!-- RESET -->

    <div class="mt-3">

        <a
            href="billing.jsp"
            class="btn btn-outline-light">

            <i class="bi bi-arrow-clockwise"></i>

            Reset

        </a>

    </div>


    <hr class="my-4">


    <!-- TABLE -->

    <div class="table-responsive">

        <table
            class="table patient-table align-middle">


            <thead>

                <tr>

                    <th>ID</th>

                    <th>Patient</th>

                    <th>Treatment</th>

                    <th>Amount</th>

                    <th>Status</th>

                    <th>Payment Date</th>

                    <th class="text-center">

                        Actions

                    </th>

                </tr>

            </thead>


            <tbody>


            <% if(bills != null &&
                  !bills.isEmpty()){ %>


                <% for(Billing b : bills){ %>


                <tr>


                    <!-- BILL ID -->

                    <td>

                        <span class="patient-id">

                            #<%= b.getBillId() %>

                        </span>

                    </td>


                    <!-- PATIENT -->

                    <td>

                        <div
                            class="d-flex align-items-center">

                            <div class="patient-avatar">

                                <i
                                    class="bi bi-person-fill">
                                </i>

                            </div>


                            <div class="ms-3">

                                <strong>

                                    <%= b.getPatientName() %>

                                </strong>

                            </div>

                        </div>

                    </td>


                    <!-- TREATMENT -->

                    <td>

                        <span
                            class="badge bg-primary">

                            <%= b.getTreatmentName() %>

                        </span>

                    </td>


                    <!-- AMOUNT -->

                    <td>

                        <strong
                            class="text-success">

                            Rs.

                            <%= String.format(
                                    "%,.2f",
                                    b.getAmount()
                               ) %>

                        </strong>

                    </td>


                    <!-- STATUS -->

                    <td>


                        <% if("Paid".equalsIgnoreCase(
                                b.getPaymentStatus())){ %>


                        <span
                            class="badge bg-success">

                            <i
                                class="bi bi-check-circle-fill">
                            </i>

                            Paid

                        </span>


                        <% } else { %>


                        <span
                            class="badge
                                   bg-warning
                                   text-dark">

                            <i
                                class="bi bi-clock-fill">
                            </i>

                            Pending

                        </span>


                        <% } %>


                    </td>


                    <!-- DATE -->

                    <td>

                        <%= b.getPaymentDate() %>

                    </td>


                    <!-- ACTIONS -->

                    <td class="text-center">


                        <!-- EDIT -->

                        <a
                            href="editBilling.jsp?id=<%= b.getBillId() %>"
                            class="btn btn-warning
                                   btn-sm
                                   rounded-circle
                                   me-2">

                            <i
                                class="bi bi-pencil">
                            </i>

                        </a>


                        <!-- DELETE -->

                        <a
                            href="DeleteBillingServlet?id=<%= b.getBillId() %>"
                            class="btn btn-danger
                                   btn-sm
                                   rounded-circle"

                            onclick="return confirm(
                                'Delete this bill?'
                            );">

                            <i
                                class="bi bi-trash">
                            </i>

                        </a>


                    </td>


                </tr>


                <% } %>


            <% } else { %>


                <tr>

                    <td
                        colspan="7"
                        class="text-center p-5">

                        <i
                            class="bi bi-receipt"
                            style="font-size:45px;">
                        </i>

                        <br><br>

                        No invoice records found.

                    </td>

                </tr>


            <% } %>


            </tbody>

        </table>

    </div>

</div>


</div>

</div>

</div>


<!-- =========================
     JAVASCRIPT
========================= -->

<script>

function setTreatmentCost() {

    const treatment =
        document.getElementById("treatmentId");

    const amount =
        document.getElementById("amount");

    const selectedOption =
        treatment.options[
            treatment.selectedIndex
        ];


    if (
        selectedOption &&
        selectedOption.value !== ""
    ) {

        const cost =
            selectedOption.getAttribute(
                "data-cost"
            );


        if (cost !== null) {

            amount.value =
                parseFloat(cost).toFixed(2);

        }

    } else {

        amount.value = "";

    }
}


function validateBillingForm() {

    const patient =
        document.getElementById(
            "patientId"
        ).value;

    const treatment =
        document.getElementById(
            "treatmentId"
        ).value;

    const amount =
        document.getElementById(
            "amount"
        ).value;

    const paymentDate =
        document.getElementById(
            "paymentDate"
        ).value;


    if (patient === "") {

        alert(
            "Please select a patient."
        );

        return false;
    }


    if (treatment === "") {

        alert(
            "Please select a treatment."
        );

        return false;
    }


    if (
        amount === "" ||
        parseFloat(amount) <= 0
    ) {

        alert(
            "Please enter a valid amount."
        );

        return false;
    }


    if (paymentDate === "") {

        alert(
            "Please select the payment date."
        );

        return false;
    }


    return true;
}

</script>


</body>

</html>