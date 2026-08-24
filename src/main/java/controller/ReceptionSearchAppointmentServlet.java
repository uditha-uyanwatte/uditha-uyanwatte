package controller;

import java.io.IOException;

import dao.AppointmentDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Appointment;
import model.User;

@WebServlet("/ReceptionSearchAppointmentServlet")
public class ReceptionSearchAppointmentServlet
        extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private AppointmentDAO appointmentDAO =
            new AppointmentDAO();

    @Override
    protected void doGet(
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
            // GET APPOINTMENT ID
            // =========================

            String idParam =
                    request.getParameter("id");


            if (idParam == null ||
                    idParam.trim().isEmpty()) {

                response.sendRedirect(
                        "search-appointment.jsp?error=invalid"
                );

                return;
            }


            int appointmentId =
                    Integer.parseInt(
                            idParam.trim()
                    );


            // =========================
            // SEARCH APPOINTMENT
            // =========================

            Appointment appointment =
                    appointmentDAO.getAppointmentById(
                            appointmentId
                    );


            // =========================
            // NOT FOUND
            // =========================

            if (appointment == null) {

                response.sendRedirect(
                        "search-appointment.jsp?error=notfound"
                );

                return;
            }


            // =========================
            // SEND DATA TO JSP
            // =========================

            request.setAttribute(
                    "appointment",
                    appointment
            );


            request.getRequestDispatcher(
                    "reception-appointment-details.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "search-appointment.jsp?error=invalid"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "search-appointment.jsp?error=invalid"
            );

        }

    }

}