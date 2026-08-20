<%@ page import="java.util.List" %>
<%@ page import="model.User" %>

<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    User loggedUser =
            (User) session.getAttribute("user");

    if (!"ADMIN".equalsIgnoreCase(
            loggedUser.getRole())) {

        response.sendRedirect("login.jsp");
        return;
    }

    List<User> users =
            (List<User>) request.getAttribute("users");

    String keyword =
            (String) request.getAttribute("keyword");
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>User Management | Sunrise Dental</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
        rel="stylesheet">

    <link
        rel="stylesheet"
        href="assets/css/style.css">

</head>

<body>

<jsp:include page="includes/sidebar.jsp"/>

<jsp:include page="includes/navbar.jsp"/>


<div class="main-content">

    <div class="container-fluid p-4">


        <!-- HEADER -->

        <div class="page-header mb-4">

            <div>

                <h2>

                    <i class="bi bi-people-fill"></i>

                    User Management

                </h2>

                <p>
                    Manage system users and their roles.
                </p>

            </div>

        </div>


        <!-- ALERTS -->

        <% if (request.getParameter("updated")
                != null) { %>

            <div class="alert alert-success">

                <i class="bi bi-check-circle-fill"></i>

                User role updated successfully.

            </div>

        <% } %>


        <% if (request.getParameter("deleted")
                != null) { %>

            <div class="alert alert-success">

                <i class="bi bi-check-circle-fill"></i>

                User deleted successfully.

            </div>

        <% } %>


        <% if (request.getParameter("error")
                != null) { %>

            <div class="alert alert-danger">

                <i class="bi bi-exclamation-circle-fill"></i>

                Unable to complete this action.

            </div>

        <% } %>


        <!-- USER TABLE -->

        <div class="table-card">


            <div class="d-flex
                        justify-content-between
                        align-items-center
                        mb-4">

                <h4>

                    <i class="bi bi-person-lines-fill
                              text-info"></i>

                    System Users

                </h4>

                <span class="badge bg-info">

                    <%= users != null
                        ? users.size()
                        : 0 %>

                    Users

                </span>

            </div>


            <!-- SEARCH -->

            <form method="get"
                  action="UserManagementServlet">

                <div class="row g-3">

                    <div class="col-lg-10">

                        <div class="input-group">

                            <span
                                class="input-group-text
                                       bg-dark
                                       border-info
                                       text-info">

                                <i class="bi bi-search"></i>

                            </span>

                            <input
                                type="text"
                                name="search"
                                class="form-control
                                       search-input"
                                placeholder="Search by name, username, email or role..."
                                value="<%= keyword == null
                                        ? ""
                                        : keyword %>">

                        </div>

                    </div>


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


            <div class="mt-3">

                <a
                    href="UserManagementServlet"
                    class="btn btn-outline-light">

                    <i class="bi bi-arrow-clockwise"></i>

                    Reset

                </a>

            </div>


            <hr class="my-4">


            <!-- TABLE -->

            <div class="table-responsive">

                <table
                    class="table patient-table align-middle">

                    <thead>

                    <tr>

                        <th>ID</th>

                        <th>User</th>

                        <th>Email</th>

                        <th>Phone</th>

                        <th>Role</th>

                        <th class="text-center">
                            Change Role
                        </th>

                        <th class="text-center">
                            Action
                        </th>

                    </tr>

                    </thead>


                    <tbody>

                    <%
                        if (users != null &&
                            !users.isEmpty()) {

                            for (User user : users) {

                    %>

                    <tr>

                        <!-- ID -->

                        <td>

                            <span class="patient-id">

                                #<%= user.getId() %>

                            </span>

                        </td>


                        <!-- USER -->

                        <td>

                            <div class="d-flex
                                        align-items-center">

                                <div class="patient-avatar">

                                    <i class="bi bi-person-fill"></i>

                                </div>

                                <div class="ms-3">

                                    <strong>

                                        <%= user.getFullName() %>

                                    </strong>

                                    <br>

                                    <small
                                        class="text-muted">

                                        @<%= user.getUsername() %>

                                    </small>

                                </div>

                            </div>

                        </td>


                        <!-- EMAIL -->

                        <td>

                            <%= user.getEmail() == null
                                ? "-"
                                : user.getEmail() %>

                        </td>


                        <!-- PHONE -->

                        <td>

                            <%= user.getPhone() == null
                                ? "-"
                                : user.getPhone() %>

                        </td>


                        <!-- CURRENT ROLE -->

                        <td>

                            <span
                                class="badge
                                <%= "ADMIN".equalsIgnoreCase(
                                        user.getRole())
                                    ? "bg-danger"
                                    : "DENTIST".equalsIgnoreCase(
                                        user.getRole())
                                    ? "bg-primary"
                                    : "RECEPTIONIST".equalsIgnoreCase(
                                        user.getRole())
                                    ? "bg-warning text-dark"
                                    : "bg-info" %>">

                                <%= user.getRole() %>

                            </span>

                        </td>


                        <!-- CHANGE ROLE -->

                        <td class="text-center">

                            <form
                                action="UpdateUserRoleServlet"
                                method="post"
                                class="d-flex
                                       justify-content-center
                                       gap-2">

                                <input
                                    type="hidden"
                                    name="userId"
                                    value="<%= user.getId() %>">


                                <select
                                    name="role"
                                    class="form-select form-select-sm"
                                    style="width:150px;">

                                    <option
                                        value="PATIENT"
                                        <%= "PATIENT".equalsIgnoreCase(
                                                user.getRole())
                                            ? "selected"
                                            : "" %>>

                                        Patient

                                    </option>

                                    <option
                                        value="DENTIST"
                                        <%= "DENTIST".equalsIgnoreCase(
                                                user.getRole())
                                            ? "selected"
                                            : "" %>>

                                        Dentist

                                    </option>

                                    <option
                                        value="RECEPTIONIST"
                                        <%= "RECEPTIONIST".equalsIgnoreCase(
                                                user.getRole())
                                            ? "selected"
                                            : "" %>>

                                        Receptionist

                                    </option>

                                    <option
                                        value="ADMIN"
                                        <%= "ADMIN".equalsIgnoreCase(
                                                user.getRole())
                                            ? "selected"
                                            : "" %>>

                                        Admin

                                    </option>

                                </select>


                                <button
                                    type="submit"
                                    class="btn btn-sm btn-info">

                                    <i class="bi bi-save"></i>

                                </button>

                            </form>

                        </td>


                        <!-- DELETE -->

                        <td class="text-center">

                            <%
                                if (user.getId()
                                    != loggedUser.getId()) {
                            %>

                            <a
                                href="DeleteUserServlet?id=<%= user.getId() %>"
                                class="btn btn-danger btn-sm
                                       rounded-circle"
                                onclick="return confirm(
                                    'Delete this user?'
                                );">

                                <i class="bi bi-trash"></i>

                            </a>

                            <%
                                } else {
                            %>

                            <span
                                class="badge bg-secondary">

                                Current User

                            </span>

                            <%
                                }
                            %>

                        </td>

                    </tr>

                    <%
                            }

                        } else {
                    %>

                    <tr>

                        <td colspan="7"
                            class="text-center p-5">

                            <i
                                class="bi bi-people"
                                style="font-size:45px;">
                            </i>

                            <br><br>

                            No users found.

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

</body>

</html>