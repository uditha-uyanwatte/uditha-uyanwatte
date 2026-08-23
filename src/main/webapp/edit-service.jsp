<%@page import="dao.ServiceDAO"%>
<%@page import="model.Service"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));

    ServiceDAO dao = new ServiceDAO();
    Service service = dao.getServiceById(id);

    if (service == null) {
        response.sendRedirect("services.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Edit Service</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <link rel="stylesheet" href="assets/css/style.css">

</head>

<body class="<%= session.getAttribute("theme") != null
        ? session.getAttribute("theme")
        : "light" %>">

<jsp:include page="includes/sidebar.jsp"/>
<jsp:include page="includes/navbar.jsp"/>

<div class="main-content">

    <div class="container-fluid p-4">

        <div class="page-header mb-4">

            <div>

                <h2>
                    <i class="bi bi-pencil-square"></i>
                    Edit Service
                </h2>

                <p>
                    Update dental service details.
                </p>

            </div>

        </div>


        <div class="table-card">

            <h4 class="mb-4">

                <i class="bi bi-heart-pulse-fill text-info"></i>

                Update:
                <%= service.getServiceName() %>

            </h4>


            <form action="UpdateServiceServlet" method="post">

                <input
                    type="hidden"
                    name="serviceId"
                    value="<%= service.getServiceId() %>">


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
                            value="<%= service.getServiceName() %>"
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
                            step="0.01"
                            min="0"
                            value="<%= service.getPrice() %>"
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
                            value="<%= service.getDuration() %>"
                            required>

                    </div>


                    <!-- IMAGE -->

                    <div class="col-md-6 mb-3">

                        <label class="form-label">
                            Image File Name
                        </label>

                        <input
                            type="text"
                            name="image"
                            class="form-control"
                            value="<%= service.getImage() != null
                                    ? service.getImage()
                                    : "" %>">

                    </div>


                    <!-- DESCRIPTION -->

                    <div class="col-12 mb-3">

                        <label class="form-label">
                            Description
                        </label>

                        <textarea
                            name="description"
                            class="form-control"
                            rows="5"
                            required><%= service.getDescription() %></textarea>

                    </div>


                    <!-- BUTTONS -->

                    <div class="col-12 d-flex gap-2">

                        <button
                            type="submit"
                            class="save-btn">

                            <i class="bi bi-check-circle-fill"></i>

                            Update Service

                        </button>


                        <a
                            href="services.jsp"
                            class="btn btn-secondary">

                            <i class="bi bi-arrow-left"></i>

                            Cancel

                        </a>

                    </div>

                </div>

            </form>

        </div>

    </div>

</div>

</body>
</html>