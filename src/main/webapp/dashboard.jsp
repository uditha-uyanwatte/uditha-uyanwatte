<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="dao.DashboardDAO" %>

<%@ page import="dao.AppointmentDAO" %>
<%@ page import="model.Appointment" %>
<%@ page import="java.util.List" %>



<%


DashboardDAO dashboardDAO = new DashboardDAO();





int totalPatients = dashboardDAO.getPatientCount();
int totalDentists = dashboardDAO.getDentistCount();
int totalAppointments = dashboardDAO.getAppointmentCount();
int totalTreatments = dashboardDAO.getTreatmentCount();
int totalBills = dashboardDAO.getBillingCount();

double totalRevenue = dashboardDAO.getTotalRevenue();

%>

<%@ page import="java.util.Map" %>

<%
Map<String, Double> revenueData = dashboardDAO.getMonthlyRevenue();
Map<String, Integer> statusData = dashboardDAO.getAppointmentStatusCount();
%>

<%
    if(session.getAttribute("user")==null){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%

AppointmentDAO appointmentDAO = new AppointmentDAO();

List<Appointment> recentAppointments =
        appointmentDAO.getRecentAppointments();
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Dashboard | Sunrise Dental Clinic</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

<script>

new Chart(document.getElementById("revenueChart"),{

    type:'bar',

    data:{

        labels:['Jan','Feb','Mar','Apr','May','Jun','Jul'],

        datasets:[{

            label:'Revenue',

            data:[12000,25000,18000,30000,22000,28000,35000]

        }]

    }

});

new Chart(document.getElementById("statusChart"),{

    type:'pie',

    data:{

        labels:['Completed','Pending','Cancelled'],

        datasets:[{

            data:[18,7,2]

        }]

    }

});

</script>

<link rel="stylesheet" href="assets/css/style.css">

</head>


<body class="<%= session.getAttribute("theme") != null ? session.getAttribute("theme") : "light" %>">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<jsp:include page="includes/sidebar.jsp"/>
<jsp:include page="includes/navbar.jsp"/>


<div class="main-content">
<div class="container-fluid mt-4">

<!-- Dashboard Header -->




<div class="row">

    <!-- Patients -->

   <div class="col-xl-4 col-lg-6 mb-4">

    <div class="dashboard-card">

        <div class="card-icon bg-primary">

            <i class="bi bi-people-fill"></i>

        </div>

        <div class="card-content">

            <small>Total Patients</small>

            <h2><%= totalPatients %></h2>

            <span class="text-success">

                <i class="bi bi-arrow-up"></i>

                Active Records

            </span>

        </div>

    </div>

</div>

    <!-- Dentists -->

   <div class="col-xl-4 col-lg-6 mb-4">

    <div class="dashboard-card">

        <div class="card-icon bg-success">

            <i class="bi bi-person-vcard-fill"></i>

        </div>

        <div class="card-content">

            <small>Dentists</small>

            <h2><%= totalDentists %></h2>

            <span class="text-info">

                Available Staff

            </span>

        </div>

    </div>

</div>

    <!-- Appointments -->

    <div class="col-xl-4 col-lg-6 mb-4">

    <div class="dashboard-card">

        <div class="card-icon bg-warning">

            <i class="bi bi-calendar2-check-fill"></i>

        </div>

        <div class="card-content">

            <small>Appointments</small>

            <h2><%= totalAppointments %></h2>

            <span class="text-warning">

                Scheduled

            </span>

        </div>

    </div>

</div>
    
 

    <!-- Revenue -->
<div class="col-xl-6 col-lg-6 mb-4">

    <div class="dashboard-card">

        <div class="card-icon bg-danger">

            <i class="bi bi-cash-stack"></i>

        </div>

        <div class="card-content">

            <small>Total Revenue</small>

            <h2>

                Rs. <%= String.format("%,.2f", totalRevenue) %>

            </h2>

            <span class="text-danger">

                Revenue

            </span>

        </div>

    </div>

</div>



<!-- Treatments -->

<div class="col-xl-3 col-lg-6 mb-4">

    <div class="dashboard-card">

        <div class="card-icon bg-info">

            <i class="bi bi-heart-pulse-fill"></i>

        </div>

        <div class="card-content">

            <small>Treatments</small>

            <h2><%= totalTreatments %></h2>

            <span class="text-info">

                Completed

            </span>

        </div>

    </div>

</div>

<!-- Bills -->

<div class="col-xl-3 col-lg-6 mb-4">

    <div class="dashboard-card">

        <div class="card-icon bg-secondary">

            <i class="bi bi-receipt-cutoff"></i>

        </div>

        <div class="card-content">

            <small>Total Bills</small>

            <h2><%= totalBills %></h2>

            <span class="text-secondary">

                Generated

            </span>

        </div>

    </div>

</div>
<!-- Recent Appointments -->

<div class="row">

    <div class="col-lg-8">

        <div class="table-card">

            <h4 class="mb-3">Recent Appointments</h4>

            <table class="table table-hover align-middle">

                <thead class="table-primary">

                <tr>

                    <th>ID</th>
                    <th>Patient</th>
                    <th>Dentist</th>
                    <th>Date</th>
                    <th>Status</th>

                </tr>

                </thead>

                <tbody>
                
                <div class="row mb-4">

    <div class="col-lg-8">

        <div class="card shadow">

            <div class="card-header bg-primary text-white">
                Monthly Revenue
            </div>

            <div class="card-body">
                <canvas id="revenueChart"></canvas>
            </div>

        </div>

    </div>

    <div class="col-lg-4">

        <div class="card shadow">

            <div class="card-header bg-success text-white">
                Appointment Status
            </div>

            <div class="card-body">
                <canvas id="statusChart"></canvas>
            </div>

        </div>

    </div>

</div>

<%
for(Appointment a : recentAppointments){
%>

<tr>

    <td><%= a.getAppointmentId() %></td>

   <td><%= a.getPatientName() %></td>

<td>Dr. <%= a.getDentistName() %></td>
    <td>
        <%= a.getAppointmentDate() %><br>
        <small class="text-muted"><%= a.getAppointmentTime() %></small>
    </td>

    <td>

    <%
    if("Completed".equalsIgnoreCase(a.getStatus())){
    %>

        <span class="badge bg-success">
            <%= a.getStatus() %>
        </span>

    <%
    }else if("Pending".equalsIgnoreCase(a.getStatus())){
    %>

        <span class="badge bg-warning text-dark">
            <%= a.getStatus() %>
        </span>

    <%
    }else{
    %>

        <span class="badge bg-danger">
            <%= a.getStatus() %>
        </span>

    <%
    }
    %>

    </td>

</tr>

<%
}
%>

</tbody>
            </table>

        </div>

    </div>

    <!-- Quick Actions -->

    <div class="col-lg-4">

        <div class="table-card">

            <h4 class="mb-3">Quick Actions</h4>

            <div class="d-grid gap-3">

                <a href="patients.jsp" class="btn btn-primary">
                    <i class="bi bi-person-plus-fill"></i>
                    Add Patient
                </a>

                <a href="appointments.jsp" class="btn btn-success">
                    <i class="bi bi-calendar-plus-fill"></i>
                    New Appointment
                </a>

                <a href="billing.jsp" class="btn btn-warning text-dark">
                    <i class="bi bi-receipt"></i>
                    Create Invoice
                </a>

                <a href="reports.jsp" class="btn btn-info text-white">
                    <i class="bi bi-bar-chart-line-fill"></i>
                    View Reports
                </a>

            </div>

        </div>

    </div>

</div>

</div>

</div>

<script>

const revenueLabels = [
<%
for(String month : revenueData.keySet()){
%>
"<%= month %>",
<%
}
%>
];

const revenueValues = [
<%
for(Double value : revenueData.values()){
%>
<%= value %>,
<%
}
%>
];

new Chart(document.getElementById("revenueChart"),{

    type:"bar",

    data:{

        labels:revenueLabels,

        datasets:[{

            label:"Revenue (Rs.)",

            data:revenueValues,

            backgroundColor:"#FFEACF",

            borderColor:"#",

            borderWidth:1

        }]

    },

    options:{

        responsive:true,

        plugins:{

            legend:{
                display:true
            }

        }

    }

});
const statusLabels = [
<%
for(String s : statusData.keySet()){
%>
"<%= s %>",
<%
}
%>
];

const statusValues = [
<%
for(Integer c : statusData.values()){
%>
<%= c %>,
<%
}
%>
];

new Chart(document.getElementById("statusChart"),{

    type:"pie",

    data:{

        labels:statusLabels,

        datasets:[{

            data:statusValues,

            backgroundColor:[
                "#198754",
                "#ffc107",
                "#dc3545",
                "#0d6efd"
            ]

        }]

    }

});

</script>

</body>

</html>