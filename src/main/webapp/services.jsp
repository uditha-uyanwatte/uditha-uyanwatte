<%@page import="java.util.List"%>
<%@page import="dao.ServiceDAO"%>
<%@page import="model.Service"%>

<%@page language="java"
        contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    ServiceDAO dao = new ServiceDAO();

    String keyword = request.getParameter("search");

    List<Service> list;

    if (keyword != null && !keyword.trim().isEmpty()) {
        list = dao.searchServices(keyword);
    } else {
        list = dao.getAllServices();
    }
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Services</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <link
        rel="stylesheet"
        href="assets/css/style.css">

</head>


<body class="<%= session.getAttribute("theme") != null
        ? session.getAttribute("theme")
        : "light" %>">


<!-- ================= SIDEBAR ================= -->

<jsp:include page="includes/sidebar.jsp"/>


<!-- ================= NAVBAR ================= -->

<jsp:include page="includes/navbar.jsp"/>


<!-- ================= MAIN CONTENT ================= -->

<div class="main-content">

    <div class="container-fluid p-4">


        <!-- PAGE HEADER -->

        <div class="page-header mb-4">

            <div>

                <h2>

                    <i class="bi bi-heart-pulse-fill"></i>

                    Dental Services

                </h2>

                <p>

                    Manage all dental treatments and services.

                </p>

            </div>

        </div>


        <!-- SUCCESS MESSAGE -->

        <% if (request.getParameter("success") != null) { %>

            <div class="alert alert-success alert-dismissible fade show">

                <i class="bi bi-check-circle-fill"></i>

                Service added successfully.

                <button
                    type="button"
                    class="btn-close"
                    data-bs-dismiss="alert">

                </button>

            </div>

        <% } %>


        <!-- ERROR MESSAGE -->

        <% if (request.getParameter("error") != null) { %>

            <div class="alert alert-danger alert-dismissible fade show">

                <i class="bi bi-exclamation-triangle-fill"></i>

                Something went wrong.

                <button
                    type="button"
                    class="btn-close"
                    data-bs-dismiss="alert">

                </button>

            </div>

        <% } %>



        <!-- ================= ADD SERVICE ================= -->

        <div class="table-card mb-4">

            <h4 class="mb-4">

                <i class="bi bi-plus-circle-fill text-info"></i>

                Add New Service

            </h4>


            <form
                action="AddServiceServlet"
                method="post">


                <div class="row">


                    <!-- SERVICE NAME -->

                    <div class="col-md-6 mb-3">

                        <label class="form-label">

                            Service Name

                        </label>

                        <input
                            type="text"
                            name="serviceName"
                            class="form-control"
                            placeholder="Enter service name"
                            required>

                    </div>


                    <!-- PRICE -->

                    <div class="col-md-6 mb-3">

                        <label class="form-label">

                            Price (Rs.)

                        </label>

                        <input
                            type="number"
                            name="price"
                            class="form-control"
                            placeholder="Enter service price"
                            step="0.01"
                            min="0"
                            required>

                    </div>


                    <!-- DURATION -->

                    <div class="col-md-6 mb-3">

                        <label class="form-label">

                            Duration

                        </label>

                        <input
                            type="text"
                            name="duration"
                            class="form-control"
                            placeholder="Example: 30 Minutes"
                            required>

                    </div>


                    <!-- IMAGE -->

                    <div class="col-md-6 mb-3">

                        <label class="form-label">

                            Service Image

                        </label>

                        <input
                            type="text"
                            name="image"
                            class="form-control"
                            placeholder="Example: cleaning.jpg">

                    </div>


                    <!-- DESCRIPTION -->

                    <div class="col-12 mb-3">

                        <label class="form-label">

                            Description

                        </label>

                        <textarea
                            name="description"
                            class="form-control"
                            rows="4"
                            placeholder="Enter service description"
                            required></textarea>

                    </div>


                    <!-- BUTTON -->

                    <div class="col-12">

                        <button
                            type="submit"
                            class="save-btn">

                            <i class="bi bi-check2-circle"></i>

                            Save Service

                        </button>

                    </div>


                </div>

            </form>

        </div>



        <!-- ================= SERVICE RECORDS ================= -->

        <div class="table-card">


            <div
                class="d-flex justify-content-between align-items-center mb-4">


                <h4>

                    <i class="bi bi-list-ul text-info"></i>

                    Service Records

                </h4>


                <span class="badge bg-info">

                    <%= list.size() %> Services

                </span>

            </div>



            <!-- SEARCH -->

            <form method="get">

                <div class="row g-3 align-items-center">


                    <div class="col-lg-10">

                        <div class="input-group">

                            <span
                                class="input-group-text bg-dark border-info text-info">

                                <i class="bi bi-search"></i>

                            </span>


                            <input
                                type="text"
                                name="search"
                                class="form-control search-input"
                                placeholder="Search by service name, description or duration..."

                                value="<%= keyword == null
                                        ? ""
                                        : keyword %>">

                        </div>

                    </div>


                    <div class="col-lg-2 d-grid">

                        <button
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
                    href="services.jsp"
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

                            <th>Image</th>

                            <th>Service</th>

                            <th>Description</th>

                            <th>Price</th>

                            <th>Duration</th>

                            <th class="text-center">

                                Actions

                            </th>

                        </tr>

                    </thead>



                    <tbody>


                    <% if (list != null && !list.isEmpty()) { %>


                        <% for (Service service : list) { %>


                            <tr>


                                <!-- ID -->

                                <td>

                                    <span class="patient-id">

                                        #<%= service.getServiceId() %>

                                    </span>

                                </td>



                                <!-- IMAGE -->

                                <td>

                                    <div
                                        class="service-table-image">


                                        <% if (
                                            service.getImage() != null
                                            && !service.getImage().trim().isEmpty()
                                        ) { %>

                                            <img
                                                src="assets/images/services/<%= service.getImage() %>"
                                                alt="<%= service.getServiceName() %>">

                                        <% } else { %>

                                            <i
                                                class="bi bi-heart-pulse-fill">

                                            </i>

                                        <% } %>

                                    </div>

                                </td>



                                <!-- SERVICE NAME -->

                                <td>

                                    <strong>

                                        <%= service.getServiceName() %>

                                    </strong>

                                </td>



                                <!-- DESCRIPTION -->

                                <td>

                                    <span class="text-muted">

                                        <%= service.getDescription() %>

                                    </span>

                                </td>



                                <!-- PRICE -->

                                <td>

                                    <strong class="text-success">

                                        Rs.
                                        <%= String.format(
                                            "%,.2f",
                                            service.getPrice()
                                        ) %>

                                    </strong>

                                </td>



                                <!-- DURATION -->

                                <td>

                                    <span class="badge bg-primary">

                                        <i class="bi bi-clock"></i>

                                        <%= service.getDuration() %>

                                    </span>

                                </td>



                                <!-- ACTIONS -->

                                <td class="text-center">


                                    <!-- VIEW -->

                                    <button
                                        type="button"
                                        class="btn btn-info btn-sm rounded-circle me-1"
                                        data-bs-toggle="modal"
                                        data-bs-target="#serviceModal<%= service.getServiceId() %>">

                                        <i class="bi bi-eye-fill"></i>

                                    </button>



                                    <!-- EDIT -->

                                    <a
                                        href="edit-service.jsp?id=<%= service.getServiceId() %>"
                                        class="btn btn-warning btn-sm rounded-circle me-1">

                                        <i class="bi bi-pencil-fill"></i>

                                    </a>



                                    <!-- DELETE -->

                                    <a
                                        href="DeleteServiceServlet?id=<%= service.getServiceId() %>"
                                        class="btn btn-danger btn-sm rounded-circle"

                                        onclick="return confirm('Delete this service?');">

                                        <i class="bi bi-trash-fill"></i>

                                    </a>


                                </td>

                            </tr>



                            <!-- ================= VIEW MODAL ================= -->

                            <div
                                class="modal fade"
                                id="serviceModal<%= service.getServiceId() %>"
                                tabindex="-1"
                                aria-hidden="true">


                                <div
                                    class="modal-dialog modal-dialog-centered">


                                    <div class="modal-content">


                                        <div class="modal-header">


                                            <h5 class="modal-title">

                                                <i class="bi bi-heart-pulse-fill text-info"></i>

                                                <%= service.getServiceName() %>

                                            </h5>


                                            <button
                                                type="button"
                                                class="btn-close"
                                                data-bs-dismiss="modal">

                                            </button>

                                        </div>



                                        <div class="modal-body">


                                            <% if (
                                                service.getImage() != null
                                                && !service.getImage().trim().isEmpty()
                                            ) { %>

                                                <img
                                                    src="assets/images/services/<%= service.getImage() %>"
                                                    class="img-fluid rounded mb-3"
                                                    alt="<%= service.getServiceName() %>">

                                            <% } %>



                                            <p>

                                                <strong>

                                                    Description:

                                                </strong>

                                                <br>

                                                <%= service.getDescription() %>

                                            </p>


                                            <hr>


                                            <p>

                                                <i class="bi bi-cash-stack text-success"></i>

                                                <strong>

                                                    Price:

                                                </strong>

                                                Rs.
                                                <%= String.format(
                                                    "%,.2f",
                                                    service.getPrice()
                                                ) %>

                                            </p>



                                            <p>

                                                <i class="bi bi-clock text-primary"></i>

                                                <strong>

                                                    Duration:

                                                </strong>

                                                <%= service.getDuration() %>

                                            </p>


                                        </div>



                                        <div class="modal-footer">

                                            <button
                                                type="button"
                                                class="btn btn-secondary"
                                                data-bs-dismiss="modal">

                                                Close

                                            </button>

                                        </div>


                                    </div>

                                </div>

                            </div>


                        <% } %>


                    <% } else { %>


                        <tr>

                            <td
                                colspan="7"
                                class="text-center py-5">

                                <i
                                    class="bi bi-inbox fs-1 text-muted">

                                </i>

                                <h5 class="mt-3">

                                    No Services Found

                                </h5>

                                <p class="text-muted">

                                    Add your first dental service.

                                </p>

                            </td>

                        </tr>


                    <% } %>
                    
                    
                    <% if (request.getParameter("updated") != null) { %>

    <div class="alert alert-warning alert-dismissible fade show">

        <i class="bi bi-pencil-square"></i>

        Service updated successfully.

        <button
            type="button"
            class="btn-close"
            data-bs-dismiss="alert">
        </button>

    </div>

<% } %>


<% if (request.getParameter("deleted") != null) { %>

    <div class="alert alert-danger alert-dismissible fade show">

        <i class="bi bi-trash-fill"></i>

        Service deleted successfully.

        <button
            type="button"
            class="btn-close"
            data-bs-dismiss="alert">
        </button>

    </div>

<% } %>


                    </tbody>

                </table>


            </div>


        </div>


    </div>

</div>



<!-- BOOTSTRAP JS -->

<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">

</script>


</body>

</html>