<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="dao.PatientDAO"%>
<%@ page import="dao.TreatmentDAO"%>
<%@ page import="model.Patient"%>
<%@ page import="model.Treatment"%>

<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    PatientDAO patientDAO = new PatientDAO();
    TreatmentDAO treatmentDAO = new TreatmentDAO();

    List<Patient> patients = patientDAO.getAllPatients();
    List<Treatment> treatments = treatmentDAO.getAllTreatments();
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>Create Bill</title>

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

.billing-box {
    max-width: 800px;
    margin: 50px auto;
    background: white;
    padding: 35px;
    border-radius: 15px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.10);
}

.page-header {
    background: linear-gradient(135deg, #1e88e5, #1565c0);
    color: white;
    padding: 20px;
    border-radius: 12px;
    margin-bottom: 30px;
}

</style>

</head>

<body>

<div class="container">

    <div class="billing-box">

        <!-- HEADER -->

        <div class="page-header">

            <h3 class="mb-1">

                <i class="bi bi-receipt"></i>
                Create New Bill

            </h3>

            <p class="mb-0">
                Create a billing record for a patient
            </p>

        </div>


        <!-- BILL FORM -->

        <form action="ReceptionAddBillingServlet"
              method="post">

            <div class="row">


                <!-- PATIENT -->

                <div class="col-md-6 mb-3">

                    <label class="form-label">

                        Patient

                    </label>

                    <select name="patientId"
                            class="form-select"
                            required>

                        <option value="">

                            Select Patient

                        </option>

                        <%
                            if (patients != null) {

                                for (Patient patient : patients) {
                        %>

                            <option value="<%= patient.getPatientId() %>">

                                <%= patient.getFirstName() %>
                                <%= patient.getLastName() %>

                            </option>

                        <%
                                }
                            }
                        %>

                    </select>

                </div>


                <!-- TREATMENT -->

                <div class="col-md-6 mb-3">

                    <label class="form-label">

                        Treatment

                    </label>

                    <select name="treatmentId"
                            class="form-select"
                            required>

                        <option value="">

                            Select Treatment

                        </option>

                        <%
                            if (treatments != null) {

                                for (Treatment treatment : treatments) {
                        %>

                            <option value="<%= treatment.getTreatmentId() %>">

                                <%= treatment.getTreatmentName() %>

                            </option>

                        <%
                                }
                            }
                        %>

                    </select>

                </div>


                <!-- AMOUNT -->

                <div class="col-md-6 mb-3">

                    <label class="form-label">

                        Amount (Rs.)

                    </label>

                    <input type="number"
                           name="amount"
                           class="form-control"
                           min="1"
                           step="0.01"
                           required>

                </div>


                <!-- PAYMENT STATUS -->

                <div class="col-md-6 mb-3">

                    <label class="form-label">

                        Payment Status

                    </label>

                    <select name="paymentStatus"
                            class="form-select"
                            required>

                        <option value="Pending">

                            Pending

                        </option>

                        <option value="Paid">

                            Paid

                        </option>

                        <option value="Unpaid">

                            Unpaid

                        </option>

                    </select>

                </div>


                <!-- PAYMENT DATE -->

                <div class="col-md-12 mb-3">

                    <label class="form-label">

                        Payment Date

                    </label>

                    <input type="date"
                           name="paymentDate"
                           class="form-control"
                           required>

                </div>

            </div>


            <!-- BUTTONS -->

            <div class="mt-4">

                <a href="receptionBilling.jsp"
                   class="btn btn-secondary">

                    <i class="bi bi-arrow-left"></i>
                    Cancel

                </a>

                <button type="submit"
                        class="btn btn-primary">

                    <i class="bi bi-check-circle"></i>
                    Create Bill

                </button>

            </div>

        </form>

    </div>

</div>

</body>

</html>