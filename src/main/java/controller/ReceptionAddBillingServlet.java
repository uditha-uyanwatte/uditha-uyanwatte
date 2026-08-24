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

@WebServlet("/ReceptionAddBillingServlet")
public class ReceptionAddBillingServlet extends HttpServlet {

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
            // LOGIN CHECK
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


            // =========================
            // RECEPTIONIST CHECK
            // =========================

            if (!"RECEPTIONIST".equalsIgnoreCase(
                    loggedUser.getRole())) {

                response.sendRedirect(
                        "receptionBilling.jsp?error=unauthorized"
                );

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
                        "receptionBilling.jsp?error=empty"
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
                        "receptionBilling.jsp?error=amount"
                );

                return;
            }


            // =========================
            // PATIENT CHECK
            // =========================

            Patient patient =
                    patientDAO.getPatientById(patientId);

            if (patient == null) {

                response.sendRedirect(
                        "receptionBilling.jsp?error=patient"
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
                        "receptionBilling.jsp?error=treatment"
                );

                return;
            }


            // =========================
            // CREATE BILL
            // =========================

            Billing bill = new Billing();

            bill.setPatientId(patientId);

            bill.setTreatmentId(treatmentId);

            bill.setAmount(amount);

            bill.setPaymentStatus(paymentStatus);

            bill.setPaymentDate(paymentDate);


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
                        "receptionBilling.jsp?success=1"
                );

            } else {

                response.sendRedirect(
                        "receptionBilling.jsp?error=failed"
                );
            }

        } catch (NumberFormatException e) {

            e.printStackTrace();

            response.sendRedirect(
                    "receptionBilling.jsp?error=invalid"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "receptionBilling.jsp?error=failed"
            );
        }
    }
}