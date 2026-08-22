<%@page import="java.util.List"%>
<%@page import="dao.DentistDAO"%>
<%@page import="model.Dentist"%>

<%@page language="java"
        contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>

<%
    // =========================
    // LOGIN CHECK
    // =========================

    if(session.getAttribute("user") == null){

        response.sendRedirect("login.jsp");

        return;
    }


    // =========================
    // DENTIST DATA
    // =========================

    DentistDAO dao = new DentistDAO();

    String keyword = request.getParameter("search");

    List<Dentist> list;

    if(keyword != null && !keyword.trim().isEmpty()){

        list = dao.searchDentists(keyword);

    } else {

        list = dao.getAllDentists();

    }
%>


<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Dentists</title>


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


    <style>

       
    </style>

</head>


<body class="<%= session.getAttribute("theme") != null
        ? session.getAttribute("theme")
        : "light" %>">


<!-- =========================
     SIDEBAR
========================= -->

<jsp:include page="includes/sidebar.jsp"/>


<!-- =========================
     NAVBAR
========================= -->

<jsp:include page="includes/navbar.jsp"/>


<!-- =========================
     MAIN CONTENT
========================= -->

<div class="main-content">

    <div class="container-fluid p-4">


        <!-- =========================
             PAGE HEADER
        ========================= -->

        <div class="page-header mb-4">

            <div>

                <h2>

                    <i class="bi bi-person-vcard-fill"></i>

                    Dentists

                </h2>

                <p>

                    Manage all dentists and specializations.

                </p>

            </div>

        </div>


        <!-- =========================
             SUCCESS MESSAGE
        ========================= -->

        <% if(request.getParameter("success") != null){ %>

            <div class="alert alert-success">

                <i class="bi bi-check-circle-fill me-2"></i>

                Dentist added successfully.

            </div>

        <% } %>


        <!-- =========================
             UPDATED MESSAGE
        ========================= -->

        <% if(request.getParameter("updated") != null){ %>

            <div class="alert alert-warning">

                <i class="bi bi-pencil-square me-2"></i>

                Dentist updated successfully.

            </div>

        <% } %>


        <!-- =========================
             DELETED MESSAGE
        ========================= -->

        <% if(request.getParameter("deleted") != null){ %>

            <div class="alert alert-danger">

                <i class="bi bi-trash-fill me-2"></i>

                Dentist deleted successfully.

            </div>

        <% } %>


        <!-- =========================
             ERROR MESSAGE
        ========================= -->

        <% if(request.getParameter("error") != null){ %>

            <div class="alert alert-danger">

                <i class="bi bi-exclamation-triangle-fill me-2"></i>

                <%
                    String error =
                            request.getParameter("error");

                    if("invalidImage".equals(error)){
                %>

                    Invalid image format.
                    Please upload JPG, JPEG, PNG or WEBP.

                <%
                    } else if("add".equals(error)){
                %>

                    Unable to add dentist.
                    Please try again.

                <%
                    } else {
                %>

                    Something went wrong.
                    Please try again.

                <%
                    }
                %>

            </div>

        <% } %>


        <!-- =====================================================
             ADD NEW DENTIST
        ===================================================== -->

        <div class="table-card mb-4">

            <h4 class="mb-4">

                <i class="bi bi-person-plus-fill text-info"></i>

                Add New Dentist

            </h4>


            <!-- IMPORTANT:
                 enctype is required for image upload
            -->

            <form
                action="AddDentistServlet"
                method="post"
                enctype="multipart/form-data">


                <div class="row">


                    <!-- FIRST NAME -->

                    <div class="col-md-6 mb-3">

                        <label class="form-label">

                            First Name

                        </label>

                        <input
                            type="text"
                            name="firstName"
                            class="form-control"
                            placeholder="Enter first name"
                            required>

                    </div>


                    <!-- LAST NAME -->

                    <div class="col-md-6 mb-3">

                        <label class="form-label">

                            Last Name

                        </label>

                        <input
                            type="text"
                            name="lastName"
                            class="form-control"
                            placeholder="Enter last name"
                            required>

                    </div>


                    <!-- SPECIALIZATION -->

                    <div class="col-md-6 mb-3">

                        <label class="form-label">

                            Specialization

                        </label>

                        <input
                            type="text"
                            name="specialization"
                            class="form-control"
                            placeholder="e.g. Orthodontist"
                            required>

                    </div>


                    <!-- PHONE -->

                    <div class="col-md-6 mb-3">

                        <label class="form-label">

                            Phone

                        </label>

                        <input
                            type="text"
                            name="phone"
                            class="form-control"
                            placeholder="+94 XX XXX XXXX">

                    </div>


                    <!-- EMAIL -->

                    <div class="col-md-6 mb-3">

                        <label class="form-label">

                            Email

                        </label>

                        <input
                            type="email"
                            name="email"
                            class="form-control"
                            placeholder="dentist@example.com">

                    </div>


                    <!-- PROFILE IMAGE -->

                    <div class="col-md-6 mb-3">

                        <label class="form-label">

                            Dentist Profile Image

                        </label>

                        <input
                            type="file"
                            name="profileImage"
                            id="profileImage"
                            class="form-control"
                            accept=".jpg,.jpeg,.png,.webp">


                        <small class="image-help">

                            JPG, JPEG, PNG or WEBP.
                            Maximum size: 5MB.

                        </small>


                        <!-- IMAGE PREVIEW -->

                        <div
                            id="imagePreviewWrapper"
                            class="image-preview-wrapper">

                            <img
                                id="imagePreview"
                                class="image-preview"
                                src=""
                                alt="Image Preview">

                        </div>

                    </div>


                    <!-- SAVE BUTTON -->

                    <div class="col-12">

                        <button
                            type="submit"
                            class="save-btn">

                            <i class="bi bi-check2-circle"></i>

                            Save Dentist

                        </button>

                    </div>

                </div>

            </form>

        </div>


        <!-- =====================================================
             DENTIST RECORDS
        ===================================================== -->

        <div class="table-card">


            <!-- HEADER -->

            <div
                class="d-flex justify-content-between align-items-center mb-4">

                <h4>

                    <i class="bi bi-person-lines-fill text-info"></i>

                    Dentist Records

                </h4>


                <span class="badge bg-info">

                    <%= list.size() %> Dentists

                </span>

            </div>


            <!-- =========================
                 SEARCH
            ========================= -->

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
                                placeholder="Search Dentist by Name, Specialization, Phone or Email..."
                                value="<%= keyword == null ? "" : keyword %>">

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


            <!-- RESET -->

            <div class="mt-3">

                <a
                    href="dentists.jsp"
                    class="btn btn-outline-light">

                    <i class="bi bi-arrow-clockwise"></i>

                    Reset

                </a>

            </div>


            <hr class="my-4">


            <!-- =========================
                 TABLE
            ========================= -->

            <div class="table-responsive">

                <table
                    class="table patient-table align-middle">


                    <thead>

                        <tr>

                            <th>ID</th>

                            <th>Dentist</th>

                            <th>Specialization</th>

                            <th>Phone</th>

                            <th>Email</th>

                            <th class="text-center">

                                Actions

                            </th>

                        </tr>

                    </thead>


                    <tbody>


                    <%


                    if(list != null && !list.isEmpty()){


                        for(Dentist d : list){

                    %>


                        <tr>


                            <!-- ID -->

                            <td>

                                <span class="patient-id">

                                    #<%= d.getDentistId() %>

                                </span>

                            </td>


                            <!-- DENTIST -->

                            <td>

                                <div
                                    class="d-flex align-items-center">


                                    <!-- PROFILE IMAGE -->

                                    <div
                                        class="patient-avatar dentist-avatar">


                                        <img
                                            src="assets/images/doctors/<%=

                                            (d.getProfileImage() != null
                                            && !d.getProfileImage()
                                            .trim().isEmpty())

                                            ? d.getProfileImage()

                                            : "doctor-default.jpg"

                                            %>"

                                            alt="Dr. <%= d.getFirstName() %> <%= d.getLastName() %>"

                                            onerror="this.src='assets/images/doctors/doctor-default.jpg';">

                                    </div>


                                    <!-- NAME -->

                                    <div class="ms-3">

                                        <strong>

                                            Dr.
                                            <%= d.getFirstName() %>
                                            <%= d.getLastName() %>

                                        </strong>

                                    </div>

                                </div>

                            </td>


                            <!-- SPECIALIZATION -->

                            <td>

                                <span
                                    class="badge bg-primary">

                                    <%= d.getSpecialization() %>

                                </span>

                            </td>


                            <!-- PHONE -->

                            <td>

                                <%= d.getPhone() %>

                            </td>


                            <!-- EMAIL -->

                            <td>

                                <%= d.getEmail() %>

                            </td>


                            <!-- ACTIONS -->

                            <td class="text-center">


                                <!-- EDIT -->

                                <a
                                    href="edit-dentist.jsp?id=<%= d.getDentistId() %>"
                                    class="btn btn-warning btn-sm rounded-circle me-2"
                                    title="Edit Dentist">

                                    <i class="bi bi-pencil"></i>

                                </a>


                                <!-- DELETE -->

                                <a
                                    href="DeleteDentistServlet?id=<%= d.getDentistId() %>"
                                    class="btn btn-danger btn-sm rounded-circle"
                                    title="Delete Dentist"
                                    onclick="return confirm('Delete this dentist?');">

                                    <i class="bi bi-trash"></i>

                                </a>


                            </td>


                        </tr>


                    <%

                        }

                    } else {

                    %>


                        <!-- EMPTY -->

                        <tr>

                            <td
                                colspan="6"
                                class="text-center py-5">


                                <div>

                                    <i
                                        class="bi bi-person-x"
                                        style="font-size:45px;color:#19c5df;">
                                    </i>


                                    <h5 class="mt-3">

                                        No Dentists Found

                                    </h5>


                                    <p class="text-muted">

                                        No dentist records are available.

                                    </p>

                                </div>


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


<!-- =====================================================
     IMAGE PREVIEW SCRIPT
===================================================== -->

<script>

    const profileImage =
        document.getElementById("profileImage");

    const imagePreview =
        document.getElementById("imagePreview");

    const imagePreviewWrapper =
        document.getElementById("imagePreviewWrapper");


    if(profileImage){

        profileImage.addEventListener(
            "change",
            function(){

                const file =
                    this.files[0];


                if(!file){

                    imagePreviewWrapper.style.display =
                        "none";

                    imagePreview.src = "";

                    return;

                }


                const allowedTypes = [

                    "image/jpeg",
                    "image/png",
                    "image/webp"

                ];


                if(!allowedTypes.includes(file.type)){

                    alert(
                        "Please select a JPG, JPEG, PNG or WEBP image."
                    );

                    this.value = "";

                    imagePreviewWrapper.style.display =
                        "none";

                    return;

                }


                if(file.size > 5 * 1024 * 1024){

                    alert(
                        "Image size must be less than 5MB."
                    );

                    this.value = "";

                    imagePreviewWrapper.style.display =
                        "none";

                    return;

                }


                const reader =
                    new FileReader();


                reader.onload =
                    function(e){

                        imagePreview.src =
                            e.target.result;

                        imagePreviewWrapper.style.display =
                            "block";

                    };


                reader.readAsDataURL(file);

            }
        );

    }

</script>


</body>

</html>