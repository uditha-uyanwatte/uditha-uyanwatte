<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.DentistDAO" %>
<%@ page import="model.Dentist" %>

<%
    DentistDAO dentistDAO = new DentistDAO();
    List<Dentist> dentists = dentistDAO.getAllDentists();
%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Sunrise Dental Clinic | Healthy Smile, Happy Life</title>

    <!-- Bootstrap -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <!-- AOS -->
    <link
        href="https://unpkg.com/aos@2.3.4/dist/aos.css"
        rel="stylesheet">

    <!-- Main CSS -->
    <link rel="stylesheet"
          href="assets/css/style.css">

</head>

<body>

<!-- ================= NAVBAR ================= -->

<nav class="navbar navbar-expand-lg fixed-top modern-navbar">

    <div class="container">

        <a class="navbar-brand brand-logo"
           href="index.jsp">

            <span class="brand-icon">

                <i class="bi bi-heart-pulse-fill"></i>

            </span>

            <span>

                Sunrise
                <strong>Dental</strong>

            </span>

        </a>


        <button
            class="navbar-toggler"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#mainNav">

            <i class="bi bi-list"></i>

        </button>


        <div
            class="collapse navbar-collapse"
            id="mainNav">

            <ul class="navbar-nav mx-auto">

                <li class="nav-item">
                    <a class="nav-link active"
                       href="#home">
                        Home
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link"
                       href="#services">
                        Services
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link"
                       href="#about">
                        About
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link"
                       href="#doctors">
                        Doctors
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link"
                       href="#gallery">
                        Gallery
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link"
                       href="#contact">
                        Contact
                    </a>
                </li>

            </ul>


            <div class="nav-actions">

                <a href="login.jsp"
                   class="nav-login">

                    Login

                </a>

                <a href="user-register.jsp"
                   class="nav-register">

                    Register

                </a>

            </div>

        </div>

    </div>

</nav>


<!-- ================= HERO ================= -->

<section id="home"
         class="modern-hero">

    <div class="hero-glow glow-one"></div>

    <div class="hero-glow glow-two"></div>


    <div class="container">

        <div class="row align-items-center">


            <!-- LEFT -->

            <div
                class="col-lg-6"
                data-aos="fade-right">

                <div class="hero-small-badge">

                    <i class="bi bi-patch-check-fill"></i>

                    Trusted Dental Care

                </div>


                <h1 class="hero-heading">

                    Your Smile.

                    <span>
                        Our Passion.
                    </span>

                </h1>


                <p class="hero-description">

                    Experience modern dental care with
                    experienced professionals, advanced
                    technology and a comfortable patient-first
                    environment.

                </p>


                <div class="hero-actions">

                    <a href="treatments.jsp"
                       class="hero-primary-btn">

                        <i class="bi bi-calendar2-check-fill"></i>

                        Book Appointment

                    </a>


                    <a href="/SunriseDentalClinic/src/main/webapp/appointment-details.jsp"
                       class="hero-secondary-btn">

                        Explore Services

                        <i class="bi bi-arrow-right"></i>

                    </a>

                </div>


                <!-- MINI STATS -->

                <div class="hero-mini-stats">

                    <div>

                        <strong>5K+</strong>

                        <span>Patients</span>

                    </div>

                    <div>

                        <strong>25+</strong>

                        <span>Dentists</span>

                    </div>

                    <div>

                        <strong>15+</strong>

                        <span>Years</span>

                    </div>

                </div>

            </div>


            <!-- RIGHT -->

            <div
                class="col-lg-6"
                data-aos="zoom-in">

                <div class="hero-visual">

                    <div class="visual-circle circle-one"></div>

                    <div class="visual-circle circle-two"></div>


                    <div class="tooth-card">

                        <div class="tooth-icon">

                            <i class="bi bi-emoji-smile-fill"></i>

                        </div>

                        <span>

                            Advanced

                        </span>

                        <strong>

                            Dental Care

                        </strong>

                    </div>


                    <div class="floating-card card-top">

                        <i class="bi bi-shield-check"></i>

                        <div>

                            <strong>Safe Treatment</strong>

                            <small>
                                Patient focused care
                            </small>

                        </div>

                    </div>


                    <div class="floating-card card-bottom">

                        <i class="bi bi-star-fill"></i>

                        <div>

                            <strong>5.0 Rating</strong>

                            <small>
                                Happy patients
                            </small>

                        </div>

                    </div>


                    <div class="hero-tooth">

                        🦷

                    </div>

                </div>

            </div>

        </div>

    </div>


    <div class="hero-bottom-wave"></div>

</section>


<!-- ================= TRUST ================= -->

<section class="trust-strip">

    <div class="container">

        <div class="row text-center g-4">

            <div class="col-md-3">

                <i class="bi bi-shield-check"></i>

                <strong>Safe Treatment</strong>

                <span>Modern & hygienic care</span>

            </div>


            <div class="col-md-3">

                <i class="bi bi-person-badge"></i>

                <strong>Expert Dentists</strong>

                <span>Qualified professionals</span>

            </div>


            <div class="col-md-3">

                <i class="bi bi-cpu"></i>

                <strong>Modern Technology</strong>

                <span>Advanced equipment</span>

            </div>


            <div class="col-md-3">

                <i class="bi bi-clock-history"></i>

                <strong>Easy Booking</strong>

                <span>Book appointments easily</span>

            </div>

        </div>

    </div>

</section>


<!-- ================= SERVICES ================= -->

<section id="services"
         class="modern-section">

    <div class="container">

        <div
            class="section-heading"
            data-aos="fade-up">

            <span>OUR SERVICES</span>

            <h2>

                Complete Dental Care

            </h2>

            <p>

                Everything you need for a healthier,
                brighter and more confident smile.

            </p>

        </div>


        <div class="row g-4">


            <div class="col-lg-4 col-md-6"
                 data-aos="fade-up">

                <div class="modern-service-card">

                    <div class="service-number">
                        01
                    </div>

                    <div class="modern-service-icon">

                        <i class="bi bi-emoji-smile"></i>

                    </div>

                    <h4>
                        General Dentistry
                    </h4>

                    <p>
                        Complete oral checkups,
                        cleaning and preventive dental care.
                    </p>

                    <a href="appointment.jsp">
                        Book Service
                        <i class="bi bi-arrow-up-right"></i>
                    </a>

                </div>

            </div>


            <div class="col-lg-4 col-md-6"
                 data-aos="fade-up"
                 data-aos-delay="100">

                <div class="modern-service-card">

                    <div class="service-number">
                        02
                    </div>

                    <div class="modern-service-icon">

                        <i class="bi bi-stars"></i>

                    </div>

                    <h4>
                        Teeth Whitening
                    </h4>

                    <p>
                        Professional whitening treatments
                        for a brighter and confident smile.
                    </p>

                    <a href="patient-appointment.jsp">
                        Book Service
                        <i class="bi bi-arrow-up-right"></i>
                    </a>

                </div>

            </div>


            <div class="col-lg-4 col-md-6"
                 data-aos="fade-up"
                 data-aos-delay="200">

                <div class="modern-service-card">

                    <div class="service-number">
                        03
                    </div>

                    <div class="modern-service-icon">

                        <i class="bi bi-heart-pulse"></i>

                    </div>

                    <h4>
                        Root Canal
                    </h4>

                    <p>
                        Comfortable and professional
                        root canal treatment.
                    </p>

                    <a href="patient-appointment.jsp">
                        Book Service
                        <i class="bi bi-arrow-up-right"></i>
                    </a>

                </div>

            </div>


            <div class="col-lg-4 col-md-6"
                 data-aos="fade-up">

                <div class="modern-service-card">

                    <div class="service-number">
                        04
                    </div>

                    <div class="modern-service-icon">

                        <i class="bi bi-gem"></i>

                    </div>

                    <h4>
                        Dental Implants
                    </h4>

                    <p>
                        Reliable tooth replacement
                        using modern dental technology.
                    </p>

                    <a href="patient-appointment.jsp">
                        Book Service
                        <i class="bi bi-arrow-up-right"></i>
                    </a>

                </div>

            </div>


            <div class="col-lg-4 col-md-6"
                 data-aos="fade-up"
                 data-aos-delay="100">

                <div class="modern-service-card">

                    <div class="service-number">
                        05
                    </div>

                    <div class="modern-service-icon">

                        <i class="bi bi-shield-plus"></i>

                    </div>

                    <h4>
                        Emergency Care
                    </h4>

                    <p>
                        Quick support for urgent dental
                        problems and emergencies.
                    </p>

                    <a href="patient-appointment.jsp">
                        Book Service
                        <i class="bi bi-arrow-up-right"></i>
                    </a>

                </div>

            </div>


            <div class="col-lg-4 col-md-6"
                 data-aos="fade-up"
                 data-aos-delay="200">

                <div class="modern-service-card">

                    <div class="service-number">
                        06
                    </div>

                    <div class="modern-service-icon">

                        <i class="bi bi-person-check"></i>

                    </div>

                    <h4>
                        Orthodontics
                    </h4>

                    <p>
                        Braces and smile correction
                        for a healthier alignment.
                    </p>

                    <a href="patient-appointment.jsp">
                        Book Service
                        <i class="bi bi-arrow-up-right"></i>
                    </a>

                </div>

            </div>

        </div>

    </div>

</section>


<!-- ================= ABOUT ================= -->

<section id="about"
         class="modern-about">

    <div class="container">

        <div class="row align-items-center g-5">

            <!-- ABOUT IMAGE -->
            <div class="col-lg-6"
                 data-aos="fade-right">

                <div class="about-modern-visual">

                    <div class="about-image-wrapper">

                        <img src="assets/images/about-clinic.jpg"
                             alt="Sunrise Dental Clinic"
                             class="about-clinic-img">

                    </div>


                    <!-- EXPERIENCE CARD -->
                    <div class="experience-card">

                        <strong>15+</strong>

                        <span>
                            Years of Experience
                        </span>

                    </div>

                </div>

            </div>


            <!-- ABOUT CONTENT -->
            <div class="col-lg-6"
                 data-aos="fade-left">

                <div class="section-heading text-start">

                    <span>
                        ABOUT SUNRISE DENTAL
                    </span>

                    <h2>
                        Modern Care For
                        Your Entire Family
                    </h2>

                </div>


                <p class="about-text">

                    Sunrise Dental Clinic provides
                    professional dental services using
                    modern technology and experienced
                    dental professionals.

                </p>


                <div class="about-checks">

                    <div>

                        <i class="bi bi-check-circle-fill"></i>

                        Advanced Dental Equipment

                    </div>


                    <div>

                        <i class="bi bi-check-circle-fill"></i>

                        Experienced Dentists

                    </div>


                    <div>

                        <i class="bi bi-check-circle-fill"></i>

                        Comfortable Environment

                    </div>


                    <div>

                        <i class="bi bi-check-circle-fill"></i>

                        Patient-Centered Treatment

                    </div>

                </div>


                <a href="user-register.jsp"
                   class="modern-btn">

                    Get Started

                    <i class="bi bi-arrow-right"></i>

                </a>

            </div>

        </div>

    </div>

</section>
<!-- ================= WHY US ================= -->

<section class="why-modern">

    <div class="container">

        <div
            class="section-heading text-center"
            data-aos="fade-up">

            <span>
                WHY CHOOSE US
            </span>

            <h2>
                Your Smile Deserves The Best
            </h2>

            <p>
                Professional dental care designed
                around your comfort and wellbeing.
            </p>

        </div>


        <div class="row g-4 mt-4">


            <div class="col-lg-3 col-md-6">

                <div class="why-modern-card">

                    <i class="bi bi-cpu-fill"></i>

                    <h4>
                        Modern Technology
                    </h4>

                    <p>
                        Advanced tools for accurate
                        diagnosis and treatment.
                    </p>

                </div>

            </div>


            <div class="col-lg-3 col-md-6">

                <div class="why-modern-card">

                    <i class="bi bi-person-badge-fill"></i>

                    <h4>
                        Expert Dentists
                    </h4>

                    <p>
                        Qualified professionals with
                        patient-focused care.
                    </p>

                </div>

            </div>


            <div class="col-lg-3 col-md-6">

                <div class="why-modern-card">

                    <i class="bi bi-shield-check"></i>

                    <h4>
                        Safe & Hygienic
                    </h4>

                    <p>
                        High standards of cleanliness
                        and patient safety.
                    </p>

                </div>

            </div>


            <div class="col-lg-3 col-md-6">

                <div class="why-modern-card">

                    <i class="bi bi-calendar2-check-fill"></i>

                    <h4>
                        Easy Booking
                    </h4>

                    <p>
                        Book your dental appointment
                        quickly and easily.
                    </p>

                </div>

            </div>

        </div>

    </div>

</section>


<!-- ================= DOCTORS ================= -->

<section id="doctors" class="modern-doctors">

    <div class="container">

        <div class="section-heading text-center"
             data-aos="fade-up">

            <span>OUR DENTISTS</span>

            <h2>
                Meet Our Dental Specialists
            </h2>

            <p>
                Our highly qualified dentists provide
                world-class dental care with modern technology.
            </p>

        </div>


        <div class="row g-4">

            <%
                if (dentists != null && !dentists.isEmpty()) {

                    for (Dentist dentist : dentists) {
            %>

                <div class="col-lg-4 col-md-6"
                     data-aos="fade-up">

                    <div class="doctor-card">

                        <!-- IMAGE -->

                        <div class="doctor-image">

                          <img src="assets/images/doctors/<%= dentist.getProfileImage() %>"
     alt="Dr. <%= dentist.getFirstName() %> <%= dentist.getLastName() %>">
                            <span class="doctor-status">
                                <i class="bi bi-check-circle-fill"></i>
                                Available
                            </span>

                        </div>


                        <!-- CONTENT -->

                        <div class="doctor-content">

                            <div class="doctor-rating">

                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>

                            </div>


                            <h3>
                                Dr.
                                <%= dentist.getFirstName() %>
                                <%= dentist.getLastName() %>
                            </h3>


                            <p class="doctor-specialization">

                                <%= dentist.getSpecialization() %>

                            </p>


                            <div class="doctor-contact">

                                <div>
                                    <i class="bi bi-telephone-fill"></i>

                                    <span>
                                        <%= dentist.getPhone() %>
                                    </span>
                                </div>


                                <div>
                                    <i class="bi bi-envelope-fill"></i>

                                    <span>
                                        <%= dentist.getEmail() %>
                                    </span>
                                </div>

                            </div>


                            <a href="patient-appointment.jsp?dentistId=<%= dentist.getDentistId() %>"
                               class="doctor-book-btn">

                                Book Appointment

                                <i class="bi bi-arrow-right"></i>

                            </a>

                        </div>

                    </div>

                </div>

            <%
                    }

                } else {
            %>

                <!-- EMPTY -->

                <div class="col-12">

                    <div class="empty-doctors">

                        <i class="bi bi-person-badge"></i>

                        <h4>
                            No Dentists Available
                        </h4>

                        <p>
                            Our dentist information will appear here.
                        </p>

                    </div>

                </div>

            <%
                }
            %>

        </div>

    </div>

</section>
<!-- ================= GALLERY ================= -->

<section id="gallery" class="modern-gallery">

    <div class="container">

        <div class="section-heading text-center"
             data-aos="fade-up">

            <span>OUR GALLERY</span>

            <h2>Explore Sunrise Dental</h2>

            <p>
                Take a look at our modern clinic,
                advanced equipment and comfortable
                dental care environment.
            </p>

        </div>


        <div class="gallery-grid"
             data-aos="fade-up">


            <div class="gallery-card">

                <img src="assets/images/gallery1.jpg"
                     alt="Sunrise Dental Clinic">

                <div class="gallery-overlay">

                    <div>

                        <i class="bi bi-zoom-in"></i>

                        <h4>Modern Clinic</h4>

                        <span>Sunrise Dental</span>

                    </div>

                </div>

            </div>


            <div class="gallery-card">

                <img src="assets/images/gallery2.jpg"
                     alt="Dental Treatment Room">

                <div class="gallery-overlay">

                    <div>

                        <i class="bi bi-zoom-in"></i>

                        <h4>Treatment Room</h4>

                        <span>Comfortable Care</span>

                    </div>

                </div>

            </div>


            <div class="gallery-card">

                <img src="assets/images/gallery3.jpg"
                     alt="Advanced Dental Equipment">

                <div class="gallery-overlay">

                    <div>

                        <i class="bi bi-zoom-in"></i>

                        <h4>Advanced Equipment</h4>

                        <span>Modern Technology</span>

                    </div>

                </div>

            </div>


            <div class="gallery-card">

                <img src="assets/images/gallery4.jpg"
                     alt="Dental Care">

                <div class="gallery-overlay">

                    <div>

                        <i class="bi bi-zoom-in"></i>

                        <h4>Dental Care</h4>

                        <span>Patient First</span>

                    </div>

                </div>

            </div>


            <div class="gallery-card">

                <img src="assets/images/gallery5.jpg"
                     alt="Sunrise Dental Team">

                <div class="gallery-overlay">

                    <div>

                        <i class="bi bi-zoom-in"></i>

                        <h4>Our Dental Team</h4>

                        <span>Professional Care</span>

                    </div>

                </div>

            </div>


            <div class="gallery-card">

                <img src="assets/images/gallery6.jpg"
                     alt="Dental Treatment">

                <div class="gallery-overlay">

                    <div>

                        <i class="bi bi-zoom-in"></i>

                        <h4>Patient Care</h4>

                        <span>Quality Treatment</span>

                    </div>

                </div>

            </div>

        </div>

    </div>

</section>


<!-- ================= GALLERY LIGHTBOX ================= -->

<div id="lightbox"
     class="gallery-lightbox">

    <button id="closeLightbox"
            class="gallery-close"
            type="button">

        <i class="bi bi-x-lg"></i>

    </button>

    <img id="lightboxImg"
         src=""
         alt="Gallery Preview">

</div>
<!-- ================= CTA ================= -->

<section class="final-cta">

    <div class="container">

        <div class="cta-box">

            <div>

                <span>
                    READY FOR A HEALTHIER SMILE?
                </span>

                <h2>
                    Book Your Appointment Today
                </h2>

                <p>
                    Take the first step towards
                    better dental health.
                </p>

            </div>


            <a href="appointment.jsp"
               class="cta-btn">

                Book Appointment

                <i class="bi bi-arrow-right"></i>

            </a>

        </div>

    </div>

</section>


<!-- ================= CONTACT ================= -->

<section id="contact"
         class="contact-modern">

    <div class="container">

        <!-- SECTION HEADING -->
        <div class="section-heading text-center">

            <span>
                GET IN TOUCH
            </span>

            <h2>
                Contact Sunrise Dental
            </h2>

            <p>
                Have a question or need an appointment?
                Get in touch with our friendly dental team.
            </p>

        </div>


        <!-- CONTACT INFORMATION -->
        <div class="row g-4 mb-5">


            <!-- ADDRESS -->
            <div class="col-lg-4 col-md-6">

                <div class="contact-modern-card">

                    <div class="contact-icon">

                        <i class="bi bi-geo-alt-fill"></i>

                    </div>

                    <h4>
                        Visit Us
                    </h4>

                    <p>
                        123 Main Street,<br>
                        Colombo, Sri Lanka
                    </p>

                </div>

            </div>


            <!-- PHONE -->
            <div class="col-lg-4 col-md-6">

                <div class="contact-modern-card">

                    <div class="contact-icon">

                        <i class="bi bi-telephone-fill"></i>

                    </div>

                    <h4>
                        Call Us
                    </h4>

                    <p>
                        +94 11 234 5678
                    </p>

                    <a href="tel:+94112345678"
                       class="contact-link">

                        Call Now
                        <i class="bi bi-arrow-right"></i>

                    </a>

                </div>

            </div>


            <!-- EMAIL -->
            <div class="col-lg-4 col-md-6">

                <div class="contact-modern-card">

                    <div class="contact-icon">

                        <i class="bi bi-envelope-fill"></i>

                    </div>

                    <h4>
                        Email Us
                    </h4>

                    <p>
                        info@sunrisedental.lk
                    </p>

                    <a href="mailto:info@sunrisedental.lk"
                       class="contact-link">

                        Send Email
                        <i class="bi bi-arrow-right"></i>

                    </a>

                </div>

            </div>

        </div>


        <!-- ================= CONTACT FORM ================= -->

        <div class="row justify-content-center">

            <div class="col-lg-9">

                <div class="contact-form-card">

                    <div class="contact-form-heading">

                        <span>
                            SEND US A MESSAGE
                        </span>

                        <h3>
                            How Can We Help You?
                        </h3>

                        <p>
                            Send us a message and our team
                            will get back to you as soon as possible.
                        </p>

                    </div>


                    <form action="ContactServlet"
                          method="post">


                        <div class="row">


                            <!-- NAME -->
                            <div class="col-md-6 mb-3">

                                <label for="contactName">
                                    Your Name
                                </label>

                                <input
                                    type="text"
                                    id="contactName"
                                    name="name"
                                    class="form-control"
                                    placeholder="Enter your name"
                                    required>

                            </div>


                            <!-- EMAIL -->
                            <div class="col-md-6 mb-3">

                                <label for="contactEmail">
                                    Email Address
                                </label>

                                <input
                                    type="email"
                                    id="contactEmail"
                                    name="email"
                                    class="form-control"
                                    placeholder="Enter your email"
                                    required>

                            </div>


                            <!-- PHONE -->
                            <div class="col-md-6 mb-3">

                                <label for="contactPhone">
                                    Phone Number
                                </label>

                                <input
                                    type="tel"
                                    id="contactPhone"
                                    name="phone"
                                    class="form-control"
                                    placeholder="+94 XX XXX XXXX"
                                    required>

                            </div>


                            <!-- SUBJECT -->
                            <div class="col-md-6 mb-3">

                                <label for="contactSubject">
                                    Subject
                                </label>

                                <input
                                    type="text"
                                    id="contactSubject"
                                    name="subject"
                                    class="form-control"
                                    placeholder="How can we help?"
                                    required>

                            </div>


                            <!-- MESSAGE -->
                            <div class="col-12 mb-4">

                                <label for="contactMessage">
                                    Your Message
                                </label>

                                <textarea
                                    id="contactMessage"
                                    name="message"
                                    class="form-control"
                                    rows="5"
                                    placeholder="Write your message here..."
                                    required></textarea>

                            </div>


                            <!-- SUBMIT -->
                            <div class="col-12">

                                <button
                                    type="submit"
                                    class="contact-submit">

                                    Send Message

                                    <i class="bi bi-send-fill"></i>

                                </button>

                            </div>

                        </div>

                    </form>

                </div>

            </div>

        </div>

    </div>

</section>

<!-- ================= FOOTER ================= -->

<footer class="modern-footer">

    <div class="container">

        <div class="row g-5">


            <div class="col-lg-5">

                <a href="index.jsp"
                   class="footer-modern-brand">

                    <i class="bi bi-heart-pulse-fill"></i>

                    Sunrise
                    <strong>Dental</strong>

                </a>


                <p>

                    Modern, comfortable and
                    patient-centered dental care
                    for healthier smiles and happier lives.

                </p>


                <div class="footer-social">

                    <a href="#">
                        <i class="bi bi-facebook"></i>
                    </a>

                    <a href="#">
                        <i class="bi bi-instagram"></i>
                    </a>

                    <a href="#">
                        <i class="bi bi-whatsapp"></i>
                    </a>

                </div>

            </div>


            <div class="col-lg-3">

                <h5>
                    Quick Links
                </h5>

                <a href="#home">Home</a>

                <a href="#services">Services</a>

                <a href="#about">About</a>

                <a href="#doctors">Doctors</a>

                <a href="#contact">Contact</a>

            </div>


            <div class="col-lg-4">

                <h5>
                    Opening Hours
                </h5>

                <p>
                    Monday - Saturday
                    <br>
                    8:00 AM - 8:00 PM
                </p>

                <p>
                    Emergency Support: 24/7
                </p>

            </div>

        </div>


        <div class="footer-bottom">

            © 2026 Sunrise Dental Clinic.
            All Rights Reserved.

        </div>

    </div>

</footer>


<!-- BACK TO TOP -->

<a href="#home"
   class="back-to-top">

    <i class="bi bi-arrow-up"></i>

</a>


<!-- Bootstrap JS -->

<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>


<!-- AOS -->

<script
    src="https://unpkg.com/aos@2.3.4/dist/aos.js">
</script>


<script>

    AOS.init({

        duration: 900,

        once: true,

        offset: 80

    });


    window.addEventListener(
        "scroll",
        function () {

            const btn =
                document.querySelector(".back-to-top");

            if (window.scrollY > 500) {

                btn.classList.add("show");

            } else {

                btn.classList.remove("show");

            }

        }
    );

</script>


<script src="assets/js/script.js"></script>

</body>

</html>