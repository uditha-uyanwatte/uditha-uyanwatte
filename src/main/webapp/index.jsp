<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>
Sunrise Dental Clinic
</title>

<!-- Bootstrap -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<!-- Icons -->

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<!-- AOS -->

<link href="https://unpkg.com/aos@2.3.4/dist/aos.css"
rel="stylesheet">

<!-- CSS -->

<link rel="stylesheet"
href="assets/css/style.css">

</head>

<body>

<!-- =======================
        NAVBAR
======================== -->

<nav class="navbar navbar-expand-lg fixed-top">

<div class="container">

<a class="navbar-brand" href="#">

<i class="bi bi-heart-pulse-fill"></i>

Sunrise Dental

</a>

<button
class="navbar-toggler"
type="button"
data-bs-toggle="collapse"
data-bs-target="#nav">

<span class="navbar-toggler-icon"></span>

</button>

<div
class="collapse navbar-collapse"
id="nav">

<ul class="navbar-nav mx-auto">

<li class="nav-item">

<a class="nav-link active"
href="#">

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
href="#contact">

Contact

</a>

</li>

</ul>

<div class="d-flex">

<a href="user-login.jsp"
class="btn-login">

Login

</a>

<a href="user-register.jsp"
class="btn-register">

Register

</a>

</div>

</div>

</div>

</nav>

<!-- ======================
        HERO
====================== -->

<section class="hero">

<div class="container">

<div class="row align-items-center">

<div class="col-lg-6">

<div
data-aos="fade-right">

<span class="hero-badge">

Welcome To

Sunrise Dental Clinic

</span>

<h1>

Healthy Smile

<span>

Happy Life

</span>

</h1>

<p>

Experience world-class dental care with
modern technology, professional dentists,
and personalized treatment.

</p>

<div class="hero-buttons">

<a href="#"

class="btn-book">

Book Appointment

</a>

<a href="#services"

class="btn-outline">

Explore

</a>

</div>

</div>

</div>

<div class="col-lg-6">

<div
class="hero-model"
data-aos="zoom-in">

<!-- Three.js Canvas -->

<div id="hero3d"></div>

</div>

</div>

</div>

</div>

</section>

<!-- ======================
    SCROLL DOWN
====================== -->

<div class="scroll-down">

<i class="bi bi-mouse"></i>

<p>

Scroll Down

</p>

</div>

<!-- Bootstrap -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- AOS -->

<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>

<script>

AOS.init({

duration:1200,

once:true

});

</script>

<!-- Hero Animation -->



<!-- ======================
        TRUSTED
====================== -->

<section class="trusted-section">

    <div class="container">

        <p class="trusted-title">

            Trusted by 5000+ Happy Patients

        </p>

        <div class="trusted-logos">

            <div class="logo-card">
                <i class="bi bi-heart-pulse-fill"></i>
                Modern Care
            </div>

            <div class="logo-card">
                <i class="bi bi-hospital"></i>
                Advanced Clinic
            </div>

            <div class="logo-card">
                <i class="bi bi-shield-check"></i>
                Safe Treatment
            </div>

            <div class="logo-card">
                <i class="bi bi-award-fill"></i>
                Certified Doctors
            </div>

        </div>

    </div>

</section>

<!-- ======================
        SERVICES
====================== -->

<section id="services" class="services-section">

<div class="container">

<div class="section-title">

<span>

Our Services

</span>

<h2>

Complete Dental Care

</h2>

<p>

Professional dental services using modern technology.

</p>

</div>

<div class="row">

<div class="col-lg-4 mb-4">

<div class="service-card">

<div class="service-icon">

<i class="bi bi-emoji-smile"></i>

</div>

<h4>

General Dentistry

</h4>

<p>

Routine dental checkups and oral care.

</p>

</div>

</div>

<div class="col-lg-4 mb-4">

<div class="service-card">

<div class="service-icon">

<i class="bi bi-stars"></i>

</div>

<h4>

Teeth Whitening

</h4>

<p>

Brighten your smile with advanced whitening.

</p>

</div>

</div>

<div class="col-lg-4 mb-4">

<div class="service-card">

<div class="service-icon">

<i class="bi bi-heart-pulse"></i>

</div>

<h4>

Root Canal

</h4>

<p>

Pain-free root canal treatment.

</p>

</div>

</div>

<div class="col-lg-4 mb-4">

<div class="service-card">

<div class="service-icon">

<i class="bi bi-gem"></i>

</div>

<h4>

Dental Implants

</h4>

<p>

Permanent replacement for missing teeth.

</p>

</div>

</div>

<div class="col-lg-4 mb-4">

<div class="service-card">

<div class="service-icon">

<i class="bi bi-shield-plus"></i>

</div>

<h4>

Emergency Care

</h4>

<p>

Immediate dental emergency treatments.

</p>

</div>

</div>

<div class="col-lg-4 mb-4">

<div class="service-card">

<div class="service-icon">

<i class="bi bi-person-check-fill"></i>

</div>

<h4>

Orthodontics

</h4>

<p>

Braces and smile correction.

</p>
<a href="#">
    Learn More
    <i class="bi bi-arrow-right"></i>
</a>

</div>

</div>

</div>

</div>


</section>

<section id="about" class="about-section">

    <div class="container">

        <div class="row align-items-center">

            <!-- Left -->

            <div class="col-lg-6" data-aos="fade-right">

                <div class="about-image">

                    <img src="assets/images/about-clinic.jpg"
                         class="img-fluid">

                    <div class="experience-box">

                        <h2>15+</h2>

                        <p>Years Experience</p>

                    </div>

                </div>

            </div>

            <!-- Right -->

            <div class="col-lg-6" data-aos="fade-left">

                <span class="section-tag">

                    About Sunrise Dental

                </span>

                <h2>

                    Modern Dental Care
                    For Your Family

                </h2>

                <p>

                    Sunrise Dental Clinic provides advanced dental
                    treatments using the latest technology with
                    experienced dentists.

                </p>

                <div class="about-list">

                    <div>

                        <i class="bi bi-check-circle-fill"></i>

                        Advanced Equipment

                    </div>

                    <div>

                        <i class="bi bi-check-circle-fill"></i>

                        Digital X-Ray

                    </div>

                    <div>

                        <i class="bi bi-check-circle-fill"></i>

                        Emergency Support

                    </div>

                    <div>

                        <i class="bi bi-check-circle-fill"></i>

                        Experienced Dentists

                    </div>

                </div>

                <a href="user-register.jsp"
                   class="about-btn">

                    Learn More

                    <i class="bi bi-arrow-right"></i>

                </a>

            </div>

        </div>

    </div>

</section>


<!-- ===========================
        WHY CHOOSE US
=========================== -->

<section class="why-section">

    <div class="container">

        <div class="section-title text-center">

            <span class="section-tag">
                Why Choose Us
            </span>

            <h2>
                We Make Your Smile Beautiful
            </h2>

            <p>
                We combine advanced dental technology with experienced professionals
                to provide the best treatment for every patient.
            </p>

        </div>

        <div class="row mt-5">

            <div class="col-lg-3 col-md-6 mb-4">

                <div class="why-card">

                    <div class="why-icon">
                        <i class="bi bi-cpu-fill"></i>
                    </div>

                    <h4>Modern Equipment</h4>

                    <p>
                        Latest dental technology with digital diagnosis.
                    </p>

                </div>

            </div>

            <div class="col-lg-3 col-md-6 mb-4">

                <div class="why-card">

                    <div class="why-icon">
                        <i class="bi bi-person-badge-fill"></i>
                    </div>

                    <h4>Expert Dentists</h4>

                    <p>
                        Highly experienced and qualified dental specialists.
                    </p>

                </div>

            </div>

            <div class="col-lg-3 col-md-6 mb-4">

                <div class="why-card">

                    <div class="why-icon">
                        <i class="bi bi-shield-check"></i>
                    </div>

                    <h4>Safe Treatment</h4>

                    <p>
                        Comfortable, hygienic and painless dental procedures.
                    </p>

                </div>

            </div>

            <div class="col-lg-3 col-md-6 mb-4">

                <div class="why-card">

                    <div class="why-icon">
                        <i class="bi bi-calendar2-check-fill"></i>
                    </div>

                    <h4>Easy Booking</h4>

                    <p>
                        Book appointments online anytime within minutes.
                    </p>

                </div>

            </div>

        </div>

    </div>

</section>

<!-- ======================
        STATISTICS
====================== -->

<section class="stats-section">

<div class="container">

<div class="row text-center">

<div class="col-md-3">

<div class="stat-card">

<h2>5000+</h2>

<p>Happy Patients</p>

</div>

</div>

<div class="col-md-3">

<div class="stat-card">

<h2>25+</h2>

<p>Professional Dentists</p>

</div>

</div>

<div class="col-md-3">

<div class="stat-card">

<h2>15+</h2>

<p>Years Experience</p>

</div>

</div>

<div class="col-md-3">

<div class="stat-card">

<h2>24/7</h2>

<p>Emergency Support</p>

</div>

</div>

</div>

</div>

</section>

<!-- ======================
        DOCTORS
====================== -->

<section id="doctors" class="doctors-section">

<div class="container">

<div class="section-title">

<span>OUR SPECIALISTS</span>

<h2>Meet Our Expert Dentists</h2>

<p>
Our highly qualified dentists provide world-class dental care with modern technology.
</p>

</div>

<div class="row">

<div class="col-lg-4 col-md-6 mb-4">

    <div class="doctor-card">

        <div class="doctor-image">

            <img src="assets/images/doctor1.jpg" alt="Doctor">

            

        </div>

        <div class="doctor-info">

            <div class="doctor-rating">

                <i class="bi bi-star-fill"></i>
                <i class="bi bi-star-fill"></i>
                <i class="bi bi-star-fill"></i>
                <i class="bi bi-star-fill"></i>
                <i class="bi bi-star-fill"></i>

            </div>

            <h3>Dr. Amanda Smith</h3>

            <p>Orthodontist</p>

            <div class="doctor-social">

                <a href="#"><i class="bi bi-facebook"></i></a>
                <a href="#"><i class="bi bi-instagram"></i></a>
                <a href="#"><i class="bi bi-linkedin"></i></a>

            </div>

            <a href="appointment.jsp" class="doctor-btn">

                Book Appointment

            </a>

        </div>

    </div>

</div>
<div class="col-lg-4 col-md-6 mb-4">

<div class="doctor-card">

<div class="doctor-image">

<img src="assets/images/doctor2.jpg" alt="Doctor">



</div>

<div class="doctor-info">

<div class="doctor-rating">

<i class="bi bi-star-fill"></i>
<i class="bi bi-star-fill"></i>
<i class="bi bi-star-fill"></i>
<i class="bi bi-star-fill"></i>
<i class="bi bi-star-half"></i>

</div>

<h3>Dr. Michael Lee</h3>

<p>Dental Surgeon</p>

<div class="doctor-social">

<a href="#"><i class="bi bi-facebook"></i></a>

<a href="#"><i class="bi bi-instagram"></i></a>

<a href="#"><i class="bi bi-linkedin"></i></a>

</div>

<a href="appointment.jsp" class="doctor-btn">

Book Appointment

</a>

</div>

</div>

</div>

<div class="col-lg-4 col-md-6 mb-4">

<div class="doctor-card">

<div class="doctor-image">

<img src="assets/images/doctor3.jpg" alt="Doctor">



</div>

<div class="doctor-info">

<div class="doctor-rating">

<i class="bi bi-star-fill"></i>
<i class="bi bi-star-fill"></i>
<i class="bi bi-star-fill"></i>
<i class="bi bi-star-fill"></i>
<i class="bi bi-star"></i>

</div>

<h3>Dr. Sophia Brown</h3>

<p>Cosmetic Dentist</p>

<div class="doctor-social">

<a href="#"><i class="bi bi-facebook"></i></a>

<a href="#"><i class="bi bi-instagram"></i></a>

<a href="#"><i class="bi bi-linkedin"></i></a>

</div>

<a href="appointment.jsp" class="doctor-btn">

Book Appointment

</a>

</div>

</div>

</div>
</section>






<!-- =========================
        GALLERY
========================= -->

<section class="gallery-section" id="gallery">

    <div class="container">

        <div class="section-title">

            <span>OUR GALLERY</span>

            <h2>Modern Dental Clinic</h2>

            <p>
                Explore our modern clinic, advanced technology
                and comfortable treatment environment.
            </p>

        </div>

        <div class="gallery-grid">

            <!-- Gallery 1 -->
            <div class="gallery-item gallery-large">

                <img src="assets/images/gallery1.jpg"
                     alt="Sunrise Dental Clinic">

                <div class="gallery-overlay">

                    <div class="gallery-view">
                        <i class="bi bi-arrows-fullscreen"></i>
                    </div>

                    <div class="gallery-caption">
                        <h4>Modern Reception</h4>
                        <span>Our welcoming clinic environment</span>
                    </div>

                </div>

            </div>


            <!-- Gallery 2 -->
            <div class="gallery-item">

                <img src="assets/images/gallery2.jpg"
                     alt="Dental Treatment Room">

                <div class="gallery-overlay">

                    <div class="gallery-view">
                        <i class="bi bi-arrows-fullscreen"></i>
                    </div>

                    <div class="gallery-caption">
                        <h4>Advanced Treatment Room</h4>
                        <span>Modern dental equipment</span>
                    </div>

                </div>

            </div>


            <!-- Gallery 3 -->
            <div class="gallery-item">

                <img src="assets/images/gallery3.jpg"
                     alt="Dental Treatment">

                <div class="gallery-overlay">

                    <div class="gallery-view">
                        <i class="bi bi-arrows-fullscreen"></i>
                    </div>

                    <div class="gallery-caption">
                        <h4>Professional Care</h4>
                        <span>Experienced dental specialists</span>
                    </div>

                </div>

            </div>


            <!-- Gallery 4 -->
            <div class="gallery-item gallery-wide">

                <img src="assets/images/gallery4.jpg"
                     alt="Happy Dental Patient">

                <div class="gallery-overlay">

                    <div class="gallery-view">
                        <i class="bi bi-arrows-fullscreen"></i>
                    </div>

                    <div class="gallery-caption">
                        <h4>Happy Patients</h4>
                        <span>Creating confident smiles</span>
                    </div>

                </div>

            </div>


            <!-- Gallery 5 -->
            <div class="gallery-item gallery-wide">

                <img src="assets/images/gallery5.jpg"
                     alt="Dental Consultation">

                <div class="gallery-overlay">

                    <div class="gallery-view">
                        <i class="bi bi-arrows-fullscreen"></i>
                    </div>

                    <div class="gallery-caption">
                        <h4>Digital Diagnosis</h4>
                        <span>Modern diagnostic technology</span>
                    </div>

                </div>

            </div>

        </div>

    </div>

</section>


<!-- =========================
        LIGHTBOX
========================= -->

<div id="lightbox">

    <button id="closeLightbox" aria-label="Close">
        <i class="bi bi-x-lg"></i>
    </button>

    <img id="lightboxImg"
         src=""
         alt="Gallery Preview">

</div>

<!-- =========================
        TESTIMONIALS
========================= -->

<section class="testimonial-section"
         id="testimonials">

    <div class="container">

        <div class="section-title">

            <span>TESTIMONIALS</span>

            <h2>What Our Patients Say</h2>

            <p>
                Trusted by thousands of happy patients
                for quality dental care and friendly service.
            </p>

        </div>


        <div class="row g-4">


            <!-- Testimonial 1 -->

            <div class="col-lg-4 col-md-6">

                <div class="testimonial-card">

                    <div class="quote-icon">
                        <i class="bi bi-quote"></i>
                    </div>

                    <div class="testimonial-stars">

                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>

                    </div>

                    <p>
                        "Excellent service. The doctors were
                        very friendly and the treatment was
                        painless. I felt very comfortable
                        throughout my treatment."
                    </p>


                    <div class="patient-info">

                        <img src="assets/images/patient1.jpg"
                             alt="John Perera">

                        <div>

                            <h4>
                                John Perera
                            </h4>

                            <span>
                                Happy Patient
                            </span>

                        </div>

                    </div>

                </div>

            </div>


            <!-- Testimonial 2 -->

            <div class="col-lg-4 col-md-6">

                <div class="testimonial-card">

                    <div class="quote-icon">
                        <i class="bi bi-quote"></i>
                    </div>

                    <div class="testimonial-stars">

                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>

                    </div>

                    <p>
                        "Modern clinic with advanced
                        equipment. The staff were kind,
                        professional and very helpful.
                        Highly recommended."
                    </p>


                    <div class="patient-info">

                        <img src="assets/images/patient2.jpg"
                             alt="Nadeesha Silva">

                        <div>

                            <h4>
                                Nadeesha Silva
                            </h4>

                            <span>
                                Happy Patient
                            </span>

                        </div>

                    </div>

                </div>

            </div>


            <!-- Testimonial 3 -->

            <div class="col-lg-4 col-md-6">

                <div class="testimonial-card">

                    <div class="quote-icon">
                        <i class="bi bi-quote"></i>
                    </div>

                    <div class="testimonial-stars">

                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>

                    </div>

                    <p>
                        "Professional dentists and
                        excellent customer care.
                        My smile has completely changed.
                        Thank you Sunrise Dental!"
                    </p>


                    <div class="patient-info">

                        <img src="assets/images/patient3.jpg"
                             alt="Kasun Fernando">

                        <div>

                            <h4>
                                Kasun Fernando
                            </h4>

                            <span>
                                Happy Patient
                            </span>

                        </div>

                    </div>

                </div>

            </div>


        </div>

    </div>

</section>

<!-- =========================
        CONTACT
========================= -->

<section id="contact" class="contact-section">

    <div class="container">

        <div class="section-title">

            <span>GET IN TOUCH</span>

            <h2>Contact Sunrise Dental</h2>

            <p>
                Have a question or need an appointment?
                Our friendly team is here to help.
            </p>

        </div>


        <div class="row g-4 align-items-stretch">

            <!-- Contact Information -->

            <div class="col-lg-5">

                <div class="contact-info-card">

                    <h3>
                        Let's Talk About Your Smile
                    </h3>

                    <p>
                        Contact our team today and take the
                        first step towards a healthier,
                        brighter smile.
                    </p>


                    <div class="contact-item">

                        <div class="contact-icon">
                            <i class="bi bi-geo-alt-fill"></i>
                        </div>

                        <div>
                            <h5>Our Clinic</h5>

                            <p>
                                123 Main Street,<br>
                                Colombo, Sri Lanka
                            </p>
                        </div>

                    </div>


                    <div class="contact-item">

                        <div class="contact-icon">
                            <i class="bi bi-telephone-fill"></i>
                        </div>

                        <div>
                            <h5>Phone</h5>

                            <p>
                                +94 11 234 5678
                            </p>
                        </div>

                    </div>


                    <div class="contact-item">

                        <div class="contact-icon">
                            <i class="bi bi-envelope-fill"></i>
                        </div>

                        <div>
                            <h5>Email</h5>

                            <p>
                                info@sunrisedental.lk
                            </p>
                        </div>

                    </div>


                    <div class="contact-item">

                        <div class="contact-icon">
                            <i class="bi bi-clock-fill"></i>
                        </div>

                        <div>
                            <h5>Opening Hours</h5>

                            <p>
                                Monday - Saturday<br>
                                8:00 AM - 8:00 PM
                            </p>
                        </div>

                    </div>

                </div>

            </div>


            <!-- Contact Form -->

            <div class="col-lg-7">

                <div class="contact-form-card">

                    <h3>Send Us a Message</h3>

                    <p>
                        Fill in the form and our team will
                        get back to you as soon as possible.
                    </p>


                    <form action="#" method="post">

                        <div class="row">

                            <div class="col-md-6 mb-3">

                                <label>
                                    Your Name
                                </label>

                                <input
                                    type="text"
                                    class="form-control"
                                    placeholder="Enter your name"
                                    required>

                            </div>


                            <div class="col-md-6 mb-3">

                                <label>
                                    Email Address
                                </label>

                                <input
                                    type="email"
                                    class="form-control"
                                    placeholder="Enter your email"
                                    required>

                            </div>


                            <div class="col-md-6 mb-3">

                                <label>
                                    Phone Number
                                </label>

                                <input
                                    type="tel"
                                    class="form-control"
                                    placeholder="Enter your phone number"
                                    required>

                            </div>


                            <div class="col-md-6 mb-3">

                                <label>
                                    Subject
                                </label>

                                <input
                                    type="text"
                                    class="form-control"
                                    placeholder="How can we help?">

                            </div>


                            <div class="col-12 mb-3">

                                <label>
                                    Message
                                </label>

                                <textarea
                                    class="form-control"
                                    rows="5"
                                    placeholder="Write your message here..."
                                    required></textarea>

                            </div>


                            <div class="col-12">

                                <button
                                    type="submit"
                                    class="contact-submit">

                                    Send Message

                                    <i class="bi bi-arrow-right"></i>

                                </button>

                            </div>

                        </div>

                    </form>

                </div>

            </div>

        </div>

    </div>

</section>


<!-- =========================
        FOOTER
========================= -->

<footer class="footer-section">

    <div class="container">

        <div class="row g-5">

            <!-- Brand -->

            <div class="col-lg-4 col-md-6">

                <a href="#" class="footer-brand">

                    <i class="bi bi-heart-pulse-fill"></i>

                    <span>Sunrise <strong>Dental</strong></span>

                </a>

                <p class="footer-description">

                    Providing modern, comfortable and
                    patient-centered dental care for
                    healthy smiles and happier lives.

                </p>

                <div class="footer-social">

                    <a href="#">
                        <i class="bi bi-facebook"></i>
                    </a>

                    <a href="#">
                        <i class="bi bi-instagram"></i>
                    </a>

                    <a href="#">
                        <i class="bi bi-linkedin"></i>
                    </a>

                    <a href="#">
                        <i class="bi bi-whatsapp"></i>
                    </a>

                </div>

            </div>


            <!-- Quick Links -->

            <div class="col-lg-2 col-md-6">

                <h5 class="footer-title">
                    Quick Links
                </h5>

                <ul class="footer-links">

                    <li>
                        <a href="#">
                            Home
                        </a>
                    </li>

                    <li>
                        <a href="#services">
                            Services
                        </a>
                    </li>

                    <li>
                        <a href="#about">
                            About Us
                        </a>
                    </li>

                    <li>
                        <a href="#doctors">
                            Doctors
                        </a>
                    </li>

                    <li>
                        <a href="#contact">
                            Contact
                        </a>
                    </li>

                </ul>

            </div>


            <!-- Services -->

            <div class="col-lg-3 col-md-6">

                <h5 class="footer-title">
                    Our Services
                </h5>

                <ul class="footer-links">

                    <li>
                        <a href="#services">
                            General Dentistry
                        </a>
                    </li>

                    <li>
                        <a href="#services">
                            Teeth Whitening
                        </a>
                    </li>

                    <li>
                        <a href="#services">
                            Dental Implants
                        </a>
                    </li>

                    <li>
                        <a href="#services">
                            Root Canal
                        </a>
                    </li>

                    <li>
                        <a href="#services">
                            Orthodontics
                        </a>
                    </li>

                </ul>

            </div>


            <!-- Contact -->

            <div class="col-lg-3 col-md-6">

                <h5 class="footer-title">
                    Contact Us
                </h5>

                <div class="footer-contact">

                    <div>
                        <i class="bi bi-geo-alt-fill"></i>

                        <span>
                            123 Main Street,<br>
                            Colombo, Sri Lanka
                        </span>
                    </div>

                    <div>
                        <i class="bi bi-telephone-fill"></i>

                        <span>
                            +94 11 234 5678
                        </span>
                    </div>

                    <div>
                        <i class="bi bi-envelope-fill"></i>

                        <span>
                            info@sunrisedental.lk
                        </span>
                    </div>

                </div>

            </div>

        </div>


        <!-- Bottom -->

        <div class="footer-bottom">

            <p>
                © 2026 Sunrise Dental Clinic.
                All Rights Reserved.
            </p>

            <div>

                <a href="#">
                    Privacy Policy
                </a>

                <a href="#">
                    Terms & Conditions
                </a>

            </div>

        </div>

    </div>

</footer>


<!-- Back To Top -->

<a href="#" class="back-to-top">

    <i class="bi bi-arrow-up"></i>

</a>
<!-- Bootstrap -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- AOS -->

<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>

<script>
AOS.init({
    duration:1200,
    once:true
});
</script>



<script type="module" src="assets/js/hero.js"></script>
<script src="assets/js/script.js"></script>

</body>
</html>