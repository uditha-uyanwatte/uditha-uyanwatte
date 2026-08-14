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
%>


<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>My Profile | Sunrise Dental Clinic</title>


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


    <style>


    </style>

</head>


<body>


<div class="profile-page">


    <!-- =========================
         TOP BAR
    ========================= -->

    <div class="profile-topbar">

        <div class="container">

            <div class="d-flex
                        justify-content-between
                        align-items-center">


                <a href="user-dashboard.jsp"
                   class="profile-logo">

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
         CONTENT
    ========================= -->

    <div class="container">


        <div class="profile-wrapper">


            <!-- HEADER -->

            <div class="profile-heading">

                <span>
                    PATIENT PORTAL
                </span>

                <h1>
                    My Profile
                </h1>

                <p>
                    View your Sunrise Dental Clinic
                    account information.
                </p>

            </div>


            <!-- PROFILE CARD -->

            <div class="profile-card">


                <!-- PROFILE HEADER -->

                <div class="profile-header">


                    <div class="profile-avatar">

                        <i class="bi bi-person-fill"></i>

                    </div>


                    <div>

                        <h2>

                            <%= loggedUser.getFullName() %>

                        </h2>


                        <p>

                            @<%= loggedUser.getUsername() %>

                        </p>


                        <span class="patient-badge">

                            <i class="bi bi-person-check"></i>

                            PATIENT

                        </span>

                    </div>

                </div>


                <!-- =========================
                     DETAILS
                ========================= -->

                <div class="profile-details">


                    <!-- Patient/User ID -->

                    <div class="profile-detail">

                        <div class="profile-detail-icon">

                            <i class="bi bi-person-vcard"></i>

                        </div>

                        <small>
                            User ID
                        </small>

                        <strong>
                            #<%= loggedUser.getId() %>
                        </strong>

                    </div>


                    <!-- Full Name -->

                    <div class="profile-detail">

                        <div class="profile-detail-icon">

                            <i class="bi bi-person"></i>

                        </div>

                        <small>
                            Full Name
                        </small>

                        <strong>
                            <%= loggedUser.getFullName() %>
                        </strong>

                    </div>


                    <!-- Username -->

                    <div class="profile-detail">

                        <div class="profile-detail-icon">

                            <i class="bi bi-at"></i>

                        </div>

                        <small>
                            Username
                        </small>

                        <strong>
                            <%= loggedUser.getUsername() %>
                        </strong>

                    </div>


                    <!-- Email -->

                    <div class="profile-detail">

                        <div class="profile-detail-icon">

                            <i class="bi bi-envelope"></i>

                        </div>

                        <small>
                            Email Address
                        </small>

                        <strong>

                            <%= loggedUser.getEmail() != null
                                ? loggedUser.getEmail()
                                : "Not provided" %>

                        </strong>

                    </div>


                    <!-- Phone -->

                    <div class="profile-detail">

                        <div class="profile-detail-icon">

                            <i class="bi bi-telephone"></i>

                        </div>

                        <small>
                            Phone Number
                        </small>

                        <strong>

                            <%= loggedUser.getPhone() != null
                                ? loggedUser.getPhone()
                                : "Not provided" %>

                        </strong>

                    </div>


                    <!-- Account Role -->

                    <div class="profile-detail">

                        <div class="profile-detail-icon">

                            <i class="bi bi-shield-check"></i>

                        </div>

                        <small>
                            Account Role
                        </small>

                        <strong>
                            <%= loggedUser.getRole() %>
                        </strong>

                    </div>


                </div>


                <!-- =========================
                     ACTIONS
                ========================= -->

                <div class="profile-actions">


                    <a href="user-dashboard.jsp"
                       class="profile-btn profile-btn-primary">

                        <i class="bi bi-speedometer2"></i>

                        Dashboard

                    </a>


                    <a href="my-appointments.jsp"
                       class="profile-btn profile-btn-outline">

                        <i class="bi bi-calendar-check"></i>

                        My Appointments

                    </a>


                </div>


            </div>


        </div>

    </div>

</div>


</body>

</html>