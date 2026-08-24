package controller;

import java.io.IOException;

import dao.AppointmentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ReceptionAppointmentServlet")
public class ReceptionAppointmentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    AppointmentDAO appointmentDAO = new AppointmentDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute(
            "appointments",
            appointmentDAO.getAllAppointments()
        );

        request.getRequestDispatcher("receptionAppointments.jsp")
               .forward(request, response);
    }
}