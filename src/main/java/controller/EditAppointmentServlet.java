package controller;

import java.io.IOException;

import dao.AppointmentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Appointment;

@WebServlet("/EditAppointmentServlet")
public class EditAppointmentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    AppointmentDAO dao = new AppointmentDAO();

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Appointment appointment = new Appointment();

        appointment.setAppointmentId(Integer.parseInt(request.getParameter("id")));
        appointment.setPatientId(Integer.parseInt(request.getParameter("patientId")));
        appointment.setDentistId(Integer.parseInt(request.getParameter("dentistId")));
        appointment.setAppointmentDate(request.getParameter("appointmentDate"));
        appointment.setAppointmentTime(request.getParameter("appointmentTime"));
        appointment.setStatus(request.getParameter("status"));
        appointment.setTreatment(request.getParameter("treatment"));
        appointment.setNotes(request.getParameter("notes"));

        dao.updateAppointment(appointment);

        response.sendRedirect("appointments.jsp?updated=1");
    }
}