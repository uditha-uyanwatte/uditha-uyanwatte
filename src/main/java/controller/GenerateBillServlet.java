package controller;

import java.io.IOException;
import java.time.LocalDate;

import dao.AppointmentDAO;
import dao.BillingDAO;
import dao.ServiceDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Appointment;
import model.Billing;
import model.Service;

@WebServlet("/GenerateBillServlet")
public class GenerateBillServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private AppointmentDAO appointmentDAO =
            new AppointmentDAO();

    private ServiceDAO serviceDAO =
            new ServiceDAO();

    private BillingDAO billingDAO =
            new BillingDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // =========================
            // GET APPOINTMENT ID
            // =========================

            int appointmentId =
                    Integer.parseInt(
                            request.getParameter(
                                    "appointmentId"
                            )
                    );

            // =========================
            // GET APPOINTMENT
            // =========================

            Appointment appointment =
                    appointmentDAO
                            .getAppointmentById(
                                    appointmentId
                            );

            if (appointment == null) {

                response.sendRedirect(
                        "appointment-details.jsp"
                );

                return;
            }

            // =========================
            // CHECK EXISTING BILL
            // =========================

            Billing existingBill =
                    billingDAO
                            .getBillByAppointmentId(
                                    appointmentId
                            );

            if (existingBill != null) {

                response.sendRedirect(
                        "BillDetailsServlet?billId="
                        + existingBill.getBillId()
                );

                return;
            }

            // =========================
            // FIND SERVICE BY NAME
            // =========================

            Service selectedService = null;

            for (Service service :
                    serviceDAO.getAllServices()) {

                if (service.getServiceName()
                        .equalsIgnoreCase(
                                appointment.getTreatment()
                        )) {

                    selectedService = service;

                    break;
                }
            }

            // =========================
            // SERVICE NOT FOUND
            // =========================

            if (selectedService == null) {

                request.setAttribute(
                        "error",
                        "Service not found for this appointment."
                );

                request.getRequestDispatcher(
                        "appointment-details.jsp"
                ).forward(
                        request,
                        response
                );

                return;
            }

            // =========================
            // CALCULATE BILL
            // =========================

            double servicePrice =
                    selectedService.getPrice();

            double consultationFee =
                    2000.00;

            double totalAmount =
                    servicePrice
                    + consultationFee;

            // =========================
            // CREATE BILL
            // =========================

            Billing bill =
                    new Billing();

            bill.setAppointmentId(
                    appointment.getAppointmentId()
            );

            bill.setPatientId(
                    appointment.getPatientId()
            );

            bill.setTreatmentId(
                    selectedService.getServiceId()
            );

            bill.setAmount(
                    totalAmount
            );

            bill.setPaymentStatus(
                    "Pending"
            );

            bill.setPaymentDate(
                    LocalDate.now().toString()
            );

            // =========================
            // SAVE BILL
            // =========================

            boolean success =
                    billingDAO.addBill(
                            bill
                    );

            if (success) {

                Billing savedBill =
                        billingDAO
                                .getBillByAppointmentId(
                                        appointmentId
                                );

                response.sendRedirect(
                        "BillDetailsServlet?billId="
                        + savedBill.getBillId()
                );

            } else {

                request.setAttribute(
                        "error",
                        "Bill generation failed."
                );

                request.getRequestDispatcher(
                        "appointment-details.jsp"
                ).forward(
                        request,
                        response
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "error",
                    "Something went wrong while generating the bill."
            );

            request.getRequestDispatcher(
                    "appointment-details.jsp"
            ).forward(
                    request,
                    response
            );
        }
    }
}