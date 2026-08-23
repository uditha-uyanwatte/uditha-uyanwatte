<%@page import="java.util.List"%>
<%@page import="dao.ServiceDAO"%>
<%@page import="model.Service"%>
<%@page language="java"
        contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>

<%
    ServiceDAO serviceDAO = new ServiceDAO();

    List<Service> services =
            serviceDAO.getAllServices();
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>
        Our Services | Sunrise Dental
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


<body>


<!-- ================= NAVBAR ================= -->

<nav class="navbar navbar-expand-lg">

    <div class="container">

        <a
            class="navbar-brand"
            href="index.jsp">

            <i class="bi bi-heart-pulse-fill"></i>

            Sunrise Dental

        </a>


        <a
            href="index.jsp"
            class="btn btn-outline-primary">

            <i class="bi bi-arrow-left"></i>

            Back Home

        </a>

    </div>

</nav>



<!-- ================= PAGE HERO ================= -->

<section class="services-page-hero">

    <div class="container text-center">

        <span>
            OUR DENTAL SERVICES
        </span>

        <h1>
            Complete Care
            For Your Smile
        </h1>

        <p>
            Explore all professional dental services
            available at Sunrise Dental Clinic.
        </p>

    </div>

</section>



<!-- ================= ALL SERVICES ================= -->

<section class="all-services-section">

    <div class="container">


        <div class="row g-4">


            <%

                if (services != null
                        && !services.isEmpty()) {

                    int count = 0;

                    for (Service service : services) {

                        count++;

                        int delay =
                                ((count - 1) % 3) * 100;

            %>


            <div
                class="col-lg-4 col-md-6"
                data-aos="fade-up"
                data-aos-delay="<%= delay %>">


                <div class="modern-service-card">


                    <!-- NUMBER -->

                    <div class="service-number">

                        <%= String.format(
                                "%02d",
                                count
                        ) %>

                    </div>


                    <!-- ICON -->

                    <div class="modern-service-icon">

                        <i class="bi bi-heart-pulse"></i>

                    </div>


                    <!-- NAME -->

                    <h4>

                        <%= service.getServiceName() %>

                    </h4>


                    <!-- DESCRIPTION -->

                    <p>

                        <%= service.getDescription() %>

                    </p>


                    <!-- DETAILS -->

                    <div class="service-home-meta">

                        <span>

                            <i class="bi bi-cash-stack"></i>

                            Rs.
                            <%= String.format(
                                    "%,.0f",
                                    service.getPrice()
                            ) %>

                        </span>


                        <span>

                            <i class="bi bi-clock"></i>

                            <%= service.getDuration() %>

                        </span>

                    </div>


                    <!-- BOOK -->

                    <a
                        href="patient-appointment.jsp?serviceId=<%= service.getServiceId() %>">

                        Book Service

                        <i class="bi bi-arrow-up-right"></i>

                    </a>


                </div>

            </div>


            <%

                    }

                } else {

            %>


            <!-- EMPTY SERVICES -->

            <div class="col-12">

                <div class="empty-services">

                    <i class="bi bi-heart-pulse"></i>

                    <h3>
                        No Services Available
                    </h3>

                    <p>
                        Our dental services will be
                        available soon.
                    </p>

                </div>

            </div>


            <%

                }

            %>


        </div>


        <!-- BACK HOME -->

        <div class="text-center mt-5">

            <a
                href="index.jsp"
                class="modern-btn">

                <i class="bi bi-arrow-left"></i>

                Back To Home

            </a>

        </div>


    </div>

</section>


</body>

</html>