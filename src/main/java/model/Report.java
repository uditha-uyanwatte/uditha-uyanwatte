package model;

public class Report {

    private int totalPatients;
    private int totalAppointments;
    private int totalTreatments;
    private int paidBills;
    private int pendingBills;
    private double totalRevenue;

    public Report() {
    }

    public int getTotalPatients() {
        return totalPatients;
    }

    public void setTotalPatients(int totalPatients) {
        this.totalPatients = totalPatients;
    }

    public int getTotalAppointments() {
        return totalAppointments;
    }

    public void setTotalAppointments(int totalAppointments) {
        this.totalAppointments = totalAppointments;
    }

    public int getTotalTreatments() {
        return totalTreatments;
    }

    public void setTotalTreatments(int totalTreatments) {
        this.totalTreatments = totalTreatments;
    }

    public int getPaidBills() {
        return paidBills;
    }

    public void setPaidBills(int paidBills) {
        this.paidBills = paidBills;
    }

    public int getPendingBills() {
        return pendingBills;
    }

    public void setPendingBills(int pendingBills) {
        this.pendingBills = pendingBills;
    }

    public double getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(double totalRevenue) {
        this.totalRevenue = totalRevenue;
    }
}