package controller;

import java.io.IOException;
import java.util.List;

import dao.AppointmentDAO;
import dao.DentistDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Appointment;
import model.Dentist;
import model.User;

@WebServlet("/DentistDashboardServlet")
public class DentistDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private DentistDAO dentistDAO =
            new DentistDAO();

    private AppointmentDAO appointmentDAO =
            new AppointmentDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // LOGIN CHECK
        if (session == null ||
                session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        User user =
                (User) session.getAttribute("user");

        // DENTIST ROLE CHECK
        if (!"DENTIST".equalsIgnoreCase(
                user.getRole())) {

            response.sendRedirect("login.jsp");
            return;
        }

        // =========================
        // FIND DENTIST PROFILE
        // =========================

        Dentist dentist =
                dentistDAO.getDentistByUserId(
                        user.getId()
                );

        // =========================
        // AUTO CREATE PROFILE
        // =========================

        if (dentist == null) {

            Dentist newDentist =
                    new Dentist();

            newDentist.setUserId(
                    user.getId()
            );

            /*
             * Registered user's full name
             */
            String fullName =
                    user.getFullName();

            String firstName = fullName;
            String lastName = "";

            if (fullName != null &&
                    fullName.trim().contains(" ")) {

                String[] nameParts =
                        fullName.trim().split(
                                "\\s+",
                                2
                        );

                firstName =
                        nameParts[0];

                lastName =
                        nameParts[1];
            }

            newDentist.setFirstName(
                    firstName
            );

            newDentist.setLastName(
                    lastName
            );

            /*
             * Default dentist details
             */
            newDentist.setSpecialization(
                    "General Dentist"
            );

            newDentist.setPhone(
                    ""
            );

            newDentist.setEmail(
                    user.getUsername()
            );

            newDentist.setProfileImage(
                    "doctor-default.jpg"
            );

            boolean created =
                    dentistDAO.addDentist(
                            newDentist
                    );

            if (!created) {

                request.setAttribute(
                        "error",
                        "Unable to create dentist profile."
                );

                request.getRequestDispatcher(
                        "login.jsp"
                ).forward(
                        request,
                        response
                );

                return;
            }

            /*
             * Get newly created profile
             */
            dentist =
                    dentistDAO.getDentistByUserId(
                            user.getId()
                    );
        }

        // =========================
        // GET APPOINTMENTS
        // =========================

        List<Appointment> appointments =
                appointmentDAO
                        .getAppointmentsByDentist(
                                dentist.getDentistId()
                        );

        // =========================
        // SEND DATA TO JSP
        // =========================

        request.setAttribute(
                "dentist",
                dentist
        );

        request.setAttribute(
                "appointments",
                appointments
        );

        // =========================
        // OPEN DASHBOARD
        // =========================

        request.getRequestDispatcher(
                "dentist-dashboard.jsp"
        ).forward(
                request,
                response
        );
    }
}