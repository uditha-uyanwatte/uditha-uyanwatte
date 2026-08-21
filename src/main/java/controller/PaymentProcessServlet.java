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

@WebServlet("/PaymentProcessServlet")
public class PaymentProcessServlet extends HttpServlet {

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


            // =========================
            // GET BILL
            // =========================

            int billId =
                    Integer.parseInt(
                            request.getParameter("billId")
                    );


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


            // =========================
            // CARD DETAILS
            // =========================

            String cardHolder =
                    request.getParameter(
                            "cardHolder"
                    );

            String cardNumber =
                    request.getParameter(
                            "cardNumber"
                    );

            String expiry =
                    request.getParameter(
                            "expiry"
                    );

            String cvv =
                    request.getParameter(
                            "cvv"
                    );


            // =========================
            // VALIDATION
            // =========================

            if (cardHolder == null ||
                cardHolder.trim().isEmpty()) {

                response.sendRedirect(
                        "PaymentServlet?billId="
                        + billId
                        + "&error=card"
                );

                return;
            }


            if (cardNumber == null ||
                !cardNumber.matches("\\d{16}")) {

                response.sendRedirect(
                        "PaymentServlet?billId="
                        + billId
                        + "&error=card"
                );

                return;
            }


            if (expiry == null ||
                !expiry.matches(
                    "(0[1-9]|1[0-2])/\\d{2}"
                )) {

                response.sendRedirect(
                        "PaymentServlet?billId="
                        + billId
                        + "&error=card"
                );

                return;
            }


            if (cvv == null ||
                !cvv.matches("\\d{3}")) {

                response.sendRedirect(
                        "PaymentServlet?billId="
                        + billId
                        + "&error=card"
                );

                return;
            }


            /*
             * IMPORTANT
             *
             * Card number and CVV are NOT stored
             * in the database.
             *
             * This is an internal assignment/demo
             * payment simulation.
             */


            // =========================
            // MARK BILL AS PAID
            // =========================

            boolean success =
                    billingDAO.markAsPaid(
                            billId,
                            patientId
                    );

            if (success) {

                response.sendRedirect(
                        "payment-success.jsp?billId="
                        + billId
                );

            } else {

                response.sendRedirect(
                        "PaymentServlet?billId="
                        + billId
                        + "&error=payment"
                );
            }


        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "PatientBillingServlet?error=payment"
            );
        }
    }
}