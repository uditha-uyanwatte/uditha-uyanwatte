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
                request.getSession();


        // =========================
        // LOGIN CHECK
        // =========================

        User user =
                (User) session.getAttribute("user");


        if (user == null) {

            response.sendRedirect("login.jsp");
            return;
        }


        // =========================
        // GET BILL ID
        // =========================

        String billIdParameter =
                request.getParameter("billId");


        if (billIdParameter == null ||
            billIdParameter.trim().isEmpty()) {

            response.sendRedirect(
                    "PatientBillingServlet?error=invalid"
            );

            return;
        }


        int billId;

        try {

            billId =
                    Integer.parseInt(
                            billIdParameter
                    );

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "PatientBillingServlet?error=invalid"
            );

            return;
        }


        // =========================
        // GET PATIENT ID
        // =========================

        int userId =
                user.getId();


        int patientId =
                patientDAO.getPatientIdByUserId(
                        userId
                );


        // =========================
        // PAY BILL
        // =========================

        boolean success =
                billingDAO.payBill(
                        billId,
                        patientId
                );


        if (success) {

            response.sendRedirect(
                    "PatientBillingServlet?paid=1"
            );

        } else {

            response.sendRedirect(
                    "PatientBillingServlet?error=payment"
            );
        }
    }
}