package controller;

import java.io.IOException;

import dao.BillingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Billing;

@WebServlet("/UpdateBillingServlet")
public class UpdateBillingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private BillingDAO dao =
            new BillingDAO();

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int billId =
                Integer.parseInt(
                        request.getParameter("billId")
                );

        int patientId =
                Integer.parseInt(
                        request.getParameter("patientId")
                );

        int treatmentId =
                Integer.parseInt(
                        request.getParameter("treatmentId")
                );

        double amount =
                Double.parseDouble(
                        request.getParameter("amount")
                );

        String paymentStatus =
                request.getParameter("paymentStatus");

        String paymentDate =
                request.getParameter("paymentDate");

        Billing bill =
                new Billing();

        bill.setBillId(billId);

        bill.setPatientId(patientId);

        bill.setTreatmentId(treatmentId);

        bill.setAmount(amount);

        bill.setPaymentStatus(paymentStatus);

        bill.setPaymentDate(paymentDate);

        boolean updated =
                dao.updateBill(bill);

        if (updated) {

            response.sendRedirect(
                    "billing.jsp?updated=1"
            );

        } else {

            response.sendRedirect(
                    "billing.jsp?updated=0"
            );
        }
    }
}