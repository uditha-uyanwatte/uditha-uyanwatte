package model;

public class Billing {

    private int billId;

    private int appointmentId;

    private int patientId;

    private int treatmentId;

    private double amount;

    private String paymentStatus;

    private String paymentDate;

    private String patientName;

    private String treatmentName;

    public Billing() {

    }

    // =========================
    // BILL ID
    // =========================

    public int getBillId() {

        return billId;
    }

    public void setBillId(int billId) {

        this.billId = billId;
    }

    // =========================
    // APPOINTMENT ID
    // =========================

    public int getAppointmentId() {

        return appointmentId;
    }

    public void setAppointmentId(int appointmentId) {

        this.appointmentId = appointmentId;
    }

    // =========================
    // PATIENT ID
    // =========================

    public int getPatientId() {

        return patientId;
    }

    public void setPatientId(int patientId) {

        this.patientId = patientId;
    }

    // =========================
    // TREATMENT ID
    // =========================

    public int getTreatmentId() {

        return treatmentId;
    }

    public void setTreatmentId(int treatmentId) {

        this.treatmentId = treatmentId;
    }

    // =========================
    // AMOUNT
    // =========================

    public double getAmount() {

        return amount;
    }

    public void setAmount(double amount) {

        this.amount = amount;
    }

    // =========================
    // PAYMENT STATUS
    // =========================

    public String getPaymentStatus() {

        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {

        this.paymentStatus = paymentStatus;
    }

    // =========================
    // PAYMENT DATE
    // =========================

    public String getPaymentDate() {

        return paymentDate;
    }

    public void setPaymentDate(String paymentDate) {

        this.paymentDate = paymentDate;
    }

    // =========================
    // PATIENT NAME
    // =========================

    public String getPatientName() {

        return patientName;
    }

    public void setPatientName(String patientName) {

        this.patientName = patientName;
    }

    // =========================
    // TREATMENT NAME
    // =========================

    public String getTreatmentName() {

        return treatmentName;
    }

    public void setTreatmentName(String treatmentName) {

        this.treatmentName = treatmentName;
    }
}