<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<nav class="top-navbar">

    <div class="navbar-left">

        <div>

            <h3>Dashboard</h3>

            <span>

                Welcome,
                <strong>
                    <%= session.getAttribute("fullName") != null ? session.getAttribute("fullName") : "Administrator" %>
                </strong>

            </span>

        </div>

    </div>

    <div class="navbar-right">

        <div class="search-wrapper">

            <i class="bi bi-search"></i>

            <input
                    type="text"
                    class="search-box"
                    placeholder="Search anything...">

        </div>

        <button class="notification-btn">

            <i class="bi bi-bell-fill"></i>

        </button>

        <div class="profile-box">

            <div class="profile-icon">

                <i class="bi bi-person-fill"></i>

            </div>

            <div>

                <h6>
                    <%= session.getAttribute("fullName") != null ? session.getAttribute("fullName") : "Administrator" %>
                </h6>

                <small>System Administrator</small>

            </div>

        </div>

        <a href="LogoutServlet" class="logout-btn">

            <i class="bi bi-box-arrow-right"></i>

            Logout

        </a>

    </div>

</nav>