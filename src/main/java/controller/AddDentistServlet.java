package controller;

import java.io.IOException;

import dao.DentistDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Dentist;

@WebServlet("/AddDentistServlet")
public class AddDentistServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    DentistDAO dao = new DentistDAO();

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Dentist dentist = new Dentist();

        dentist.setFirstName(request.getParameter("firstName"));
        dentist.setLastName(request.getParameter("lastName"));
        dentist.setSpecialization(request.getParameter("specialization"));
        dentist.setPhone(request.getParameter("phone"));
        dentist.setEmail(request.getParameter("email"));

        dao.addDentist(dentist);

        response.sendRedirect("dentists.jsp?success=1");
    }
}