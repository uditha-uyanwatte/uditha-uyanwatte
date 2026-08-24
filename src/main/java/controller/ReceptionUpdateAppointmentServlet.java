package controller;

import java.io.IOException;

import dao.AppointmentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Appointment;

@WebServlet("/ReceptionUpdateAppointmentServlet")
public class ReceptionUpdateAppointmentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private AppointmentDAO appointmentDAO =
            new AppointmentDAO();

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // =========================
            // GET FORM DATA
            // =========================

            int appointmentId =
                    Integer.parseInt(
                            request.getParameter("appointmentId")
                    );

            String appointmentDate =
                    request.getParameter("appointmentDate");

            String appointmentTime =
                    request.getParameter("appointmentTime");

            String treatment =
                    request.getParameter("treatment");

            String status =
                    request.getParameter("status");

            String notes =
                    request.getParameter("notes");


            // =========================
            // GET EXISTING APPOINTMENT
            // =========================

            Appointment appointment =
                    appointmentDAO.getAppointmentById(
                            appointmentId
                    );


            if (appointment == null) {

                response.sendRedirect(
                        "ReceptionAppointmentServlet?error=notfound"
                );

                return;
            }


            // =========================
            // UPDATE DATA
            // =========================

            appointment.setAppointmentDate(
                    appointmentDate
            );

            appointment.setAppointmentTime(
                    appointmentTime
            );

            appointment.setTreatment(
                    treatment
            );

            appointment.setStatus(
                    status
            );

            appointment.setNotes(
                    notes
            );


            // =========================
            // SAVE TO DATABASE
            // =========================

            boolean success =
                    appointmentDAO.updateAppointment(
                            appointment
                    );


            // =========================
            // REDIRECT
            // =========================

            if (success) {

                response.sendRedirect(
                        "ReceptionAppointmentServlet?updated=1"
                );

            } else {

                response.sendRedirect(
                        "ReceptionAppointmentServlet?error=update"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "ReceptionAppointmentServlet?error=invalid"
            );
        }
    }
}