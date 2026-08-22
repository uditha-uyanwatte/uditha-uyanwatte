<%@page import="model.Dentist"%>

<%@page language="java"
        contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>

<%
    if(session.getAttribute("user") == null){

        response.sendRedirect("login.jsp");

        return;
    }

    Dentist dentist =
            (Dentist) request.getAttribute(
                    "dentist"
            );

    if(dentist == null){

        response.sendRedirect(
                "DentistProfileServlet"
        );

        return;
    }

    String image =
            dentist.getProfileImage();

    if(image == null ||
       image.trim().isEmpty()){

        image = "doctor-default.jpg";
    }
%>


<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Dentist Profile | Sunrise Dental
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


    <style>

        .profile-page {

            padding: 30px;

        }


        .profile-card {

            max-width: 1000px;

            margin: 0 auto;

            background: rgba(255,255,255,0.04);

            border: 1px solid rgba(255,255,255,0.08);

            border-radius: 24px;

            padding: 35px;

            box-shadow:
                0 15px 45px rgba(0,0,0,0.08);

        }


        .profile-header {

            display: flex;

            align-items: center;

            gap: 25px;

            margin-bottom: 35px;

        }


        .profile-photo-wrapper {

            position: relative;

            width: 150px;

            height: 150px;

            flex-shrink: 0;

        }


        .profile-photo {

            width: 150px;

            height: 150px;

            object-fit: cover;

            border-radius: 50%;

            border: 5px solid #19c5df;

            box-shadow:
                0 10px 30px rgba(25,197,223,0.25);

        }


        .photo-badge {

            position: absolute;

            right: 5px;

            bottom: 5px;

            width: 42px;

            height: 42px;

            border-radius: 50%;

            background: #19c5df;

            color: white;

            display: flex;

            align-items: center;

            justify-content: center;

            border: 4px solid white;

        }


        .profile-title h2 {

            margin-bottom: 5px;

            font-weight: 700;

        }


        .profile-title p {

            margin: 0;

            color: #7d9098;

        }


        .profile-section-title {

            font-size: 18px;

            font-weight: 700;

            margin-bottom: 20px;

            padding-bottom: 12px;

            border-bottom: 1px solid rgba(255,255,255,0.1);

        }


        .form-control {

            border-radius: 12px;

            padding: 12px 15px;

        }


        .save-profile-btn {

            border: none;

            background: #19c5df;

            color: white;

            padding: 13px 25px;

            border-radius: 12px;

            font-weight: 600;

        }


        .save-profile-btn:hover {

            background: #11aac1;

            color: white;

        }


        .cancel-profile-btn {

            padding: 13px 25px;

            border-radius: 12px;

        }


        .preview-box {

            margin-top: 15px;

            display: none;

        }


        .preview-box img {

            width: 110px;

            height: 110px;

            object-fit: cover;

            border-radius: 18px;

            border: 3px solid #19c5df;

        }


        @media(max-width: 768px){

            .profile-page {

                padding: 15px;

            }

            .profile-card {

                padding: 22px;

            }

            .profile-header {

                flex-direction: column;

                text-align: center;

            }

        }

    </style>

</head>


<body class="<%= session.getAttribute("theme") != null
        ? session.getAttribute("theme")
        : "light" %>">


<!-- SIDEBAR -->

<jsp:include page="includes/sidebar.jsp"/>


<!-- NAVBAR -->

<jsp:include page="includes/navbar.jsp"/>


<div class="main-content">


    <div class="profile-page">


        <!-- =========================
             PAGE HEADER
        ========================= -->

        <div class="page-header mb-4">

            <div>

                <h2>

                    <i class="bi bi-person-circle"></i>

                    My Profile

                </h2>

                <p>

                    Manage your dentist profile
                    information.

                </p>

            </div>

        </div>


        <!-- SUCCESS -->

        <% if(request.getParameter("success") != null){ %>

            <div class="alert alert-success">

                <i class="bi bi-check-circle-fill me-2"></i>

                Profile updated successfully.

            </div>

        <% } %>


        <!-- ERROR -->

        <% if(request.getParameter("error") != null){ %>

            <div class="alert alert-danger">

                <i class="bi bi-exclamation-triangle-fill me-2"></i>

                <%
                    String error =
                            request.getParameter(
                                    "error"
                            );

                    if("invalidImage".equals(error)){
                %>

                    Please upload a JPG,
                    PNG or WEBP image.

                <%
                    } else {
                %>

                    Unable to update profile.
                    Please try again.

                <%
                    }
                %>

            </div>

        <% } %>


        <!-- =========================
             PROFILE CARD
        ========================= -->

        <div class="profile-card">


            <!-- HEADER -->

            <div class="profile-header">


                <div class="profile-photo-wrapper">

                    <img
                        id="currentPhoto"
                        class="profile-photo"
                        src="assets/images/doctors/<%= image %>"
                        alt="Dentist Profile"
                        onerror="this.src='assets/images/doctors/doctor-default.jpg';">


                    <div class="photo-badge">

                        <i class="bi bi-camera-fill"></i>

                    </div>

                </div>


                <div class="profile-title">

                    <h2>

                        Dr.
                        <%= dentist.getFirstName() %>
                        <%= dentist.getLastName() %>

                    </h2>

                    <p>

                        <i class="bi bi-award-fill me-1"></i>

                        <%= dentist.getSpecialization() %>

                    </p>

                </div>

            </div>


            <!-- =========================
                 FORM
            ========================= -->

            <form
                action="UpdateDentistProfileServlet"
                method="post"
                enctype="multipart/form-data">


                <!-- HIDDEN ID -->

                <input
                    type="hidden"
                    name="dentistId"
                    value="<%= dentist.getDentistId() %>">


                <!-- =========================
                     PERSONAL INFORMATION
                ========================= -->

                <div class="profile-section-title">

                    <i class="bi bi-person-fill text-info me-2"></i>

                    Personal Information

                </div>


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
                            value="<%= dentist.getFirstName() %>"
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
                            value="<%= dentist.getLastName() %>"
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
                            value="<%= dentist.getSpecialization() %>"
                            required>

                    </div>


                    <!-- PHONE -->

                    <div class="col-md-6 mb-3">

                        <label class="form-label">

                            Phone Number

                        </label>

                        <input
                            type="text"
                            name="phone"
                            class="form-control"
                            value="<%= dentist.getPhone() %>">

                    </div>


                    <!-- EMAIL -->

                    <div class="col-12 mb-3">

                        <label class="form-label">

                            Email Address

                        </label>

                        <input
                            type="email"
                            name="email"
                            class="form-control"
                            value="<%= dentist.getEmail() %>">

                    </div>

                </div>


                <!-- =========================
                     PROFILE PHOTO
                ========================= -->

                <div class="profile-section-title mt-4">

                    <i class="bi bi-image-fill text-info me-2"></i>

                    Profile Photo

                </div>


                <div class="row">


                    <div class="col-md-8">

                        <label class="form-label">

                            Change Profile Photo

                        </label>

                        <input
                            type="file"
                            name="profileImage"
                            id="profileImage"
                            class="form-control"
                            accept=".jpg,.jpeg,.png,.webp">


                        <small class="text-muted">

                            JPG, JPEG, PNG or WEBP.
                            Maximum 5MB.

                        </small>


                        <!-- PREVIEW -->

                        <div
                            class="preview-box"
                            id="previewBox">

                            <p class="small text-muted">

                                New image preview:

                            </p>

                            <img
                                id="previewImage"
                                src=""
                                alt="Preview">

                        </div>

                    </div>

                </div>


                <!-- =========================
                     BUTTONS
                ========================= -->

                <div
                    class="d-flex gap-2 flex-wrap mt-4">


                    <button
                        type="submit"
                        class="save-profile-btn">

                        <i class="bi bi-check-circle-fill me-1"></i>

                        Save Changes

                    </button>


                    <a
                        href="dentist-dashboard.jsp"
                        class="btn btn-outline-secondary cancel-profile-btn">

                        <i class="bi bi-arrow-left me-1"></i>

                        Back

                    </a>

                </div>


            </form>

        </div>

    </div>

</div>


<!-- =========================
     IMAGE PREVIEW
========================= -->

<script>

    const imageInput =
        document.getElementById(
            "profileImage"
        );

    const previewBox =
        document.getElementById(
            "previewBox"
        );

    const previewImage =
        document.getElementById(
            "previewImage"
        );


    if(imageInput){

        imageInput.addEventListener(
            "change",
            function(){

                const file =
                    this.files[0];

                if(!file){

                    previewBox.style.display =
                        "none";

                    return;
                }


                const allowed = [

                    "image/jpeg",
                    "image/png",
                    "image/webp"

                ];


                if(!allowed.includes(file.type)){

                    alert(
                        "Please select JPG, PNG or WEBP."
                    );

                    this.value = "";

                    previewBox.style.display =
                        "none";

                    return;
                }


                if(file.size >
                   5 * 1024 * 1024){

                    alert(
                        "Image must be less than 5MB."
                    );

                    this.value = "";

                    previewBox.style.display =
                        "none";

                    return;
                }


                const reader =
                    new FileReader();


                reader.onload =
                    function(e){

                        previewImage.src =
                            e.target.result;

                        previewBox.style.display =
                            "block";

                    };


                reader.readAsDataURL(file);

            }
        );

    }

</script>


</body>

</html>