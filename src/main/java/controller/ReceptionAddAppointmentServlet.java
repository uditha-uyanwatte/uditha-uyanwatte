package controller;

import java.io.IOException;

import dao.AppointmentDAO;
import dao.PatientDAO;
import dao.DentistDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Appointment;
import model.Patient;
import model.Dentist;
import model.User;

@WebServlet("/ReceptionAddAppointmentServlet")
public class ReceptionAddAppointmentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private AppointmentDAO appointmentDAO =
            new AppointmentDAO();

    private PatientDAO patientDAO =
            new PatientDAO();

    private DentistDAO dentistDAO =
            new DentistDAO();


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


            User loggedUser =
                    (User) session.getAttribute("user");


            // =========================
            // RECEPTIONIST CHECK
            // =========================

            if (!"RECEPTIONIST".equalsIgnoreCase(
                    loggedUser.getRole())) {

                response.sendRedirect("login.jsp");
                return;
            }


            // =========================
            // GET FORM DATA
            // =========================

            String patientParam =
                    request.getParameter("patientId");

            String dentistParam =
                    request.getParameter("dentistId");

            String treatment =
                    request.getParameter("treatment");

            String appointmentDate =
                    request.getParameter("appointmentDate");

            String appointmentTime =
                    request.getParameter("appointmentTime");

            String status =
                    request.getParameter("status");

            String notes =
                    request.getParameter("notes");


            // =========================
            // VALIDATION
            // =========================

            if (patientParam == null ||
                    dentistParam == null ||
                    treatment == null ||
                    appointmentDate == null ||
                    appointmentTime == null ||
                    status == null ||

                    patientParam.isEmpty() ||
                    dentistParam.isEmpty() ||
                    treatment.trim().isEmpty() ||
                    appointmentDate.isEmpty() ||
                    appointmentTime.isEmpty() ||
                    status.isEmpty()) {

                response.sendRedirect(
                        "reception-add-appointment.jsp?error=empty"
                );

                return;
            }


            int patientId =
                    Integer.parseInt(patientParam);

            int dentistId =
                    Integer.parseInt(dentistParam);


            // =========================
            // CHECK PATIENT
            // =========================

            Patient patient =
                    patientDAO.getPatientById(patientId);

            if (patient == null) {

                response.sendRedirect(
                        "reception-add-appointment.jsp?error=patient"
                );

                return;
            }


            // =========================
            // CHECK DENTIST
            // =========================

            Dentist dentist =
                    dentistDAO.getDentistById(dentistId);

            if (dentist == null) {

                response.sendRedirect(
                        "reception-add-appointment.jsp?error=dentist"
                );

                return;
            }


            // =========================
            // CHECK BOOKED SLOT
            // =========================

            boolean alreadyBooked =
                    appointmentDAO.isAppointmentSlotBooked(
                            dentistId,
                            appointmentDate,
                            appointmentTime
                    );

            if (alreadyBooked) {

                response.sendRedirect(
                        "reception-add-appointment.jsp?error=booked"
                );

                return;
            }


            // =========================
            // CREATE APPOINTMENT
            // =========================

            Appointment appointment =
                    new Appointment();

            appointment.setPatientId(patientId);

            appointment.setDentistId(dentistId);

            appointment.setTreatment(
                    treatment.trim()
            );

            appointment.setAppointmentDate(
                    appointmentDate
            );

            appointment.setAppointmentTime(
                    appointmentTime
            );

            appointment.setStatus(
                    status
            );

            appointment.setNotes(
                    notes != null ? notes.trim() : ""
            );


            // =========================
            // SAVE APPOINTMENT
            // =========================

            boolean success =
                    appointmentDAO.addAppointment(
                            appointment
                    );


            // =========================
            // RESULT
            // =========================

            if (success) {

                response.sendRedirect(
                        "ReceptionAppointmentServlet?success=1"
                );

            } else {

                response.sendRedirect(
                        "reception-add-appointment.jsp?error=failed"
                );
            }


        } catch (NumberFormatException e) {

            e.printStackTrace();

            response.sendRedirect(
                    "reception-add-appointment.jsp?error=invalid"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "reception-add-appointment.jsp?error=failed"
            );
        }
    }
}