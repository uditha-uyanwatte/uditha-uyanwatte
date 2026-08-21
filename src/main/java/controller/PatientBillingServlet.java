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

            int userId = user.getId();

            int patientId =
                    patientDAO.getPatientIdByUserId(userId);

            if (patientId <= 0) {

                response.sendRedirect(
                        "user-dashboard.jsp?error=patient"
                );

                return;
            }

            List<Billing> bills =
                    billingDAO.getBillsByPatientId(patientId);

            request.setAttribute("bills", bills);

            request.getRequestDispatcher(
                    "patient-billing.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "user-dashboard.jsp?error=billing"
            );
        }
    }
}