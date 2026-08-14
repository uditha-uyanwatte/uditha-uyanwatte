package controller;

import java.io.IOException;

import dao.PatientDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Patient;

@WebServlet("/PatientServlet")
public class PatientServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    PatientDAO dao = new PatientDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equals(action)) {

            Patient patient = new Patient();

            patient.setFirstName(request.getParameter("firstName"));
            patient.setLastName(request.getParameter("lastName"));
            patient.setGender(request.getParameter("gender"));
            patient.setDateOfBirth(request.getParameter("dob"));
            patient.setPhone(request.getParameter("phone"));
            patient.setEmail(request.getParameter("email"));
            patient.setAddress(request.getParameter("address"));

            if (dao.addPatient(patient)) {
                response.sendRedirect("patients.jsp?msg=added");
            } else {
                response.sendRedirect("patients.jsp?msg=error");
            }

        } else if ("update".equals(action)) {

            Patient patient = new Patient();

            patient.setPatientId(Integer.parseInt(request.getParameter("patientId")));
            patient.setFirstName(request.getParameter("firstName"));
            patient.setLastName(request.getParameter("lastName"));
            patient.setGender(request.getParameter("gender"));
            patient.setDateOfBirth(request.getParameter("dob"));
            patient.setPhone(request.getParameter("phone"));
            patient.setEmail(request.getParameter("email"));
            patient.setAddress(request.getParameter("address"));

            if (dao.updatePatient(patient)) {
                response.sendRedirect("patients.jsp?msg=updated");
            } else {
                response.sendRedirect("patients.jsp?msg=error");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("delete".equals(action)) {

            int id = Integer.parseInt(request.getParameter("id"));

            dao.deletePatient(id);

            response.sendRedirect("patients.jsp?msg=deleted");
        }

    }

}