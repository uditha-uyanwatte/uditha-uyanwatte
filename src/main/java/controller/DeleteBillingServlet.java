package controller;

import java.io.IOException;

import dao.BillingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteBillingServlet")
public class DeleteBillingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    BillingDAO dao = new BillingDAO();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        dao.deleteBill(id);

        response.sendRedirect("billing.jsp?deleted=1");
    }
}