package model;

public class Appointment {

    private int appointmentId;
    private int patientId;
    private int dentistId;

    private String treatment;
    private String appointmentDate;
    private String appointmentTime;
    private String status;
    private String notes;

    // =========================
    // DISPLAY DETAILS
    // =========================

    private String patientName;
    private String patientPhone;
    private String patientEmail;

    private String dentistName;
    private String dentistSpecialization;


    public Appointment() {

    }


    public int getAppointmentId() {

        return appointmentId;
    }

    public void setAppointmentId(int appointmentId) {

        this.appointmentId = appointmentId;
    }


    public int getPatientId() {

        return patientId;
    }

    public void setPatientId(int patientId) {

        this.patientId = patientId;
    }


    public int getDentistId() {

        return dentistId;
    }

    public void setDentistId(int dentistId) {

        this.dentistId = dentistId;
    }


    public String getTreatment() {

        return treatment;
    }

    public void setTreatment(String treatment) {

        this.treatment = treatment;
    }


    public String getAppointmentDate() {

        return appointmentDate;
    }

    public void setAppointmentDate(String appointmentDate) {

        this.appointmentDate = appointmentDate;
    }


    public String getAppointmentTime() {

        return appointmentTime;
    }

    public void setAppointmentTime(String appointmentTime) {

        this.appointmentTime = appointmentTime;
    }


    public String getStatus() {

        return status;
    }

    public void setStatus(String status) {

        this.status = status;
    }


    public String getNotes() {

        return notes;
    }

    public void setNotes(String notes) {

        this.notes = notes;
    }


    // =========================
    // PATIENT DETAILS
    // =========================

    public String getPatientName() {

        return patientName;
    }

    public void setPatientName(String patientName) {

        this.patientName = patientName;
    }


    public String getPatientPhone() {

        return patientPhone;
    }

    public void setPatientPhone(String patientPhone) {

        this.patientPhone = patientPhone;
    }


    public String getPatientEmail() {

        return patientEmail;
    }

    public void setPatientEmail(String patientEmail) {

        this.patientEmail = patientEmail;
    }


    // =========================
    // DENTIST DETAILS
    // =========================

    public String getDentistName() {

        return dentistName;
    }

    public void setDentistName(String dentistName) {

        this.dentistName = dentistName;
    }


    public String getDentistSpecialization() {

        return dentistSpecialization;
    }

    public void setDentistSpecialization(
            String dentistSpecialization) {

        this.dentistSpecialization =
                dentistSpecialization;
    }

}