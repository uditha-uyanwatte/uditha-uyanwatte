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

@WebServlet("/AppointmentServlet")
public class AppointmentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    AppointmentDAO dao = new AppointmentDAO();
    PatientDashboardDAO patientDashboardDAO =
            new PatientDashboardDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action =
                request.getParameter("action");


        // =====================================================
        // ADMIN / RECEPTIONIST - DELETE APPOINTMENT
        // =====================================================

        if ("delete".equals(action)) {

            int id =
                    Integer.parseInt(
                            request.getParameter("id")
                    );

            dao.deleteAppointment(id);

            response.sendRedirect(
                    "appointments.jsp?deleted=true"
            );

            return;
        }


        // =====================================================
        // PATIENT - CANCEL APPOINTMENT
        // =====================================================

        if ("patientCancel".equals(action)) {

            HttpSession session =
                    request.getSession(false);


            // Check login

            if (session == null ||
                session.getAttribute("user") == null) {

                response.sendRedirect("login.jsp");

                return;
            }


            // Get logged-in user

            User user =
                    (User) session.getAttribute("user");


            // Get patient ID

            int patientId =
                    patientDashboardDAO
                            .getPatientIdByUserId(
                                    user.getId()
                            );


            // Get appointment ID

            int appointmentId =
                    Integer.parseInt(
                            request.getParameter("id")
                    );


            // Cancel only patient's own appointment

            boolean success =
                    patientDashboardDAO
                            .cancelAppointment(
                                    appointmentId,
                                    patientId
                            );


            if (success) {

                response.sendRedirect(
                        "my-appointments.jsp?cancelled=true"
                );

            } else {

                response.sendRedirect(
                        "my-appointments.jsp?error=cancel"
                );
            }

            return;
        }
    


        // =====================================================
        // ADMIN / RECEPTIONIST - ADD APPOINTMENT
        // =====================================================

        if ("add".equals(action)) {

            Appointment a = new Appointment();

            a.setPatientId(
                    Integer.parseInt(
                            request.getParameter("patientId")
                    )
            );

            a.setDentistId(
                    Integer.parseInt(
                            request.getParameter("dentistId")
                    )
            );

            a.setAppointmentDate(
                    request.getParameter("appointmentDate")
            );

            a.setAppointmentTime(
                    request.getParameter("appointmentTime")
            );

            a.setTreatment(
                    request.getParameter("treatment")
            );

            a.setStatus(
                    request.getParameter("status")
            );

            a.setNotes(
                    request.getParameter("notes")
            );

            boolean success =
                    dao.addAppointment(a);

            if (success) {

                response.sendRedirect(
                        "appointments.jsp?success=true"
                );

            } else {

                response.sendRedirect(
                        "appointments.jsp?error=true"
                );
            }

            return;
        }


        // =====================================================
        // PATIENT - ADD APPOINTMENT
        // =====================================================

        if ("patientAdd".equals(action)) {

            HttpSession session =
                    request.getSession(false);

            if (session == null ||
                session.getAttribute("user") == null) {

                response.sendRedirect("login.jsp");

                return;
            }


            User user =
                    (User) session.getAttribute("user");


            // Get patient ID from logged-in user

            int patientId =
                    patientDashboardDAO
                            .getPatientIdByUserId(
                                    user.getId()
                            );


            if (patientId <= 0) {

                response.sendRedirect(
                        "appointment.jsp?error=patient"
                );

                return;
            }


            Appointment a =
                    new Appointment();


            // IMPORTANT:
            // Patient ID comes from session/database.
            // NOT from the form.

            a.setPatientId(patientId);


            a.setDentistId(
                    Integer.parseInt(
                            request.getParameter(
                                    "dentistId"
                            )
                    )
            );


            a.setAppointmentDate(
                    request.getParameter(
                            "appointmentDate"
                    )
            );


            a.setAppointmentTime(
                    request.getParameter(
                            "appointmentTime"
                    )
            );


            a.setTreatment(
                    request.getParameter(
                            "treatment"
                    )
            );


            // Patient appointments start as Pending

            a.setStatus("Pending");


            a.setNotes(
                    request.getParameter(
                            "notes"
                    )
            );


            boolean success =
                    dao.addAppointment(a);


            if (success) {

                response.sendRedirect(
                        "user-dashboard.jsp?appointment=success"
                );

            } else {

                response.sendRedirect(
                        "appointment.jsp?error=failed"
                );
            }

            return;
        }


        // =====================================================
        // UPDATE APPOINTMENT
        // =====================================================

        if ("update".equals(action)) {

            Appointment a =
                    new Appointment();


            a.setAppointmentId(
                    Integer.parseInt(
                            request.getParameter(
                                    "appointmentId"
                            )
                    )
            );


            a.setPatientId(
                    Integer.parseInt(
                            request.getParameter(
                                    "patientId"
                            )
                    )
            );


            a.setDentistId(
                    Integer.parseInt(
                            request.getParameter(
                                    "dentistId"
                            )
                    )
            );


            a.setAppointmentDate(
                    request.getParameter(
                            "appointmentDate"
                    )
            );


            a.setAppointmentTime(
                    request.getParameter(
                            "appointmentTime"
                    )
            );


            a.setTreatment(
                    request.getParameter(
                            "treatment"
                    )
            );


            a.setStatus(
                    request.getParameter(
                            "status"
                    )
            );


            a.setNotes(
                    request.getParameter(
                            "notes"
                    )
            );


            dao.updateAppointment(a);


            response.sendRedirect(
                    "appointments.jsp?updated=true"
            );

            return;
        }
    }



    
}

