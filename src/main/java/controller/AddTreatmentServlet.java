package controller;

import java.io.IOException;

import dao.TreatmentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Treatment;

@WebServlet("/AddTreatmentServlet")
public class AddTreatmentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    TreatmentDAO dao = new TreatmentDAO();

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Treatment treatment = new Treatment();

        treatment.setAppointmentId(
            Integer.parseInt(request.getParameter("appointmentId")));
        treatment.setTreatmentName(request.getParameter("treatmentName"));
        treatment.setDescription(request.getParameter("description"));
        treatment.setCost(
            Double.parseDouble(request.getParameter("cost")));

        dao.addTreatment(treatment);

        response.sendRedirect("treatments.jsp?success=1");
    }
}