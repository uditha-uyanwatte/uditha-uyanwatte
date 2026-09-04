package controller;

import java.io.IOException;

import dao.PatientDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Patient;

@WebServlet("/AddPatientServlet")
public class AddPatientServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private PatientDAO dao = new PatientDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Patient patient = new Patient();

        patient.setFirstName(request.getParameter("firstName"));
        patient.setLastName(request.getParameter("lastName"));
        patient.setGender(request.getParameter("gender"));
        patient.setDateOfBirth(request.getParameter("dateOfBirth"));
        patient.setPhone(request.getParameter("phone"));
        patient.setEmail(request.getParameter("email"));
        patient.setAddress(request.getParameter("address"));

        boolean status = dao.addPatient(patient);
        if (status) {
            response.sendRedirect("receptionPatients.jsp?message=Patient registered successfully");
        } else {
            response.sendRedirect("receptionPatients.jsp?error=Failed to register patient");
        }
    }
}