package controller;

import java.io.IOException;
import java.util.List;

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

@WebServlet("/PatientBillingServlet")
public class PatientBillingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private BillingDAO billingDAO = new BillingDAO();

    private PatientDashboardDAO patientDAO =
            new PatientDashboardDAO();


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        HttpSession session = request.getSession();


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
        // GET PATIENT ID
        // =========================

        int userId = user.getId();

        int patientId =
                patientDAO.getPatientIdByUserId(userId);


        // =========================
        // GET PATIENT BILLS
        // =========================

        List<Billing> bills =
                billingDAO.getBillsByPatientId(patientId);


        // =========================
        // CALCULATE TOTALS
        // =========================

        double totalAmount = 0;

        double totalPaid = 0;

        double pendingAmount = 0;


        for (Billing bill : bills) {

            totalAmount += bill.getAmount();


            if ("Paid".equalsIgnoreCase(
                    bill.getPaymentStatus())) {

                totalPaid += bill.getAmount();

            } else {

                pendingAmount += bill.getAmount();

            }
        }


        // =========================
        // SEND DATA TO JSP
        // =========================

        request.setAttribute(
                "bills",
                bills
        );

        request.setAttribute(
                "totalAmount",
                totalAmount
        );

        request.setAttribute(
                "totalPaid",
                totalPaid
        );

        request.setAttribute(
                "pendingAmount",
                pendingAmount
        );


        request.getRequestDispatcher(
                "patient-billing.jsp"
        ).forward(request, response);
    }
}