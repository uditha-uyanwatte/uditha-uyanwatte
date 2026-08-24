package controller;

import java.io.IOException;

import dao.AppointmentDAO;
import dao.BillingDAO;
import dao.DentistDAO;
import dao.PatientDAO;
import dao.TreatmentDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Appointment;
import model.Billing;
import model.Dentist;
import model.Patient;
import model.Treatment;
import model.User;

@WebServlet("/ReceptionAddAppointmentServlet")
public class ReceptionAddAppointmentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;


    private AppointmentDAO appointmentDAO =
            new AppointmentDAO();

    private PatientDAO patientDAO =
            new PatientDAO();

    private DentistDAO dentistDAO =
            new DentistDAO();

    private TreatmentDAO treatmentDAO =
            new TreatmentDAO();

    private BillingDAO billingDAO =
            new BillingDAO();


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // =========================================
            // LOGIN CHECK
            // =========================================

            HttpSession session =
                    request.getSession(false);

            if (session == null ||
                    session.getAttribute("user") == null) {

                response.sendRedirect("login.jsp");

                return;
            }


            User loggedUser =
                    (User) session.getAttribute("user");


            // =========================================
            // RECEPTIONIST CHECK
            // =========================================

            if (!"RECEPTIONIST".equalsIgnoreCase(
                    loggedUser.getRole())) {

                response.sendRedirect("login.jsp");

                return;
            }


            // =========================================
            // GET FORM DATA
            // =========================================

            String patientParam =
                    request.getParameter("patientId");

            String dentistParam =
                    request.getParameter("dentistId");

            String treatmentIdParam =
                    request.getParameter("treatmentId");

            String treatment =
                    request.getParameter("treatment");

            String amountParam =
                    request.getParameter("amount");

            String appointmentDate =
                    request.getParameter("appointmentDate");

            String appointmentTime =
                    request.getParameter("appointmentTime");

            String status =
                    request.getParameter("status");

            String notes =
                    request.getParameter("notes");


            // =========================================
            // VALIDATION
            // =========================================

            if (patientParam == null ||
                    dentistParam == null ||
                    treatmentIdParam == null ||
                    treatment == null ||
                    amountParam == null ||
                    appointmentDate == null ||
                    appointmentTime == null ||
                    status == null ||

                    patientParam.isEmpty() ||
                    dentistParam.isEmpty() ||
                    treatmentIdParam.isEmpty() ||
                    treatment.trim().isEmpty() ||
                    amountParam.isEmpty() ||
                    appointmentDate.isEmpty() ||
                    appointmentTime.isEmpty() ||
                    status.isEmpty()) {

                response.sendRedirect(
                        "reception-add-appointment.jsp?error=empty"
                );

                return;
            }


            int patientId =
                    Integer.parseInt(patientParam);

            int dentistId =
                    Integer.parseInt(dentistParam);

            int treatmentId =
                    Integer.parseInt(treatmentIdParam);

            double amount =
                    Double.parseDouble(amountParam);


            // =========================================
            // AMOUNT VALIDATION
            // =========================================

            if (amount <= 0) {

                response.sendRedirect(
                        "reception-add-appointment.jsp?error=amount"
                );

                return;
            }


            // =========================================
            // CHECK PATIENT
            // =========================================

            Patient patient =
                    patientDAO.getPatientById(patientId);

            if (patient == null) {

                response.sendRedirect(
                        "reception-add-appointment.jsp?error=patient"
                );

                return;
            }


            // =========================================
            // CHECK DENTIST
            // =========================================

            Dentist dentist =
                    dentistDAO.getDentistById(dentistId);

            if (dentist == null) {

                response.sendRedirect(
                        "reception-add-appointment.jsp?error=dentist"
                );

                return;
            }


            // =========================================
            // CHECK TREATMENT
            // =========================================

            Treatment selectedTreatment =
                    treatmentDAO.getTreatmentById(
                            treatmentId
                    );

            if (selectedTreatment == null) {

                response.sendRedirect(
                        "reception-add-appointment.jsp?error=treatment"
                );

                return;
            }


            // =========================================
            // USE DATABASE TREATMENT NAME
            // =========================================

            treatment =
                    selectedTreatment
                            .getTreatmentName();


            // =========================================
            // CHECK BOOKED SLOT
            // =========================================

            boolean alreadyBooked =
                    appointmentDAO.isAppointmentSlotBooked(
                            dentistId,
                            appointmentDate,
                            appointmentTime
                    );

            if (alreadyBooked) {

                response.sendRedirect(
                        "reception-add-appointment.jsp?error=booked"
                );

                return;
            }


            // =========================================
            // CREATE APPOINTMENT
            // =========================================

            Appointment appointment =
                    new Appointment();

            appointment.setPatientId(patientId);

            appointment.setDentistId(dentistId);

            appointment.setTreatment(
                    treatment.trim()
            );

            appointment.setAppointmentDate(
                    appointmentDate
            );

            appointment.setAppointmentTime(
                    appointmentTime
            );

            appointment.setStatus(
                    status
            );

            appointment.setNotes(
                    notes != null
                            ? notes.trim()
                            : ""
            );


            // =========================================
            // SAVE APPOINTMENT
            // =========================================

            boolean appointmentSuccess =
                    appointmentDAO.addAppointment(
                            appointment
                    );


            if (!appointmentSuccess) {

                response.sendRedirect(
                        "reception-add-appointment.jsp?error=failed"
                );

                return;
            }


            // =========================================
            // GET NEWLY CREATED APPOINTMENT
            // =========================================
            //
            // IMPORTANT:
            // Your AppointmentDAO should set the
            // generated appointment ID into the object.
            //
            // After addAppointment(), we use:
            //
            // appointment.getAppointmentId()
            //
            // =========================================

            int appointmentId =
                    appointment.getAppointmentId();


            // =========================================
            // CREATE BILL AUTOMATICALLY
            // =========================================

            Billing bill =
                    new Billing();

            bill.setAppointmentId(
                    appointmentId
            );

            bill.setPatientId(
                    patientId
            );

            bill.setTreatmentId(
                    treatmentId
            );

            // Use treatment price from database
            // instead of trusting hidden form value

            bill.setAmount(
                    selectedTreatment.getCost()
            );

            bill.setPaymentStatus(
                    "Pending"
            );

            bill.setPaymentDate(
                    appointmentDate
            );


            // =========================================
            // SAVE BILL
            // =========================================

            boolean billingSuccess =
                    billingDAO.addBill(
                            bill
                    );


            // =========================================
            // RESULT
            // =========================================

            if (billingSuccess) {

                response.sendRedirect(
                        "receptionBilling.jsp?success=appointment_bill_created"
                );

            } else {

                response.sendRedirect(
                        "receptionBilling.jsp?warning=appointment_created_bill_failed"
                );

            }


        } catch (NumberFormatException e) {

            e.printStackTrace();

            response.sendRedirect(
                    "reception-add-appointment.jsp?error=invalid"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "reception-add-appointment.jsp?error=failed"
            );

        }

    }

}