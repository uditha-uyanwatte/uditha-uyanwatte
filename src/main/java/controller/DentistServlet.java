package controller;

import java.io.IOException;

import dao.DentistDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Dentist;

@WebServlet("/DentistServlet")
public class DentistServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    DentistDAO dao = new DentistDAO();

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equals(action)) {

            Dentist d = new Dentist();

            d.setFirstName(request.getParameter("firstName"));
            d.setLastName(request.getParameter("lastName"));
            d.setSpecialization(request.getParameter("specialization"));
            d.setPhone(request.getParameter("phone"));
            d.setEmail(request.getParameter("email"));
           

            dao.addDentist(d);

            response.sendRedirect("dentists.jsp");

        } else if ("update".equals(action)) {

            Dentist d = new Dentist();

            d.setDentistId(Integer.parseInt(request.getParameter("dentistId")));
            d.setFirstName(request.getParameter("firstName"));
            d.setLastName(request.getParameter("lastName"));
            d.setSpecialization(request.getParameter("specialization"));
            d.setPhone(request.getParameter("phone"));
            d.setEmail(request.getParameter("email"));
            
            dao.updateDentist(d);

            response.sendRedirect("dentists.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("delete".equals(action)) {

            int id = Integer.parseInt(request.getParameter("id"));

            dao.deleteDentist(id);

            response.sendRedirect("dentists.jsp");
        }
    }
}