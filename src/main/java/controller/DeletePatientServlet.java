package controller;

import java.io.IOException;

import dao.PatientDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeletePatientServlet")
public class DeletePatientServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    PatientDAO dao = new PatientDAO();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        dao.deletePatient(id);

        response.sendRedirect("patients.jsp?deleted=1");
    }
}