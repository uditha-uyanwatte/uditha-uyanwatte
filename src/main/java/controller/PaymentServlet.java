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

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private BillingDAO billingDAO =
            new BillingDAO();

    private PatientDashboardDAO patientDAO =
            new PatientDashboardDAO();


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);


        // =========================
        // LOGIN CHECK
        // =========================

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
                    patientDAO.getPatientIdByUserId(
                            userId
                    );


            String billIdParameter =
                    request.getParameter("billId");


            if (billIdParameter == null ||
                billIdParameter.trim().isEmpty()) {

                response.sendRedirect(
                        "PatientBillingServlet?error=invalid"
                );

                return;
            }


            int billId =
                    Integer.parseInt(
                            billIdParameter
                    );


            // =========================
            // SECURITY CHECK
            // =========================

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


            // =========================
            // ALREADY PAID
            // =========================

            if ("Paid".equalsIgnoreCase(
                    bill.getPaymentStatus())) {

                response.sendRedirect(
                        "PatientBillingServlet?error=alreadyPaid"
                );

                return;
            }


            request.setAttribute(
                    "bill",
                    bill
            );


            request.getRequestDispatcher(
                    "payment.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "PatientBillingServlet?error=payment"
            );
        }
    }
}