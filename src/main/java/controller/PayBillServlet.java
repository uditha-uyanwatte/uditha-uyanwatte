package controller;

import java.io.IOException;

import dao.BillingDAO;
import dao.PatientDashboardDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Billing;
import model.User;

@WebServlet("/PayBillServlet")
public class PayBillServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private BillingDAO billingDAO =
            new BillingDAO();

    private PatientDashboardDAO patientDAO =
            new PatientDashboardDAO();

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        try {

            User user =
                    (User) session.getAttribute("user");

            int userId =
                    user.getId();

            int patientId =
                    patientDAO.getPatientIdByUserId(userId);

            int billId =
                    Integer.parseInt(
                            request.getParameter("billId")
                    );

            // Security check
            Billing bill =
                    billingDAO.getBillByIdAndPatient(
                            billId,
                            patientId
                    );

            if (bill == null) {

                response.sendRedirect(
                        "PatientBillingServlet?error=invalid"
                );

                return;
            }

            // Already paid
            if ("Paid".equalsIgnoreCase(
                    bill.getPaymentStatus())) {

                response.sendRedirect(
                        "PatientBillingServlet?message=alreadyPaid"
                );

                return;
            }

            boolean success =
                    billingDAO.markAsPaid(
                            billId,
                            patientId
                    );

            if (success) {

                response.sendRedirect(
                        "PatientBillingServlet?payment=success"
                );

            } else {

                response.sendRedirect(
                        "PatientBillingServlet?payment=failed"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "PatientBillingServlet?payment=failed"
            );
        }
    }
}