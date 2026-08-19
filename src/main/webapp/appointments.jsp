<%@page import="java.util.List"%>

<%@page import="dao.PatientDAO"%>
<%@page import="dao.DentistDAO"%>
<%@page import="dao.AppointmentDAO"%>

<%@page import="model.Patient"%>
<%@page import="model.Dentist"%>
<%@page import="model.Appointment"%>

<%@page language="java"
        contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>

<%
    // =========================
    // LOGIN CHECK
    // =========================

    if (session.getAttribute("username") == null) {

        response.sendRedirect("login.jsp");
        return;
    }


    // =========================
    // LOAD DATA
    // =========================

    PatientDAO patientDAO = new PatientDAO();

    DentistDAO dentistDAO = new DentistDAO();

    AppointmentDAO appointmentDAO =
            new AppointmentDAO();


    List<Patient> patients =
            patientDAO.getAllPatients();

    List<Dentist> dentists =
            dentistDAO.getAllDentists();


    // =========================
    // SEARCH + STATUS FILTER
    // =========================

    String keyword =
            request.getParameter("search");

    String statusFilter =
            request.getParameter("status");


    List<Appointment> appointments;


    if (
        (keyword != null &&
         !keyword.trim().isEmpty())

        ||

        (statusFilter != null &&
         !statusFilter.trim().isEmpty() &&
         !"All".equalsIgnoreCase(statusFilter))
    ) {

        appointments =
                appointmentDAO.searchAppointments(
                        keyword,
                        statusFilter
                );

    } else {

        appointments =
                appointmentDAO.getAllAppointments();
    }

%>


<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>
        Appointment Management
    </title>


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
        href="assets/css/style.css">

</head>


<body class="<%= session.getAttribute("theme") != null
        ? session.getAttribute("theme")
        : "light" %>">


<!-- =========================
     SIDEBAR
========================= -->

<jsp:include page="includes/sidebar.jsp"/>


<!-- =========================
     NAVBAR
========================= -->

<jsp:include page="includes/navbar.jsp"/>


<!-- =========================
     MAIN CONTENT
========================= -->

<div class="main-content">

    <div class="container-fluid p-4">


        <!-- =========================
             PAGE HEADER
        ========================= -->

        <div class="page-header mb-4">

            <div>

                <h2>

                    <i class="bi bi-calendar2-check-fill"></i>

                    Appointments

                </h2>

                <p>

                    Manage appointments, schedules and treatments.

                </p>

            </div>

        </div>


        <!-- =========================
             SUCCESS MESSAGES
        ========================= -->


        <%
            if (request.getParameter("success") != null) {
        %>

            <div class="alert alert-success">

                Appointment Added Successfully.

            </div>

        <%
            }
        %>


        <%
            if (request.getParameter("updated") != null) {
        %>

            <div class="alert alert-warning">

                Appointment Updated Successfully.

            </div>

        <%
            }
        %>


        <%
            if (request.getParameter("deleted") != null) {
        %>

            <div class="alert alert-danger">

                Appointment Deleted Successfully.

            </div>

        <%
            }
        %>


        <!-- =========================
             ADD NEW APPOINTMENT
        ========================= -->

        <div class="table-card mb-4">

            <h4 class="mb-4">

                <i class="bi bi-calendar-plus-fill text-info"></i>

                Add New Appointment

            </h4>


            <form
                action="AddAppointmentServlet"
                method="post">


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


                            <%

                                for (Patient p : patients) {

                            %>

                                <option
                                    value="<%=p.getPatientId()%>">

                                    <%=p.getFirstName()%>
                                    <%=p.getLastName()%>

                                </option>

                            <%

                                }

                            %>

                        </select>

                    </div>


                    <!-- DENTIST -->

                    <div class="col-md-6 mb-3">

                        <label class="form-label">

                            Dentist

                        </label>


                        <select
                            name="dentistId"
                            class="form-select"
                            required>

                            <option value="">

                                Select Dentist

                            </option>


                            <%

                                for (Dentist d : dentists) {

                            %>

                                <option
                                    value="<%=d.getDentistId()%>">

                                    Dr.
                                    <%=d.getFirstName()%>
                                    <%=d.getLastName()%>

                                </option>

                            <%

                                }

                            %>

                        </select>

                    </div>


                    <!-- DATE -->

                    <div class="col-md-6 mb-3">

                        <label class="form-label">

                            Appointment Date

                        </label>


                        <input
                            type="date"
                            name="appointmentDate"
                            class="form-control"
                            required>

                    </div>


                    <!-- TIME -->

                    <div class="col-md-6 mb-3">

                        <label class="form-label">

                            Appointment Time

                        </label>


                        <input
                            type="time"
                            name="appointmentTime"
                            class="form-control"
                            required>

                    </div>


                    <!-- STATUS -->

                    <div class="col-md-6 mb-3">

                        <label class="form-label">

                            Status

                        </label>


                        <select
                            name="status"
                            class="form-select">

                            <option value="Pending">

                                Pending

                            </option>

                            <option value="Confirmed">

                                Confirmed

                            </option>

                            <option value="Completed">

                                Completed

                            </option>

                            <option value="Cancelled">

                                Cancelled

                            </option>

                        </select>

                    </div>


                    <!-- TREATMENT -->

                    <div class="col-md-6 mb-3">

                        <label class="form-label">

                            Treatment

                        </label>


                        <input
                            type="text"
                            name="treatment"
                            class="form-control"
                            placeholder="Treatment Type"
                            required>

                    </div>


                    <!-- NOTES -->

                    <div class="col-12 mb-3">

                        <label class="form-label">

                            Notes

                        </label>


                        <textarea
                            name="notes"
                            class="form-control"
                            rows="4"></textarea>

                    </div>


                    <!-- SAVE -->

                    <div class="col-12">

                        <button
                            type="submit"
                            class="save-btn">

                            <i class="bi bi-check2-circle"></i>

                            Save Appointment

                        </button>

                    </div>


                </div>

            </form>

        </div>


        <!-- =========================
             APPOINTMENT RECORDS
        ========================= -->

        <div class="table-card">


            <!-- HEADER -->

            <div
                class="d-flex justify-content-between align-items-center mb-4">

                <h4>

                    <i
                        class="bi bi-calendar-check-fill text-info">
                    </i>

                    Appointment Records

                </h4>


                <span class="badge bg-info">

                    <%= appointments.size() %>
                    Appointments

                </span>

            </div>


            <!-- =========================
                 SEARCH + FILTER
            ========================= -->

            <form method="get">

                <div
                    class="row g-3 align-items-center">


                    <!-- SEARCH -->

                    <div class="col-lg-7">

                        <div class="input-group">

                            <span
                                class="input-group-text bg-dark border-info text-info">

                                <i class="bi bi-search"></i>

                            </span>


                            <input
                                type="text"
                                name="search"
                                class="form-control search-input"
                                placeholder="Search by Date, Treatment or Status..."
                                value="<%= keyword == null
                                        ? ""
                                        : keyword %>">

                        </div>

                    </div>


                    <!-- STATUS FILTER -->

                    <div class="col-lg-3">

                        <select
                            name="status"
                            class="form-select">


                            <option
                                value="All"
                                <%= statusFilter == null ||
                                    "All".equalsIgnoreCase(statusFilter)
                                    ? "selected"
                                    : "" %>>

                                All Status

                            </option>


                            <option
                                value="Pending"
                                <%= "Pending".equalsIgnoreCase(statusFilter)
                                    ? "selected"
                                    : "" %>>

                                Pending

                            </option>


                            <option
                                value="Confirmed"
                                <%= "Confirmed".equalsIgnoreCase(statusFilter)
                                    ? "selected"
                                    : "" %>>

                                Confirmed

                            </option>


                            <option
                                value="Completed"
                                <%= "Completed".equalsIgnoreCase(statusFilter)
                                    ? "selected"
                                    : "" %>>

                                Completed

                            </option>


                            <option
                                value="Cancelled"
                                <%= "Cancelled".equalsIgnoreCase(statusFilter)
                                    ? "selected"
                                    : "" %>>

                                Cancelled

                            </option>


                        </select>

                    </div>


                    <!-- SEARCH BUTTON -->

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
                    href="appointments.jsp"
                    class="btn btn-outline-light">

                    <i class="bi bi-arrow-clockwise"></i>

                    Reset

                </a>

            </div>


            <hr class="my-4">


            <!-- =========================
                 APPOINTMENT TABLE
            ========================= -->

            <div class="table-responsive">

                <table
                    class="table patient-table align-middle">


                    <thead>

                        <tr>

                            <th>ID</th>

                            <th>Patient</th>

                            <th>Dentist</th>

                            <th>Date</th>

                            <th>Time</th>

                            <th>Status</th>

                            <th>Treatment</th>

                            <th>Notes</th>

                            <th class="text-center">

                                Actions

                            </th>

                        </tr>

                    </thead>


                    <tbody>


                    <%

                        for (Appointment a : appointments) {


                            Patient patient =
                                patientDAO.getPatientById(
                                    a.getPatientId()
                                );


                            Dentist dentist =
                                dentistDAO.getDentistById(
                                    a.getDentistId()
                                );

                    %>


                        <tr>


                            <!-- ID -->

                            <td>

                                <span class="patient-id">

                                    #<%=a.getAppointmentId()%>

                                </span>

                            </td>


                            <!-- PATIENT -->

                            <td>

                                <div
                                    class="d-flex align-items-center">


                                    <div
                                        class="patient-avatar">

                                        <i
                                            class="bi bi-person-fill">
                                        </i>

                                    </div>


                                    <div class="ms-3">

                                        <strong>

                                            <%=patient.getFirstName()%>
                                            <%=patient.getLastName()%>

                                        </strong>

                                    </div>

                                </div>

                            </td>


                            <!-- DENTIST -->

                            <td>

                                <div
                                    class="d-flex align-items-center">


                                    <div
                                        class="patient-avatar">

                                        <i
                                            class="bi bi-person-badge-fill">
                                        </i>

                                    </div>


                                    <div class="ms-3">

                                        <strong>

                                            Dr.
                                            <%=dentist.getFirstName()%>
                                            <%=dentist.getLastName()%>

                                        </strong>

                                    </div>

                                </div>

                            </td>


                            <!-- DATE -->

                            <td>

                                <%=a.getAppointmentDate()%>

                            </td>


                            <!-- TIME -->

                            <td>

                                <%=a.getAppointmentTime()%>

                            </td>


                            <!-- STATUS -->

                            <td>


                                <%

                                    if (
                                        "Completed"
                                        .equalsIgnoreCase(
                                            a.getStatus()
                                        )
                                    ) {

                                %>

                                    <span
                                        class="badge bg-success">

                                        Completed

                                    </span>


                                <%

                                    } else if (
                                        "Confirmed"
                                        .equalsIgnoreCase(
                                            a.getStatus()
                                        )
                                    ) {

                                %>

                                    <span
                                        class="badge bg-primary">

                                        Confirmed

                                    </span>


                                <%

                                    } else if (
                                        "Pending"
                                        .equalsIgnoreCase(
                                            a.getStatus()
                                        )
                                    ) {

                                %>

                                    <span
                                        class="badge bg-warning text-dark">

                                        Pending

                                    </span>


                                <%

                                    } else {

                                %>

                                    <span
                                        class="badge bg-danger">

                                        Cancelled

                                    </span>


                                <%

                                    }

                                %>


                            </td>


                            <!-- TREATMENT -->

                            <td>

                                <%=a.getTreatment()%>

                            </td>


                            <!-- NOTES -->

                            <td>

                                <%=a.getNotes() == null
                                    ? ""
                                    : a.getNotes()%>

                            </td>


                            <!-- ACTIONS -->

                            <td class="text-center">


                                <!-- EDIT -->

                                <a
                                    href="edit-appointment.jsp?id=<%=a.getAppointmentId()%>"
                                    class="btn btn-warning btn-sm rounded-circle me-2"
                                    title="Edit Appointment">

                                    <i
                                        class="bi bi-pencil">
                                    </i>

                                </a>


                                <!-- DELETE -->

                                <a
                                    href="DeleteAppointmentServlet?id=<%=a.getAppointmentId()%>"
                                    class="btn btn-danger btn-sm rounded-circle"
                                    title="Delete Appointment"
                                    onclick="return confirm('Delete this appointment?');">

                                    <i
                                        class="bi bi-trash">
                                    </i>

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


<!-- Bootstrap JS -->

<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>


</body>

</html>