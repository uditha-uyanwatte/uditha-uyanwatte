<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="model.Report"%>
<%@ page import="java.util.Map" %>

<%
Map<String,Double> revenueData =
(Map<String,Double>)request.getAttribute("revenueData");

Map<String,Integer> statusData =
(Map<String,Integer>)request.getAttribute("statusData");
%>

<%



if(session.getAttribute("user")==null){
    response.sendRedirect("login.jsp");
    return;
}

Report report = (Report) request.getAttribute("report");
%>
<%
if(report == null){
    response.sendRedirect("ReportsServlet");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Reports | Sunrise Dental Clinic</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
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

            <i class="bi bi-bar-chart-fill"></i>

            Reports Dashboard

        </h2>

        <p>

            Analyze clinic performance, revenue and statistics.

        </p>

    </div>

</div>

<div class="table-card mb-4">

<h4 class="mb-4">

<i class="bi bi-calendar-range-fill text-info"></i>

Generate Reports

</h4>

<form action="ReportsServlet" method="get">

<div class="row">

<div class="col-md-4 mb-3">

<label class="form-label">

From Date

</label>

<input
type="date"
name="fromDate"
class="form-control">

</div>

<div class="col-md-4 mb-3">

<label class="form-label">

To Date

</label>

<input
type="date"
name="toDate"
class="form-control">

</div>

<div class="col-md-4 d-flex align-items-end">

<button
class="save-btn w-100">

<i class="bi bi-search"></i>

Generate Report

</button>

</div>

</div>

</form>

</div>

<div class="row">

<div class="col-xl-4 col-lg-6 mb-4">

<div class="dashboard-card">

<div class="card-icon bg-primary">

<i class="bi bi-people-fill"></i>

</div>

<div class="card-content">

<small>Total Patients</small>

<h2><%= report.getTotalPatients() %></h2>

<span class="text-info">

Clinic Records

</span>

</div>

</div>

</div>

<div class="col-xl-4 col-lg-6 mb-4">

<div class="dashboard-card">

<div class="card-icon bg-success">

<i class="bi bi-calendar-check-fill"></i>

</div>

<div class="card-content">

<small>Appointments</small>

<h2><%= report.getTotalAppointments() %></h2>

<span class="text-success">

Completed Schedule

</span>

</div>

</div>

</div>

<div class="col-xl-4 col-lg-6 mb-4">

<div class="dashboard-card">

<div class="card-icon bg-danger">

<i class="bi bi-cash-stack"></i>

</div>

<div class="card-content">

<small>Total Revenue</small>

<h2>

Rs. <%= String.format("%,.2f", report.getTotalRevenue()) %>

</h2>

<span class="text-danger">

Revenue

</span>

</div>

</div>

</div>

<div class="col-xl-4 col-lg-6 mb-4">

<div class="dashboard-card">

<div class="card-icon bg-info">

<i class="bi bi-heart-pulse-fill"></i>

</div>

<div class="card-content">

<small>Treatments</small>

<h2><%= report.getTotalTreatments() %></h2>

<span class="text-info">

Completed

</span>

</div>

</div>

</div>

<div class="col-xl-4 col-lg-6 mb-4">

<div class="dashboard-card">

<div class="card-icon bg-success">

<i class="bi bi-check-circle-fill"></i>

</div>

<div class="card-content">

<small>Paid Bills</small>

<h2><%= report.getPaidBills() %></h2>

<span class="text-success">

Paid

</span>

</div>

</div>

</div>

<div class="col-xl-4 col-lg-6 mb-4">

<div class="dashboard-card">

<div class="card-icon bg-warning">

<i class="bi bi-hourglass-split"></i>

</div>

<div class="card-content">

<small>Pending Bills</small>

<h2><%= report.getPendingBills() %></h2>

<span class="text-warning">

Pending

</span>

</div>

</div>

</div>

</div>

<div class="row mb-4">

    <!-- Revenue Chart -->

    <div class="col-lg-8">

        <div class="table-card">

            <div class="d-flex justify-content-between align-items-center mb-4">

                <h4>

                    <i class="bi bi-graph-up-arrow text-success"></i>

                    Monthly Revenue

                </h4>

                <span class="badge bg-success">

                    Revenue Analytics

                </span>

            </div>

            <div style="height:350px;">

                <canvas id="revenueChart"></canvas>

            </div>

        </div>

    </div>

    <!-- Appointment Status -->

    <div class="col-lg-4">

        <div class="table-card">

            <div class="d-flex justify-content-between align-items-center mb-4">

                <h4>

                    <i class="bi bi-pie-chart-fill text-info"></i>

                    Appointment Status

                </h4>

            </div>

            <div style="height:350px;">

                <canvas id="statusChart"></canvas>

            </div>

        </div>

    </div>

</div>

<!-- Report Actions -->

<div class="table-card">

    <div class="d-flex justify-content-between align-items-center mb-4">

        <h4>

            <i class="bi bi-file-earmark-bar-graph-fill text-info"></i>

            Report Actions

        </h4>

    </div>

    <div class="row">

        <div class="col-lg-3 col-md-6 mb-3">

            <button
                class="btn btn-primary w-100"
                onclick="printReport()">

                <i class="bi bi-printer-fill"></i>

                Print Report

            </button>

        </div>

        <div class="col-lg-3 col-md-6 mb-3">

            <a href="ExportPDFServlet"
               class="btn btn-danger w-100">

                <i class="bi bi-file-earmark-pdf-fill"></i>

                Export PDF

            </a>

        </div>

        <div class="col-lg-3 col-md-6 mb-3">

            <a href="ExportExcelServlet"
               class="btn btn-success w-100">

                <i class="bi bi-file-earmark-excel-fill"></i>

                Export Excel

            </a>

        </div>

        <div class="col-lg-3 col-md-6 mb-3">

            <a href="ReportsServlet"
               class="btn btn-info text-white w-100">

                <i class="bi bi-arrow-repeat"></i>

                Refresh

            </a>

        </div>

    </div>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>

// Revenue Chart

const revenueLabels = [

<%
for(String month : revenueData.keySet()){
%>

"<%=month%>",

<%
}
%>

];

const revenueValues = [

<%
for(Double value : revenueData.values()){
%>

<%=value%>,

<%
}
%>

];

new Chart(document.getElementById("revenueChart"),{

type:"bar",

data:{

labels:revenueLabels,

datasets:[{

label:"Monthly Revenue",

data:revenueValues,

backgroundColor:"#50E8F4",

borderRadius:12,

borderSkipped:false

}]

},

options:{

responsive:true,

maintainAspectRatio:false,

plugins:{

legend:{

display:true,

labels:{

color:"#666"

}

}

},

scales:{

y:{

beginAtZero:true,

grid:{

color:"#E5E5E5"

}

},

x:{

grid:{

display:false

}

}

}

}

});

// Status Chart

const statusLabels = [

<%

for(String s : statusData.keySet()){

%>

"<%=s%>",

<%

}

%>

];

const statusValues = [

<%

for(Integer c : statusData.values()){

%>

<%=c%>,

<%

}

%>

];

new Chart(document.getElementById("statusChart"),{

type:"doughnut",

data:{

labels:statusLabels,

datasets:[{

data:statusValues,

backgroundColor:[

"#198754",

"#FFC107",

"#DC3545",

"#0DCAF0"

],

borderWidth:2,

hoverOffset:10

}]

},

options:{

responsive:true,

maintainAspectRatio:false,

plugins:{

legend:{

position:"bottom"

}

}

}

});

// Print

function printReport(){

window.print();

}

</script>

</body>

</html>