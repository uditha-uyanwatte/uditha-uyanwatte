package controller;

import java.io.IOException;

import dao.AppointmentDAO;
import dao.DentistDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Dentist;
import model.User;

@WebServlet("/UpdateAppointmentStatusServlet")
public class UpdateAppointmentStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private AppointmentDAO appointmentDAO =
            new AppointmentDAO();

    private DentistDAO dentistDAO =
            new DentistDAO();

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            HttpSession session =
                    request.getSession(false);

            if (session == null ||
                session.getAttribute("user") == null) {

                response.sendRedirect("login.jsp");
                return;
            }

            User user =
                    (User) session.getAttribute("user");

            if (!"DENTIST".equalsIgnoreCase(
                    user.getRole())) {

                response.sendRedirect("login.jsp");
                return;
            }

            Dentist dentist =
                    dentistDAO.getDentistByUserId(
                            user.getId()
                    );

            if (dentist == null) {

                response.sendRedirect(
                        "login.jsp"
                );

                return;
            }

            int appointmentId =
                    Integer.parseInt(
                            request.getParameter(
                                    "appointmentId"
                            )
                    );

            String status =
                    request.getParameter("status");


            // Only allow valid statuses
            if (!"Confirmed".equalsIgnoreCase(status) &&
                !"Completed".equalsIgnoreCase(status) &&
                !"Cancelled".equalsIgnoreCase(status)) {

                response.sendRedirect(
                        "DentistDashboardServlet"
                );

                return;
            }


            boolean success =
                    appointmentDAO.updateAppointmentStatus(
                            appointmentId,
                            dentist.getDentistId(),
                            status
                    );


            if (success) {

                response.sendRedirect(
                        "DentistDashboardServlet?updated=success"
                );

            } else {

                response.sendRedirect(
                        "DentistDashboardServlet?updated=failed"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "DentistDashboardServlet?updated=failed"
            );
        }
    }
}