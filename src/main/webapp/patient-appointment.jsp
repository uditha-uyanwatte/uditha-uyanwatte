<%@ page import="java.util.List" %>
<%@ page import="dao.DentistDAO" %>
<%@ page import="model.Dentist" %>
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
    // GET DENTISTS
    // =========================

    DentistDAO dentistDAO =
            new DentistDAO();

    List<Dentist> dentists =
            dentistDAO.getAllDentists();


    String error =
            request.getParameter("error");

    String appointment =
            request.getParameter("appointment");
%>


<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">


    <title>Book Appointment | Sunrise Dental Clinic</title>


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


<div class="patient-booking-page">


    <!-- =========================
         TOP BAR
    ========================= -->

    <div class="booking-topbar">

        <div class="container">

            <div class="d-flex
                        justify-content-between
                        align-items-center">


                <a href="user-dashboard.jsp"
                   class="booking-logo">

                    <i class="bi bi-heart-pulse-fill"></i>

                    Sunrise Dental

                </a>


                <a href="user-dashboard.jsp"
                   class="back-dashboard">

                    <i class="bi bi-arrow-left"></i>

                    Dashboard

                </a>

            </div>

        </div>

    </div>


    <!-- =========================
         CONTENT
    ========================= -->

    <div class="container">


        <div class="booking-wrapper">


            <div class="booking-heading">

                <span>
                    SUNRISE DENTAL CLINIC
                </span>

                <h1>
                    Book an Appointment
                </h1>

                <p>
                    Schedule your dental visit with
                    one of our professional dentists.
                </p>

            </div>


            <div class="booking-card">


                <!-- =========================
                     ALERTS
                ========================= -->

                <% if ("patient".equals(error)) { %>

                    <div class="booking-alert booking-error">

                        <i class="bi bi-exclamation-circle"></i>

                        Your patient profile could not be found.
                        Please contact the clinic.

                    </div>

                <% } %>


                <% if ("failed".equals(error)) { %>

                    <div class="booking-alert booking-error">

                        <i class="bi bi-x-circle"></i>

                        Unable to book the appointment.
                        Please try again.

                    </div>

                <% } %>


                <% if ("success".equals(appointment)) { %>

                    <div class="booking-alert booking-success">

                        <i class="bi bi-check-circle-fill"></i>

                        Appointment booked successfully!

                    </div>

                <% } %>


                <!-- =========================
                     PATIENT INFO
                ========================= -->

                <div class="patient-info">

                    <div class="patient-info-icon">

                        <i class="bi bi-person-fill"></i>

                    </div>


                    <div>

                        <strong>

                            <%= loggedUser.getFullName() %>

                        </strong>

                        <small>

                            Patient account

                        </small>

                    </div>

                </div>


                <!-- =========================
                     FORM
                ========================= -->

                <form
                    action="AddAppointmentServlet"
                    method="post">


                    <!-- Action -->

 
    <input type="hidden"
           name="patientId"
           value="<%= loggedUser.getId() %>">

    <input
        type="hidden"
        name="action"
        value="patientAdd">

                    <div class="row">


                        <!-- Dentist -->

                        <div class="col-md-6">

                            <div class="booking-field">

                                <label>

                                    <i class="bi bi-person-badge"></i>

                                    Select Dentist

                                </label>


                                <select
                                    name="dentistId"
                                    required>

                                    <option value="">
                                        Select Dentist
                                    </option>


                                    <%
                                    for (Dentist d : dentists) {
                                    %>

                                        <option
                                            value="<%= d.getDentistId() %>">

                                            Dr.
                                            <%= d.getFirstName() %>
                                            <%= d.getLastName() %>

                                        </option>

                                    <%
                                    }
                                    %>

                                </select>

                            </div>

                        </div>


                        <!-- Date -->

                        <div class="col-md-6">

                            <div class="booking-field">

                                <label>

                                    <i class="bi bi-calendar-event"></i>

                                    Appointment Date

                                </label>


                                <input
                                    type="date"
                                    name="appointmentDate"
                                    min="<%= java.time.LocalDate.now() %>"
                                    required>

                            </div>

                        </div>


                        <!-- Time -->

                        <div class="col-md-6">

                            <div class="booking-field">

                                <label>

                                    <i class="bi bi-clock"></i>

                                    Appointment Time

                                </label>


                                <input
                                    type="time"
                                    name="appointmentTime"
                                    required>

                            </div>

                        </div>


                        <!-- Treatment -->

                        <div class="col-md-6">

                            <div class="booking-field">

                                <label>

                                    <i class="bi bi-heart-pulse"></i>

                                    Treatment

                                </label>


                                <select
                                    name="treatment"
                                    required>

                                    <option value="">
                                        Select Treatment
                                    </option>

                                    <option value="General Checkup">
                                        General Checkup
                                    </option>

                                    <option value="Dental Cleaning">
                                        Dental Cleaning
                                    </option>

                                    <option value="Teeth Whitening">
                                        Teeth Whitening
                                    </option>

                                    <option value="Dental Filling">
                                        Dental Filling
                                    </option>

                                    <option value="Root Canal Treatment">
                                        Root Canal Treatment
                                    </option>

                                    <option value="Tooth Extraction">
                                        Tooth Extraction
                                    </option>

                                    <option value="Orthodontic Consultation">
                                        Orthodontic Consultation
                                    </option>

                                </select>

                            </div>

                        </div>


                        <!-- Notes -->

                        <div class="col-12">

                            <div class="booking-field">

                                <label>

                                    <i class="bi bi-chat-left-text"></i>

                                    Notes

                                </label>


                                <textarea
                                    name="notes"
                                    placeholder="Tell us anything we should know before your appointment..."
                                ></textarea>



                            </div>

                        </div>


                    </div>


                    <!-- Submit -->

                    <button
                        type="submit"
                        class="booking-submit">

                        <i class="bi bi-calendar-check"></i>

                        Book Appointment

                    </button>


                </form>


            </div>

        </div>

    </div>

</div>


</body>

</html>