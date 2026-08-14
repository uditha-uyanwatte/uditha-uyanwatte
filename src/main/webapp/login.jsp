<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <title>Sunrise Dental Clinic | Login</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Google Font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <!-- CSS -->
    <link rel="stylesheet" href="assets/css/style.css">

</head>

<body class="login-page">

<div class="login-container">

    <div class="background-overlay"></div>

    <div class="login-card">

        <div class="text-center">

            <div class="logo-circle">

               <i class="bi bi-heart-pulse"></i>

            </div>

            <h2>Welcome Back</h2>

            <p class="clinic-name">
                Sunrise Dental Clinic
            </p>

            <p class="subtitle">
                Please login to continue
            </p>

        </div>
        
                <%
    String registered = request.getParameter("registered");
%>

<% if ("true".equals(registered)) { %>

    <div class="login-alert success">

        <i class="bi bi-check-circle"></i>

        Account created successfully.
        Please login to continue.

    </div>

<% } %>
        

        <% if(request.getAttribute("error") != null){ %>

        <div class="alert alert-danger mt-4">

            <%=request.getAttribute("error")%>

        </div>
        
        


        <% } %>

        <form action="LoginServlet" method="post" id="loginForm">
                    <!-- Username -->
            <div class="mb-3">

                <label class="form-label">Username</label>

                <div class="input-group">

                    <span class="input-group-text">
                        <i class="bi bi-person-fill"></i>
                    </span>

                    <input
                            type="text"
                            name="username"
                            class="form-control"
                            placeholder="Enter your username"
                            required>

                </div>

            </div>




            <!-- Password -->
            <div class="mb-4">

                <label class="form-label">Password</label>

                <div class="input-group">

                    <span class="input-group-text">
                        <i class="bi bi-lock-fill"></i>
                    </span>

                    <input
                            type="password"
                            name="password"
                            id="password"
                            class="form-control"
                            placeholder="Enter your password"
                            required>

                    <button
                            class="btn btn-outline-secondary"
                            type="button"
                            onclick="togglePassword()">

                        <i id="toggleIcon" class="bi bi-eye"></i>

                    </button>

                </div>

            </div>

            <button
                    type="submit"
                    class="btn login-btn w-100"
                    id="loginBtn">

                <i class="bi bi-box-arrow-in-right"></i>

                Login

            </button>
            
            <div class="register-prompt">

    <span>Don't have an account?</span>

    <a href="user-register.jsp">
        Register
    </a>

</div>

        </form>

    </div>

</div>



<script>

function togglePassword(){

    const password=document.getElementById("password");
    const icon=document.getElementById("toggleIcon");

    if(password.type==="password"){

        password.type="text";
        icon.className="bi bi-eye-slash";

    }else{

        password.type="password";
        icon.className="bi bi-eye";

    }

}

document.getElementById("loginForm").addEventListener("submit",function(){

    const btn=document.getElementById("loginBtn");

    btn.innerHTML='<span class="spinner-border spinner-border-sm me-2"></span>Signing In...';

    btn.disabled=true;

});

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>