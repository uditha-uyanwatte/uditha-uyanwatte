<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="sidebar">

    <!-- Logo -->

    <div class="logo">

        <div class="logo-circle">

            <i class="bi bi-heart-pulse-fill"></i>
            

        </div>

        <h3>SUNRISE</h3>

        <span>Dental Clinic</span>

    </div>

    <hr class="sidebar-divider">

    <ul class="nav flex-column mt-4">

        <li class="nav-item">
            <a href="dashboard.jsp" class="nav-link active">
                <i class="bi bi-grid-1x2-fill"></i>
                <span>Dashboard</span>
            </a>
        </li>

        <li class="nav-item">
            <a href="patients.jsp" class="nav-link">
                <i class="bi bi-people-fill"></i>
                <span>Patients</span>
            </a>
        </li>

        <li class="nav-item">
            <a href="dentists.jsp" class="nav-link">
                <i class="bi bi-person-vcard-fill"></i>
                <span>Dentists</span>
            </a>
            
            
            
        </li>
        <li class="nav-item">

    <a href="UserManagementServlet" class="nav-link">

        <i class="bi bi-person-gear"></i>

        <span>User Management</span>

    </a>

</li>

        <li class="nav-item">
            <a href="appointments.jsp" class="nav-link">
                <i class="bi bi-calendar2-check-fill"></i>
                <span>Appointments</span>
            </a>
        </li>
        
        <li class="nav-item">

    <a href="services.jsp" class="nav-link">

        <i class="bi bi-heart-pulse-fill"></i>

        <span>Services</span>

    </a>

</li>

        <li class="nav-item">
            <a href="billing.jsp" class="nav-link">
                <i class="bi bi-credit-card-2-front-fill"></i>
                <span>Billing</span>
            </a>
        </li>

        <li class="nav-item">
            <a href="ReportsServlet" class="nav-link">
                <i class="bi bi-bar-chart-line-fill"></i>
                <span>Reports</span>
            </a>
        </li>

        <li class="nav-item">
            <a href="settings.jsp" class="nav-link">
                <i class="bi bi-sliders"></i>
                <span>Settings</span>
            </a>
        </li>

    </ul>

    <div class="sidebar-footer">

        <a href="LogoutServlet" class="logout-btn">

            <i class="bi bi-box-arrow-right"></i>

            Logout

        </a>

    </div>

</div>