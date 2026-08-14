package controller;

import java.io.IOException;

import dao.TreatmentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteTreatmentServlet")
public class DeleteTreatmentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    TreatmentDAO dao = new TreatmentDAO();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        dao.deleteTreatment(id);

        response.sendRedirect("treatments.jsp?deleted=1");
    }
}