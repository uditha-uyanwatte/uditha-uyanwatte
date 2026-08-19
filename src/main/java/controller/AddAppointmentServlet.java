package controller;

import java.io.IOException;

import dao.AppointmentDAO;
import dao.PatientDashboardDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Appointment;
import model.User;

@WebServlet("/AddAppointmentServlet")
public class AddAppointmentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private AppointmentDAO appointmentDAO =
            new AppointmentDAO();

    private PatientDashboardDAO patientDAO =
            new PatientDashboardDAO();

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // =========================
            // LOGIN CHECK
            // =========================

            HttpSession session =
                    request.getSession(false);

            if (session == null ||
                session.getAttribute("user") == null) {

                response.sendRedirect("login.jsp");
                return;
            }


            // =========================
            // GET LOGGED USER
            // =========================

            User loggedUser =
                    (User) session.getAttribute("user");

            int userId =
                    loggedUser.getId();


            // =========================
            // GET ACTUAL PATIENT ID
            // =========================

            int patientId =
                    patientDAO.getPatientIdByUserId(userId);

            if (patientId <= 0) {

                response.sendRedirect(
                    "patient-appointment.jsp?error=patient"
                );

                return;
            }


            // =========================
            // CREATE APPOINTMENT
            // =========================

            Appointment appointment =
                    new Appointment();

            appointment.setPatientId(patientId);

            appointment.setDentistId(
                Integer.parseInt(
                    request.getParameter("dentistId")
                )
            );

            appointment.setAppointmentDate(
                request.getParameter("appointmentDate")
            );

            appointment.setAppointmentTime(
                request.getParameter("appointmentTime")
            );

            appointment.setStatus("Pending");

            appointment.setTreatment(
                request.getParameter("treatment")
            );

            appointment.setNotes(
                request.getParameter("notes")
            );


            // =========================
            // SAVE APPOINTMENT
            // =========================

            boolean success =
                    appointmentDAO.addAppointment(
                        appointment
                    );


            // =========================
            // REDIRECT
            // =========================

            if (success) {

                response.sendRedirect(
                    "patient-appointment.jsp?appointment=success"
                );

            } else {

                response.sendRedirect(
                    "patient-appointment.jsp?error=failed"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                "patient-appointment.jsp?error=failed"
            );
        }
    }
}