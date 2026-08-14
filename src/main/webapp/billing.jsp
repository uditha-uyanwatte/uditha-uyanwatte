<%@page import="java.util.List"%>
<%@page import="dao.PatientDAO"%>
<%@page import="dao.TreatmentDAO"%>
<%@page import="model.Patient"%>
<%@page import="model.Treatment"%>
<%@page import="dao.BillingDAO"%>
<%@page import="model.Billing"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
if(session.getAttribute("username")==null){
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

if(keyword != null && !keyword.trim().isEmpty()){

    bills = billingDAO.searchBills(keyword);

}else{

    bills = billingDAO.getAllBills();

}
%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Billing Management</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link rel="stylesheet" href="assets/css/style.css">

</head>

<body class="<%= session.getAttribute("theme") != null ? session.getAttribute("theme") : "light" %>">

<jsp:include page="includes/sidebar.jsp"/>
<jsp:include page="includes/navbar.jsp"/>

<div class="main-content">

<div class="container-fluid p-4">

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

<% if(request.getParameter("success")!=null){ %>

<div class="alert alert-success">

    Bill Added Successfully.

</div>

<% } %>

<% if(request.getParameter("updated")!=null){ %>

<div class="alert alert-warning">

    Bill Updated Successfully.

</div>

<% } %>

<% if(request.getParameter("deleted")!=null){ %>

<div class="alert alert-danger">

    Bill Deleted Successfully.

</div>

<% } %>

<div class="table-card mb-4">

    <h4 class="mb-4">

        <i class="bi bi-receipt-cutoff text-info"></i>

        Create New Invoice

    </h4>

    <form action="AddBillingServlet" method="post">

        <div class="row">

            <div class="col-md-6 mb-3">

                <label class="form-label">Patient</label>

                <select name="patientId" class="form-select" required>

                    <option value="">Select Patient</option>

                    <% for(Patient p : patients){ %>

                    <option value="<%=p.getPatientId()%>">

                        <%=p.getFirstName()%> <%=p.getLastName()%>

                    </option>

                    <% } %>

                </select>

            </div>

            <div class="col-md-6 mb-3">

                <label class="form-label">Treatment</label>

                <select name="treatmentId" class="form-select" required>

                    <option value="">Select Treatment</option>

                    <% for(Treatment t : treatments){ %>

                    <option value="<%=t.getTreatmentId()%>">

                        <%=t.getTreatmentName()%>

                    </option>

                    <% } %>

                </select>

            </div>

            <div class="col-md-6 mb-3">

                <label class="form-label">Amount (Rs.)</label>

                <input type="number"
                       step="0.01"
                       name="amount"
                       class="form-control"
                       placeholder="Enter Amount"
                       required>

            </div>

            <div class="col-md-6 mb-3">

                <label class="form-label">Payment Status</label>

                <select name="paymentStatus" class="form-select">

                    <option>Pending</option>
                    <option>Paid</option>

                </select>

            </div>

            <div class="col-md-6 mb-4">

                <label class="form-label">Payment Date</label>

                <input type="date"
                       name="paymentDate"
                       class="form-control"
                       required>

            </div>

            <div class="col-12">

                <button type="submit" class="save-btn">

                    <i class="bi bi-check2-circle"></i>

                    Save Invoice

                </button>

            </div>

        </div>

    </form>

</div>

<div class="table-card">

    <div class="d-flex justify-content-between align-items-center mb-4">

        <h4>

            <i class="bi bi-receipt text-info"></i>

            Invoice Records

        </h4>

        <span class="badge bg-info">

            <%= bills.size() %> Bills

        </span>

    </div>

    <form method="get">

        <div class="row g-3">

            <div class="col-lg-10">

                <div class="input-group">

                    <span class="input-group-text bg-dark border-info text-info">

                        <i class="bi bi-search"></i>

                    </span>

                    <input type="text"
                           name="search"
                           class="form-control search-input"
                           placeholder="Search Amount, Status or Date..."
                           value="<%= keyword==null ? "" : keyword %>">

                </div>

            </div>

            <div class="col-lg-2 d-grid">

                <button class="btn btn-info fw-bold">

                    <i class="bi bi-search"></i>

                    Search

                </button>

            </div>

        </div>

    </form>

    <div class="mt-3">

        <a href="billing.jsp" class="btn btn-outline-light">

            <i class="bi bi-arrow-clockwise"></i>

            Reset

        </a>

    </div>

    <hr class="my-4">

    <div class="table-responsive">

        <table class="table patient-table align-middle">

            <thead>

                <tr>

                    <th>ID</th>
                    <th>Patient</th>
                    <th>Treatment</th>
                    <th>Amount</th>
                    <th>Status</th>
                    <th>Payment Date</th>
                    <th class="text-center">Actions</th>

                </tr>

            </thead>

            <tbody>

 <%
for(Billing b : bills){
%>

<tr>

    <td>

        <span class="patient-id">

            #<%= b.getBillId() %>

        </span>

    </td>

    <td>

        <div class="d-flex align-items-center">

            <div class="patient-avatar">

                <i class="bi bi-person-fill"></i>

            </div>

            <div class="ms-3">

                <strong>

                    <%= b.getPatientName() %>

                </strong>

            </div>

        </div>

    </td>

    <td>

        <span class="badge bg-primary">

            <%= b.getTreatmentName() %>

        </span>

    </td>

    <td>

        <strong class="text-success">

            Rs. <%= String.format("%,.2f", b.getAmount()) %>

        </strong>

    </td>

    <td>

    <% if("Paid".equalsIgnoreCase(b.getPaymentStatus())){ %>

        <span class="badge bg-success">

            <i class="bi bi-check-circle-fill"></i>

            Paid

        </span>

    <% }else{ %>

        <span class="badge bg-warning text-dark">

            <i class="bi bi-clock-fill"></i>

            Pending

        </span>

    <% } %>

    </td>

    <td>

        <%= b.getPaymentDate() %>

    </td>

    <td class="text-center">

        <a href="editBilling.jsp?id=<%= b.getBillId() %>"

           class="btn btn-warning btn-sm rounded-circle me-2">

            <i class="bi bi-pencil"></i>

        </a>

        <a href="DeleteBillingServlet?id=<%= b.getBillId() %>"

           class="btn btn-danger btn-sm rounded-circle"

           onclick="return confirm('Delete this bill?');">

            <i class="bi bi-trash"></i>

        </a>

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

</div>

</body>

</html>