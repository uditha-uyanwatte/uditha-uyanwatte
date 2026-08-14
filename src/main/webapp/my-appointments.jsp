<%@ page import="java.util.List" %>
<%@ page import="dao.PatientDashboardDAO" %>
<%@ page import="model.Appointment" %>
<%@ page import="model.User" %>

<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%
    // =========================
    // LOGIN CHECK
    // =========================

    if (session.getAttribute("user") == null) {

        response.sendRedirect("login.jsp");
        return;
    }

    User loggedUser =
            (User) session.getAttribute("user");


    // =========================
    // ROLE CHECK
    // =========================

    if (!"PATIENT".equalsIgnoreCase(
            loggedUser.getRole())) {

        response.sendRedirect("dashboard.jsp");
        return;
    }


    // =========================
    // GET PATIENT ID
    // =========================

    PatientDashboardDAO patientDAO =
            new PatientDashboardDAO();

    int userId =
            loggedUser.getId();

    int patientId =
            patientDAO.getPatientIdByUserId(userId);


    // =========================
    // GET APPOINTMENTS
    // =========================

    List<Appointment> appointments =
            patientDAO.getPatientAppointments(patientId);
%>


<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>My Appointments | Sunrise Dental Clinic</title>


    <!-- Bootstrap -->

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">


    <!-- Bootstrap Icons -->

    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">


    <!-- Main CSS -->

    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/assets/css/style.css">


   
</head>


<body>


<div class="my-appointments-page">


    <!-- =========================
         TOP BAR
    ========================= -->

    <div class="appointments-topbar">

        <div class="container">

            <div class="d-flex
                        justify-content-between
                        align-items-center">

                <a href="user-dashboard.jsp"
                   class="appointments-logo">

                    <i class="bi bi-heart-pulse-fill"></i>

                    Sunrise Dental

                </a>


                <a href="user-dashboard.jsp"
                   class="dashboard-link">

                    <i class="bi bi-arrow-left"></i>

                    Dashboard

                </a>

            </div>

        </div>

    </div>


    <!-- =========================
         MAIN CONTENT
    ========================= -->

    <div class="container">

        <div class="appointments-wrapper">


            <!-- HEADER -->

            <div class="appointments-heading">

                <span>
                    PATIENT PORTAL
                </span>

                <h1>
                    My Appointments
                </h1>

                <p>
                    View and manage your dental appointments.
                </p>

            </div>


            <!-- =========================
                 APPOINTMENTS
            ========================= -->

            <%
            if (appointments != null &&
                !appointments.isEmpty()) {
            %>


                <%
                for (Appointment a : appointments) {
                %>


                    <div class="my-appointment-card">


                        <!-- MAIN -->

                        <div class="appointment-main">

                            <div class="appointment-icon-box">

                                <i class="bi bi-calendar-check"></i>

                            </div>


                            <div>

                                <h4>

                                    <%= a.getTreatment() %>

                                </h4>


                                <p>

                                    <i class="bi bi-person-badge"></i>

                                    Dr.
                                    <%= a.getDentistName() %>

                                </p>

                            </div>

                        </div>


                        <!-- DETAILS -->

                        <div class="appointment-details">


                            <div class="appointment-detail">

                                <small>
                                    <i class="bi bi-calendar-event"></i>
                                    Date
                                </small>

                                <strong>
                                    <%= a.getAppointmentDate() %>
                                </strong>

                            </div>


                            <div class="appointment-detail">

                                <small>
                                    <i class="bi bi-clock"></i>
                                    Time
                                </small>

                                <strong>
                                    <%= a.getAppointmentTime() %>
                                </strong>

                            </div>


                            <div class="appointment-detail">

                                <small>
                                    <i class="bi bi-hash"></i>
                                    Appointment ID
                                </small>

                                <strong>
                                    #<%= a.getAppointmentId() %>
                                </strong>

                            </div>


                            <div class="appointment-detail">

                                <small>
                                    <i class="bi bi-info-circle"></i>
                                    Status
                                </small>


                                <%
                                String status =
                                    a.getStatus();

                                if ("Pending".equalsIgnoreCase(status)) {
                                %>

                                    <span class="appointment-status status-pending">
                                        Pending
                                    </span>

                                <%
                                } else if ("Confirmed".equalsIgnoreCase(status)) {
                                %>

                                    <span class="appointment-status status-confirmed">
                                        Confirmed
                                    </span>

                                <%
                                } else if ("Completed".equalsIgnoreCase(status)) {
                                %>

                                    <span class="appointment-status status-completed">
                                        Completed
                                    </span>

                                <%
                                } else {
                                %>

                                    <span class="appointment-status status-cancelled">
                                        Cancelled
                                    </span>

                                <%
                                }
                                %>
                                
                                
                                <%
if ("Pending".equalsIgnoreCase(a.getStatus())
        || "Confirmed".equalsIgnoreCase(a.getStatus())) {
%>

    <div class="mt-3">

        <a href="AppointmentServlet?action=patientCancel&id=<%=a.getAppointmentId()%>"
           class="btn btn-outline-danger btn-sm"
           onclick="return confirm('Are you sure you want to cancel this appointment?');">

            <i class="bi bi-x-circle"></i>

            Cancel Appointment

        </a>

    </div>

<%
}
%>

                            </div>


                        </div>
                        
                        


                        <!-- NOTES -->

                        <%
                        if (a.getNotes() != null &&
                            !a.getNotes().trim().isEmpty()) {
                        %>

                            <div class="appointment-notes">

                                <strong>
                                    <i class="bi bi-chat-left-text"></i>
                                    Notes:
                                </strong>

                                <%= a.getNotes() %>

                            </div>

                        <%
                        }
                        %>


                    </div>


                <%
                }
                %>


            <%
            } else {
            %>


                <!-- EMPTY -->

                <div class="empty-appointments">

                    <div class="empty-icon">

                        <i class="bi bi-calendar-x"></i>

                    </div>


                    <h3>
                        No Appointments Yet
                    </h3>


                    <p>
                        You don't have any appointments
                        scheduled at the moment.
                    </p>


                    <a href="patient-appointment.jsp"
                       class="book-new-btn">

                        <i class="bi bi-calendar-plus"></i>

                        Book an Appointment

                    </a>

                </div>


            <%
            }
            %>


        </div>

    </div>

</div>


</body>

</html>