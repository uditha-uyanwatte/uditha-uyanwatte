<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="dao.AppointmentDAO"%>
<%@ page import="model.Appointment"%>

<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String id = request.getParameter("id");

    Appointment appointment = null;

    if (id != null) {

        try {

            int appointmentId =
                    Integer.parseInt(id);

            AppointmentDAO appointmentDAO =
                    new AppointmentDAO();

            appointment =
                    appointmentDAO.getAppointmentById(
                            appointmentId
                    );

        } catch (Exception e) {

            e.printStackTrace();

        }
    }
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>Edit Appointment</title>

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

.edit-box {
    max-width: 800px;
    margin: 50px auto;
    background: white;
    padding: 35px;
    border-radius: 15px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.10);
}

.page-header {
    background: linear-gradient(135deg, #1e88e5, #1565c0);
    color: white;
    padding: 20px;
    border-radius: 12px;
    margin-bottom: 30px;
}

</style>

</head>

<body>

<div class="container">

<% if (appointment != null) { %>

    <div class="edit-box">

        <!-- HEADER -->

        <div class="page-header">

            <h3 class="mb-1">

                <i class="bi bi-pencil-square"></i>
                Edit Appointment

            </h3>

            <p class="mb-0">
                Update appointment information
            </p>

        </div>


        <!-- FORM -->

        <form action="ReceptionUpdateAppointmentServlet"
              method="post">


            <!-- APPOINTMENT ID -->

            <input type="hidden"
                   name="appointmentId"
                   value="<%= appointment.getAppointmentId() %>">


            <div class="row">


                <!-- PATIENT -->

                <div class="col-md-6 mb-3">

                    <label class="form-label">

                        Patient

                    </label>

                    <input type="text"
                           class="form-control"
                           value="<%= appointment.getPatientName() != null
                                   ? appointment.getPatientName()
                                   : "Patient ID: " + appointment.getPatientId() %>"
                           readonly>

                </div>


                <!-- DENTIST -->

                <div class="col-md-6 mb-3">

                    <label class="form-label">

                        Dentist

                    </label>

                    <input type="text"
                           class="form-control"
                           value="<%= appointment.getDentistName() != null
                                   ? appointment.getDentistName()
                                   : "Dentist ID: " + appointment.getDentistId() %>"
                           readonly>

                </div>


                <!-- DATE -->

                <div class="col-md-6 mb-3">

                    <label class="form-label">

                        Appointment Date

                    </label>

                    <input type="date"
                           name="appointmentDate"
                           class="form-control"
                           value="<%= appointment.getAppointmentDate() %>"
                           required>

                </div>


                <!-- TIME -->

                <div class="col-md-6 mb-3">

                    <label class="form-label">

                        Appointment Time

                    </label>

                    <input type="time"
                           name="appointmentTime"
                           class="form-control"
                           value="<%= appointment.getAppointmentTime() %>"
                           required>

                </div>


                <!-- TREATMENT -->

                <div class="col-md-12 mb-3">

                    <label class="form-label">

                        Treatment

                    </label>

                    <input type="text"
                           name="treatment"
                           class="form-control"
                           value="<%= appointment.getTreatment() %>"
                           required>

                </div>


                <!-- STATUS -->

                <div class="col-md-12 mb-3">

                    <label class="form-label">

                        Appointment Status

                    </label>

                    <select name="status"
                            class="form-select"
                            required>

                        <option value="Pending"
                            <%= "Pending".equalsIgnoreCase(
                                    appointment.getStatus())
                                ? "selected" : "" %>>

                            Pending

                        </option>

                        <option value="Confirmed"
                            <%= "Confirmed".equalsIgnoreCase(
                                    appointment.getStatus())
                                ? "selected" : "" %>>

                            Confirmed

                        </option>

                        <option value="Completed"
                            <%= "Completed".equalsIgnoreCase(
                                    appointment.getStatus())
                                ? "selected" : "" %>>

                            Completed

                        </option>

                        <option value="Cancelled"
                            <%= "Cancelled".equalsIgnoreCase(
                                    appointment.getStatus())
                                ? "selected" : "" %>>

                            Cancelled

                        </option>

                    </select>

                </div>


                <!-- NOTES -->

                <div class="col-md-12 mb-3">

                    <label class="form-label">

                        Notes

                    </label>

                    <textarea name="notes"
                              class="form-control"
                              rows="4"><%= appointment.getNotes() != null
                                      ? appointment.getNotes()
                                      : "" %></textarea>

                </div>

            </div>


            <!-- BUTTONS -->

            <div class="mt-4">

                <a href="ReceptionAppointmentServlet"
                   class="btn btn-secondary">

                    <i class="bi bi-arrow-left"></i>
                    Cancel

                </a>

                <button type="submit"
                        class="btn btn-primary">

                    <i class="bi bi-check-circle"></i>
                    Update Appointment

                </button>

            </div>

        </form>

    </div>

<% } else { %>

    <div class="alert alert-danger mt-5">

        Appointment not found.

    </div>

    <a href="ReceptionAppointmentServlet"
       class="btn btn-secondary">

        Back

    </a>

<% } %>

</div>

</body>

</html>