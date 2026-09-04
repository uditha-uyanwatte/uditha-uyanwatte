<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>Help & Support</title>

<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet">

<link
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
    rel="stylesheet">

<style>

body {
    background: #f4f6f9;
    font-family: Arial, sans-serif;
}

.help-container {
    max-width: 1100px;
    margin: 40px auto;
}

.page-header {
    background: linear-gradient(135deg, #1e88e5, #1565c0);
    color: white;
    padding: 30px;
    border-radius: 16px;
    margin-bottom: 30px;
}

.help-card {
    background: white;
    border: none;
    border-radius: 15px;
    padding: 25px;
    height: 100%;
    box-shadow: 0 5px 20px rgba(0,0,0,0.08);
    transition: 0.3s;
}

.help-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 25px rgba(0,0,0,0.12);
}

.help-icon {
    width: 55px;
    height: 55px;
    border-radius: 50%;
    background: #e3f2fd;
    color: #1565c0;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 25px;
    margin-bottom: 15px;
}

.faq-box {
    background: white;
    padding: 25px;
    border-radius: 15px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.08);
}

.contact-box {
    background: linear-gradient(#1e88e5, #1565c0, #1e88e5);
    color: white;
    padding: 30px;
    border-radius: 15px;
}

</style>

</head>

<body>

<div class="container help-container">

    <!-- HEADER -->

    <div class="page-header">

        <h2>
            <i class="bi bi-question-circle-fill"></i>
            Help & Support
        </h2>

        <p class="mb-0">
            Find helpful information about using the
            Sunrise Dental Clinic Management System.
        </p>

    </div>


    <!-- HELP GUIDES -->

    <div class="row g-4">


        <!-- BOOK APPOINTMENT -->

        <div class="col-md-4">

            <div class="help-card">

                <div class="help-icon">

                    <i class="bi bi-calendar-plus"></i>

                </div>

                <h5>Book Appointment</h5>

                <p class="text-muted">

                    Select a patient and dentist,
                    choose the appointment date and
                    time, then confirm the booking.

                </p>

            </div>

        </div>


        <!-- MANAGE PATIENTS -->

        <div class="col-md-4">

            <div class="help-card">

                <div class="help-icon">

                    <i class="bi bi-people-fill"></i>

                </div>

                <h5>Manage Patients</h5>

                <p class="text-muted">

                    View patient information and
                    manage patient records through
                    the patient management section.

                </p>

            </div>

        </div>


        <!-- VIEW DENTISTS -->

        <div class="col-md-4">

            <div class="help-card">

                <div class="help-icon">

                    <i class="bi bi-person-badge-fill"></i>

                </div>

                <h5>View Dentists</h5>

                <p class="text-muted">

                    View available dentists and
                    their details before creating
                    an appointment.

                </p>

            </div>

        </div>


        <!-- BILLING -->

        <div class="col-md-4">

            <div class="help-card">

                <div class="help-icon">

                    <i class="bi bi-receipt"></i>

                </div>

                <h5>Billing</h5>

                <p class="text-muted">

                    Create and manage billing
                    records and update payment
                    information for patients.

                </p>

            </div>

        </div>


        <!-- DASHBOARD -->

        <div class="col-md-4">

            <div class="help-card">

                <div class="help-icon">

                    <i class="bi bi-speedometer2"></i>

                </div>

                <h5>Dashboard</h5>

                <p class="text-muted">

                    Use the dashboard to quickly
                    view appointment statistics
                    and recent activity.

                </p>

            </div>

        </div>


        <!-- APPOINTMENTS -->

        <div class="col-md-4">

            <div class="help-card">

                <div class="help-icon">

                    <i class="bi bi-calendar-check"></i>

                </div>

                <h5>Manage Appointments</h5>

                <p class="text-muted">

                    View, edit and manage
                    appointment information from
                    the appointment section.

                </p>

            </div>

        </div>

    </div>


    <!-- FAQ -->

    <div class="faq-box mt-5">

        <h4 class="mb-4">

            <i class="bi bi-patch-question-fill"></i>
            Frequently Asked Questions

        </h4>


        <div class="accordion"
             id="faqAccordion">


            <div class="accordion-item">

                <h2 class="accordion-header">

                    <button class="accordion-button"
                            type="button"
                            data-bs-toggle="collapse"
                            data-bs-target="#faq1">

                        How do I book an appointment?

                    </button>

                </h2>

                <div id="faq1"
                     class="accordion-collapse collapse show"
                     data-bs-parent="#faqAccordion">

                    <div class="accordion-body">

                        Go to the appointment section,
                        click Book Appointment, select
                        the patient and dentist, enter
                        the required details and submit
                        the form.

                    </div>

                </div>

            </div>


            <div class="accordion-item">

                <h2 class="accordion-header">

                    <button class="accordion-button collapsed"
                            type="button"
                            data-bs-toggle="collapse"
                            data-bs-target="#faq2">

                        What should I do if an appointment
                        time is already booked?

                    </button>

                </h2>

                <div id="faq2"
                     class="accordion-collapse collapse"
                     data-bs-parent="#faqAccordion">

                    <div class="accordion-body">

                        Select another available time
                        for the same dentist or choose
                        a different dentist.

                    </div>

                </div>

            </div>


            <div class="accordion-item">

                <h2 class="accordion-header">

                    <button class="accordion-button collapsed"
                            type="button"
                            data-bs-toggle="collapse"
                            data-bs-target="#faq3">

                        How do I create a bill?

                    </button>

                </h2>

                <div id="faq3"
                     class="accordion-collapse collapse"
                     data-bs-parent="#faqAccordion">

                    <div class="accordion-body">

                        Open the Billing section,
                        select Create Bill, choose the
                        patient and treatment, enter
                        the payment details and save.

                    </div>

                </div>

            </div>

        </div>

    </div>


    <!-- CONTACT SUPPORT -->

    <div class="contact-box mt-5 text-center">

        <h4>

            <i class="bi bi-headset"></i>
            Need More Help?

        </h4>

        <p class="mb-3">

            If you need further assistance,
            please contact the system administrator.

        </p>

        <a href="receptionDashboard.jsp"
           class="btn btn-light">

            <i class="bi bi-arrow-left"></i>
            Back to Dashboard

        </a>

    </div>

</div>


<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>