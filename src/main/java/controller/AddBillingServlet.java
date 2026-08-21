package controller;

import java.io.IOException;

import dao.BillingDAO;
import dao.PatientDAO;
import dao.TreatmentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Billing;
import model.Patient;
import model.Treatment;
import model.User;

@WebServlet("/AddBillingServlet")
public class AddBillingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private BillingDAO billingDAO = new BillingDAO();

    private PatientDAO patientDAO = new PatientDAO();

    private TreatmentDAO treatmentDAO = new TreatmentDAO();


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // =========================
            // ADMIN LOGIN CHECK
            // =========================

            HttpSession session =
                    request.getSession(false);

            if (session == null ||
                session.getAttribute("user") == null) {

                response.sendRedirect("login.jsp");
                return;
            }

            User loggedUser =
                    (User) session.getAttribute("user");

            if (!"ADMIN".equalsIgnoreCase(
                    loggedUser.getRole())) {

                response.sendRedirect("login.jsp");
                return;
            }


            // =========================
            // GET FORM DATA
            // =========================

            String patientParam =
                    request.getParameter("patientId");

            String treatmentParam =
                    request.getParameter("treatmentId");

            String amountParam =
                    request.getParameter("amount");

            String paymentStatus =
                    request.getParameter("paymentStatus");

            String paymentDate =
                    request.getParameter("paymentDate");


            // =========================
            // BASIC VALIDATION
            // =========================

            if (patientParam == null ||
                treatmentParam == null ||
                amountParam == null ||
                paymentStatus == null ||
                paymentDate == null ||
                patientParam.isEmpty() ||
                treatmentParam.isEmpty() ||
                amountParam.isEmpty() ||
                paymentStatus.isEmpty() ||
                paymentDate.isEmpty()) {

                response.sendRedirect(
                        "billing.jsp?error=empty"
                );

                return;
            }


            int patientId =
                    Integer.parseInt(patientParam);

            int treatmentId =
                    Integer.parseInt(treatmentParam);

            double amount =
                    Double.parseDouble(amountParam);


            // =========================
            // AMOUNT VALIDATION
            // =========================

            if (amount <= 0) {

                response.sendRedirect(
                        "billing.jsp?error=amount"
                );

                return;
            }


            // =========================
            // PATIENT CHECK
            // =========================

            Patient patient =
                    patientDAO.getPatientById(
                            patientId
                    );

            if (patient == null) {

                response.sendRedirect(
                        "billing.jsp?error=patient"
                );

                return;
            }


            // =========================
            // TREATMENT CHECK
            // =========================

            Treatment treatment =
                    treatmentDAO.getTreatmentById(
                            treatmentId
                    );

            if (treatment == null) {

                response.sendRedirect(
                        "billing.jsp?error=treatment"
                );

                return;
            }


            // =========================
            // CREATE BILL
            // =========================

            Billing bill =
                    new Billing();

            bill.setPatientId(patientId);

            bill.setTreatmentId(treatmentId);

            bill.setAmount(amount);

            bill.setPaymentStatus(
                    paymentStatus
            );

            bill.setPaymentDate(
                    paymentDate
            );


            // =========================
            // SAVE BILL
            // =========================

            boolean success =
                    billingDAO.addBill(bill);


            // =========================
            // RESULT
            // =========================

            if (success) {

                response.sendRedirect(
                        "billing.jsp?success=1"
                );

            } else {

                response.sendRedirect(
                        "billing.jsp?error=failed"
                );
            }

        } catch (NumberFormatException e) {

            e.printStackTrace();

            response.sendRedirect(
                    "billing.jsp?error=invalid"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "billing.jsp?error=failed"
            );
        }
    }
}