<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.SettingsDAO" %>
<%@ page import="model.Settings" %>

<%
if(session.getAttribute("user")==null){
    response.sendRedirect("login.jsp");
    return;
}

SettingsDAO dao = new SettingsDAO();
Settings settings = dao.getSettings();
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Settings | Sunrise Dental Clinic</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

<link rel="stylesheet" href="assets/css/style.css">

</head>

<body>

<jsp:include page="includes/sidebar.jsp"/>
<jsp:include page="includes/navbar.jsp"/>
<div class="main-content">



<div class="container-fluid p-4">

<div class="page-header mb-4">

    <div>

        <h2>

            <i class="bi bi-gear-fill"></i>

            Settings

        </h2>

        <p>

            Manage clinic information and system preferences.

        </p>

    </div>

</div>

<% if(request.getParameter("success") != null){ %>

<div class="alert alert-success">

    <i class="bi bi-check-circle-fill"></i>

    Settings Updated Successfully.

</div>

<% } %>

<% if(request.getParameter("error") != null){ %>

<div class="alert alert-danger">

    <i class="bi bi-x-circle-fill"></i>

    Failed To Update Settings.

</div>

<% } %>

<form action="UpdateSettingsServlet" method="post">

<input type="hidden"
       name="id"
       value="<%=settings.getId()%>">

<!-- =========================
     CLINIC INFORMATION
========================= -->

<div class="table-card mb-4">

<h4 class="mb-4">

<i class="bi bi-hospital text-info"></i>

Clinic Information

</h4>

<div class="row">

<div class="col-md-6 mb-3">

<label class="form-label">

Clinic Name

</label>

<input
type="text"
name="clinicName"
class="form-control"
value="<%=settings.getClinicName()%>">

</div>

<div class="col-md-6 mb-3">

<label class="form-label">

Tagline

</label>

<input
type="text"
name="clinicTagline"
class="form-control"
value="<%=settings.getClinicTagline()%>">

</div>

<div class="col-md-6 mb-3">

<label class="form-label">

Phone Number

</label>

<input
type="text"
name="phone"
class="form-control"
value="<%=settings.getPhone()%>">

</div>

<div class="col-md-6 mb-3">

<label class="form-label">

Email

</label>

<input
type="email"
name="email"
class="form-control"
value="<%=settings.getEmail()%>">

</div>

<div class="col-md-6 mb-3">

<label class="form-label">

Website

</label>

<input
type="text"
name="website"
class="form-control"
value="<%=settings.getWebsite()%>">

</div>

<div class="col-md-6 mb-3">

<label class="form-label">

Working Hours

</label>

<input
type="text"
name="workingHours"
class="form-control"
value="<%=settings.getWorkingHours()%>">

</div>

<div class="col-12 mb-4">

<label class="form-label">

Address

</label>

<textarea
name="address"
class="form-control"
rows="4"><%=settings.getAddress()%></textarea>

</div>

</div>

</div>
<!-- =========================
     ADMIN PROFILE
========================= -->

<div class="table-card mb-4">

    <h4 class="mb-4">

        <i class="bi bi-person-circle text-info"></i>

        Administrator Profile

    </h4>

    <div class="row">

        <div class="col-md-6 mb-3">

            <label class="form-label">

                Full Name

            </label>

            <input
                    type="text"
                    name="adminName"
                    class="form-control"
                    value="<%=settings.getAdminName()%>">

        </div>

        <div class="col-md-6 mb-3">

            <label class="form-label">

                Username

            </label>

            <input
                    type="text"
                    name="username"
                    class="form-control"
                    value="<%=settings.getUsername()%>">

        </div>

        <div class="col-md-12 mb-3">

            <label class="form-label">

                Email Address

            </label>

            <input
                    type="email"
                    name="adminEmail"
                    class="form-control"
                    value="<%=settings.getAdminEmail()%>">

        </div>

    </div>

</div>

<!-- =========================
     APPEARANCE
========================= -->

<div class="table-card mb-4">

    <h4 class="mb-4">

        <i class="bi bi-palette-fill text-info"></i>

        Appearance

    </h4>

    <div class="row">

        <div class="col-md-6 mb-3">

            <label class="form-label">

                Theme

            </label>

            <select
                    name="theme"
                    class="form-select">

                <option value="light"
                <%= "light".equals(settings.getTheme()) ? "selected" : "" %>>

                    ☀ Light Mode

                </option>

                <option value="dark"
                <%= "dark".equals(settings.getTheme()) ? "selected" : "" %>>

                    🌙 Dark Mode

                </option>

            </select>

        </div>

        <div class="col-md-6 mb-3">

            <label class="form-label">

                Accent Color

            </label>

            <select
                    name="accentColor"
                    class="form-select">

                <option value="cyan"
                <%= "cyan".equals(settings.getAccentColor()) ? "selected" : "" %>>

                    Cyan

                </option>

                <option value="green"
                <%= "green".equals(settings.getAccentColor()) ? "selected" : "" %>>

                    Green

                </option>

                <option value="blue"
                <%= "blue".equals(settings.getAccentColor()) ? "selected" : "" %>>

                    Blue

                </option>

                <option value="purple"
                <%= "purple".equals(settings.getAccentColor()) ? "selected" : "" %>>

                    Purple

                </option>

            </select>

        </div>

    </div>

</div>

<!-- =========================
     SYSTEM SETTINGS
========================= -->

<div class="table-card mb-4">

    <h4 class="mb-4">

        <i class="bi bi-sliders text-info"></i>

        System Settings

    </h4>

    <div class="row">

        <div class="col-md-6 mb-3">

            <label class="form-label">

                Language

            </label>

            <select
                    name="language"
                    class="form-select">

                <option value="English"
                <%= "English".equals(settings.getLanguage()) ? "selected" : "" %>>

                    English

                </option>

                <option value="Sinhala"
                <%= "Sinhala".equals(settings.getLanguage()) ? "selected" : "" %>>

                    Sinhala

                </option>

                <option value="Tamil"
                <%= "Tamil".equals(settings.getLanguage()) ? "selected" : "" %>>

                    Tamil

                </option>

            </select>

        </div>

        <div class="col-md-6 mb-3">

            <label class="form-label">

                Currency

            </label>

            <select
                    name="currency"
                    class="form-select">

                <option value="LKR"
                <%= "LKR".equals(settings.getCurrency()) ? "selected" : "" %>>

                    LKR

                </option>

                <option value="USD"
                <%= "USD".equals(settings.getCurrency()) ? "selected" : "" %>>

                    USD

                </option>

            </select>

        </div>

        <div class="col-12">

            <div class="form-check form-switch fs-5">

                <input
                        class="form-check-input"
                        type="checkbox"
                        name="notifications"
                        <%= settings.isNotifications() ? "checked" : "" %>>

                <label class="form-check-label">

                    Enable Email & System Notifications

                </label>

            </div>

        </div>

    </div>

</div>
<!-- =========================
     SECURITY
========================= -->

<div class="table-card mb-4">

    <h4 class="mb-4">

        <i class="bi bi-shield-lock-fill text-info"></i>

        Change Password

    </h4>

    <div class="row">

        <div class="col-md-4 mb-3">

            <label class="form-label">

                Current Password

            </label>

            <input
                    type="password"
                    name="currentPassword"
                    class="form-control"
                    placeholder="Current Password">

        </div>

        <div class="col-md-4 mb-3">

            <label class="form-label">

                New Password

            </label>

            <input
                    type="password"
                    name="newPassword"
                    class="form-control"
                    placeholder="New Password">

        </div>

        <div class="col-md-4 mb-3">

            <label class="form-label">

                Confirm Password

            </label>

            <input
                    type="password"
                    name="confirmPassword"
                    class="form-control"
                    placeholder="Confirm Password">

        </div>

    </div>

</div>

<!-- =========================
     LOGO & PROFILE
========================= -->

<div class="table-card mb-4">

    <h4 class="mb-4">

        <i class="bi bi-image-fill text-info"></i>

        Images

    </h4>

    <div class="row">

        <div class="col-md-6 mb-3">

            <label class="form-label">

                Clinic Logo

            </label>

            <input
                    type="file"
                    class="form-control"
                    name="clinicLogo">

        </div>

        <div class="col-md-6 mb-3">

            <label class="form-label">

                Profile Image

            </label>

            <input
                    type="file"
                    class="form-control"
                    name="profileImage">

        </div>

    </div>

</div>

<!-- =========================
     ABOUT SYSTEM
========================= -->

<div class="table-card mb-4">

    <h4 class="mb-4">

        <i class="bi bi-info-circle-fill text-info"></i>

        About System

    </h4>

    <div class="row">

        <div class="col-md-6">

            <h5>Sunrise Dental Clinic</h5>

            <p class="mb-1">

                Version : <strong>1.0</strong>

            </p>

            <p class="mb-1">

                Java JSP • Servlet • MySQL

            </p>

            <p>

                Developed for Clinic Management.

            </p>

        </div>

        <div class="col-md-6 text-end">

            <i class="bi bi-hospital display-1 text-info"></i>

        </div>

    </div>

</div>

<!-- =========================
     SAVE BUTTON
========================= -->

<div class="text-end mb-5">

    <button
            type="submit"
            class="save-btn">

        <i class="bi bi-check2-circle"></i>

        Save All Settings

    </button>

</div>

</form>

</div>

</div>

</body>

</html>