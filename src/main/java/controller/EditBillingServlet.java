package controller;

import java.io.IOException;

import dao.BillingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Billing;

@WebServlet("/EditBillingServlet")
public class EditBillingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    BillingDAO dao = new BillingDAO();

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Billing bill = new Billing();

        bill.setBillId(Integer.parseInt(request.getParameter("id")));
        bill.setPatientId(Integer.parseInt(request.getParameter("patientId")));
        bill.setTreatmentId(Integer.parseInt(request.getParameter("treatmentId")));
        bill.setAmount(Double.parseDouble(request.getParameter("amount")));
        bill.setPaymentStatus(request.getParameter("paymentStatus"));
        bill.setPaymentDate(request.getParameter("paymentDate"));

        dao.updateBill(bill);

        response.sendRedirect("billing.jsp?updated=1");
    }
}