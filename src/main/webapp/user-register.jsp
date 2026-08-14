<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Register | Sunrise Dental Clinic</title>

    <!-- Bootstrap -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <!-- Main CSS -->
    <link rel="stylesheet"
          href="assets/css/style.css">

</head>

<body>


<!-- =========================
        REGISTER PAGE
========================= -->

<div class="register-page">

    <!-- Background Overlay -->

    <div class="register-overlay"></div>


    <!-- Register Card -->

    <div class="register-card">

        <!-- Logo -->

        <div class="register-logo">

            <div class="logo-icon">

                <i class="bi bi-heart-pulse"></i>

            </div>

        </div>

<%
    String error = request.getParameter("error");
    String registered = request.getParameter("registered");
%>

<% if ("empty".equals(error)) { %>

    <div class="register-alert error">
        <i class="bi bi-exclamation-circle"></i>
        Please fill in all required fields.
    </div>

<% } else if ("password".equals(error)) { %>

    <div class="register-alert error">
        <i class="bi bi-lock"></i>
        Passwords do not match.
    </div>

<% } else if ("exists".equals(error)) { %>

    <div class="register-alert error">
        <i class="bi bi-person-x"></i>
        Username or email already exists.
    </div>

<% } else if ("database".equals(error)) { %>

    <div class="register-alert error">
        <i class="bi bi-database-x"></i>
        Unable to connect to the database.
    </div>

<% } else if ("failed".equals(error)) { %>

    <div class="register-alert error">
        <i class="bi bi-x-circle"></i>
        Registration failed. Please try again.
    </div>

<% } %>
        <!-- Heading -->

        <h1>
            Create Account
        </h1>

        <h3>
            Sunrise Dental Clinic
        </h3>

        <p class="register-subtitle">

            Register to book appointments and
            manage your dental care.

        </p>


        <!-- =========================
                REGISTER FORM
        ========================= -->

       <form action="RegisterServlet" method="post">


            <!-- Full Name -->

            <div class="register-field">

                <label>
                    Full Name
                </label>

                <div class="input-wrapper">

                    <i class="bi bi-person"></i>

                    <input
                        type="text"
                        name="fullName"
                        placeholder="Enter your full name"
                        autocomplete="name"
                        required>

                </div>

            </div>


            <!-- Email -->

            <div class="register-field">

                <label>
                    Email Address
                </label>

                <div class="input-wrapper">

                    <i class="bi bi-envelope"></i>

                    <input
                        type="email"
                        name="email"
                        placeholder="Enter your email"
                        autocomplete="email"
                        required>

                </div>

            </div>


            <!-- Phone -->

            <div class="register-field">

                <label>
                    Phone Number
                </label>

                <div class="input-wrapper">

                    <i class="bi bi-telephone"></i>

                    <input
                        type="tel"
                        name="phone"
                        placeholder="Enter your phone number"
                        autocomplete="tel"
                        required>

                </div>

            </div>


            <!-- Username -->

            <div class="register-field">

                <label>
                    Username
                </label>

                <div class="input-wrapper">

                    <i class="bi bi-person-badge"></i>

                    <input
                        type="text"
                        name="username"
                        placeholder="Create a username"
                        autocomplete="username"
                        required>

                </div>

            </div>


            <!-- Password -->

            <div class="register-field">

                <label>
                    Password
                </label>

                <div class="input-wrapper">

                    <i class="bi bi-lock"></i>

                    <input
                        type="password"
                        id="password"
                        name="password"
                        placeholder="Create a password"
                        autocomplete="new-password"
                        required>

                    <button
                        type="button"
                        class="password-toggle"
                        onclick="togglePassword('password', this)"
                        aria-label="Show password">

                        <i class="bi bi-eye"></i>

                    </button>

                </div>

            </div>


            <!-- Confirm Password -->

            <div class="register-field">

                <label>
                    Confirm Password
                </label>

                <div class="input-wrapper">

                    <i class="bi bi-shield-lock"></i>

                    <input
                        type="password"
                        id="confirmPassword"
                        name="confirmPassword"
                        placeholder="Confirm your password"
                        autocomplete="new-password"
                        required>

                    <button
                        type="button"
                        class="password-toggle"
                        onclick="togglePassword('confirmPassword', this)"
                        aria-label="Show password">

                        <i class="bi bi-eye"></i>

                    </button>

                </div>

            </div>


            <!-- Register Button -->

            <button
                type="submit"
                class="register-btn">

                <i class="bi bi-person-plus"></i>

                Create Account

            </button>


        </form>


        <!-- =========================
                LOGIN LINK
        ========================= -->

        <div class="login-prompt">

            <span>
                Already have an account?
            </span>

            <a href="login.jsp">
                Login
            </a>

        </div>


    </div>

</div>


<!-- =========================
        PASSWORD SCRIPT
========================= -->

<script>

function togglePassword(inputId, button) {

    const input =
        document.getElementById(inputId);

    const icon =
        button.querySelector("i");


    if (input.type === "password") {

        input.type = "text";

        icon.classList.remove("bi-eye");

        icon.classList.add("bi-eye-slash");

    } else {

        input.type = "password";

        icon.classList.remove("bi-eye-slash");

        icon.classList.add("bi-eye");

    }

}

</script>


</body>

</html>