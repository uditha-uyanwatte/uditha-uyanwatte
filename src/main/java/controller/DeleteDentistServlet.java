package controller;

import java.io.IOException;

import dao.DentistDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteDentistServlet")
public class DeleteDentistServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    DentistDAO dao = new DentistDAO();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        dao.deleteDentist(id);

        response.sendRedirect("dentists.jsp?deleted=1");
    }
}