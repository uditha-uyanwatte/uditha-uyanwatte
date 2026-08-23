<%@ page import="dao.BillingDAO" %>
<%@ page import="dao.PatientDAO" %>
<%@ page import="dao.TreatmentDAO" %>
<%@ page import="model.Billing" %>
<%@ page import="model.Patient" %>
<%@ page import="model.Treatment" %>
<%@ page import="java.util.List" %>

<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String id = request.getParameter("id");

    if (id == null || id.trim().isEmpty()) {
        response.sendRedirect("billing.jsp");
        return;
    }

    BillingDAO billingDAO = new BillingDAO();

    Billing bill =
            billingDAO.getBillById(
                    Integer.parseInt(id)
            );

    if (bill == null) {
        response.sendRedirect("billing.jsp");
        return;
    }

    PatientDAO patientDAO =
            new PatientDAO();

    TreatmentDAO treatmentDAO =
            new TreatmentDAO();

    List<Patient> patients =
            patientDAO.getAllPatients();

    List<Treatment> treatments =
            treatmentDAO.getAllTreatments();
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>Edit Billing</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

</head>

<body class="bg-light">

<div class="container py-5">

    <div class="card shadow">

        <div class="card-header bg-primary text-white">

            <h3 class="mb-0">
                Edit Bill
            </h3>

        </div>

        <div class="card-body">

            <form action="UpdateBillingServlet"
                  method="post">

                <input
                    type="hidden"
                    name="billId"
                    value="<%= bill.getBillId() %>">

                <div class="row">

                    <!-- PATIENT -->

                    <div class="col-md-6 mb-3">

                        <label class="form-label">
                            Patient
                        </label>

                        <select
                            name="patientId"
                            class="form-select"
                            required>

                            <option value="">
                                Select Patient
                            </option>

                            <% for (Patient patient : patients) { %>

                                <option
                                    value="<%= patient.getPatientId() %>"

                                    <%= patient.getPatientId()
                                            == bill.getPatientId()
                                            ? "selected"
                                            : "" %>>

                                    <%= patient.getFirstName() %>
                                    <%= patient.getLastName() %>

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
                            class="form-select"
                            required>

                            <option value="">
                                Select Treatment
                            </option>

                            <% for (Treatment treatment : treatments) { %>

                                <option
                                    value="<%= treatment.getTreatmentId() %>"

                                    <%= treatment.getTreatmentId()
                                            == bill.getTreatmentId()
                                            ? "selected"
                                            : "" %>>

                                    <%= treatment.getTreatmentName() %>

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
                            name="amount"
                            class="form-control"
                            value="<%= bill.getAmount() %>"
                            required>

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

                            <option
                                value="Pending"

                                <%= "Pending".equalsIgnoreCase(
                                        bill.getPaymentStatus()
                                    )
                                    ? "selected"
                                    : "" %>>

                                Pending

                            </option>

                            <option
                                value="Paid"

                                <%= "Paid".equalsIgnoreCase(
                                        bill.getPaymentStatus()
                                    )
                                    ? "selected"
                                    : "" %>>

                                Paid

                            </option>

                        </select>

                    </div>


                    <!-- PAYMENT DATE -->

                    <div class="col-md-6 mb-3">

                        <label class="form-label">
                            Payment Date
                        </label>

                        <input
                            type="date"
                            name="paymentDate"
                            class="form-control"
                            value="<%= bill.getPaymentDate() %>"
                            required>

                    </div>

                </div>


                <div class="mt-3">

                    <button
                        type="submit"
                        class="btn btn-primary">

                        Update Bill

                    </button>

                    <a
                        href="billing.jsp"
                        class="btn btn-secondary">

                        Cancel

                    </a>

                </div>

            </form>

        </div>

    </div>

</div>

</body>

</html>