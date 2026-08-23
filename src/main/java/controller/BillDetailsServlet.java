package controller;

import java.io.IOException;

import dao.BillingDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Billing;

@WebServlet("/BillDetailsServlet")
public class BillDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private BillingDAO billingDAO =
            new BillingDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // =========================
            // GET BILL ID
            // =========================

            String billIdParam =
                    request.getParameter("billId");

            if (billIdParam == null ||
                    billIdParam.isEmpty()) {

                response.sendRedirect(
                        "appointments.jsp"
                );

                return;
            }

            int billId =
                    Integer.parseInt(
                            billIdParam
                    );

            // =========================
            // GET BILL DETAILS
            // =========================

            Billing bill =
                    billingDAO.getBillById(
                            billId
                    );

            if (bill == null) {

                request.setAttribute(
                        "error",
                        "Bill not found."
                );

                request.getRequestDispatcher(
                        "appointments.jsp"
                ).forward(
                        request,
                        response
                );

                return;
            }

            // =========================
            // SEND BILL TO JSP
            // =========================

            request.setAttribute(
                    "bill",
                    bill
            );

            // =========================
            // OPEN BILL PAGE
            // =========================

            request.getRequestDispatcher(
                    "bill-details.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "appointments.jsp"
            );
        }
    }
}