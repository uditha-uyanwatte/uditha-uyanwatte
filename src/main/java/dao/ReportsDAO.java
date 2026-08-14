package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.Map;
import java.util.LinkedHashMap;

import model.Report;
import util.DBConnection;

public class ReportsDAO {

    private Connection conn;

    public ReportsDAO() {
        conn = DBConnection.getConnection();
    }

    public Report getDashboardReport() {

        Report report = new Report();

        try {

            // ==========================
            // Total Patients
            // ==========================
            PreparedStatement ps = conn.prepareStatement(
                    "SELECT COUNT(*) FROM patients");
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                report.setTotalPatients(rs.getInt(1));
            }

            rs.close();
            ps.close();

            // ==========================
            // Total Appointments
            // ==========================
            ps = conn.prepareStatement(
                    "SELECT COUNT(*) FROM appointments");
            rs = ps.executeQuery();

            if (rs.next()) {
                report.setTotalAppointments(rs.getInt(1));
            }

            rs.close();
            ps.close();

            // ==========================
            // Total Treatments
            // ==========================
            ps = conn.prepareStatement(
                    "SELECT COUNT(*) FROM treatments");
            rs = ps.executeQuery();

            if (rs.next()) {
                report.setTotalTreatments(rs.getInt(1));
            }

            rs.close();
            ps.close();

            // ==========================
            // Paid Bills
            // ==========================
            ps = conn.prepareStatement(
                    "SELECT COUNT(*) FROM billing WHERE payment_status='Paid'");
            rs = ps.executeQuery();

            if (rs.next()) {
                report.setPaidBills(rs.getInt(1));
            }

            rs.close();
            ps.close();

            // ==========================
            // Pending Bills
            // ==========================
            ps = conn.prepareStatement(
                    "SELECT COUNT(*) FROM billing WHERE payment_status='Pending'");
            rs = ps.executeQuery();

            if (rs.next()) {
                report.setPendingBills(rs.getInt(1));
            }

            rs.close();
            ps.close();

            // ==========================
            // Total Revenue
            // ==========================
            ps = conn.prepareStatement(
                    "SELECT IFNULL(SUM(amount),0) FROM billing WHERE payment_status='Paid'");
            rs = ps.executeQuery();

            if (rs.next()) {
                report.setTotalRevenue(rs.getDouble(1));
            }

            rs.close();
            ps.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return report;
    }
    
    public Report getDashboardReport(String fromDate, String toDate) {

        Report report = new Report();

        try {

            PreparedStatement ps;
            ResultSet rs;

            // Appointments
            ps = conn.prepareStatement(
                "SELECT COUNT(*) FROM appointments WHERE appointment_date BETWEEN ? AND ?"
            );
            ps.setString(1, fromDate);
            ps.setString(2, toDate);

            rs = ps.executeQuery();
            if (rs.next()) {
                report.setTotalAppointments(rs.getInt(1));
            }

            rs.close();
            ps.close();

            // Revenue
            ps = conn.prepareStatement(
                "SELECT IFNULL(SUM(amount),0) FROM billing WHERE payment_status='Paid' AND payment_date BETWEEN ? AND ?"
            );
            ps.setString(1, fromDate);
            ps.setString(2, toDate);

            rs = ps.executeQuery();
            if (rs.next()) {
                report.setTotalRevenue(rs.getDouble(1));
            }

            rs.close();
            ps.close();

            // Patients (overall)
            ps = conn.prepareStatement("SELECT COUNT(*) FROM patients");
            rs = ps.executeQuery();

            if (rs.next()) {
                report.setTotalPatients(rs.getInt(1));
            }

            rs.close();
            ps.close();

            // Treatments (overall)
            ps = conn.prepareStatement("SELECT COUNT(*) FROM treatments");
            rs = ps.executeQuery();

            if (rs.next()) {
                report.setTotalTreatments(rs.getInt(1));
            }

            rs.close();
            ps.close();

            // Paid Bills (filtered)
            ps = conn.prepareStatement(
                "SELECT COUNT(*) FROM billing WHERE payment_status='Paid' AND payment_date BETWEEN ? AND ?"
            );
            ps.setString(1, fromDate);
            ps.setString(2, toDate);

            rs = ps.executeQuery();
            if (rs.next()) {
                report.setPaidBills(rs.getInt(1));
            }

            rs.close();
            ps.close();

            // Pending Bills (filtered)
            ps = conn.prepareStatement(
                "SELECT COUNT(*) FROM billing WHERE payment_status='Pending' AND payment_date BETWEEN ? AND ?"
            );
            ps.setString(1, fromDate);
            ps.setString(2, toDate);

            rs = ps.executeQuery();
            if (rs.next()) {
                report.setPendingBills(rs.getInt(1));
            }

            rs.close();
            ps.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return report;
    }
    
    public Map<String, Double> getMonthlyRevenue() {

        Map<String, Double> revenue = new LinkedHashMap<>();

        try {

            String sql = "SELECT MONTHNAME(payment_date) AS month, "
                    + "SUM(amount) AS total "
                    + "FROM billing "
                    + "WHERE payment_status='Paid' "
                    + "AND payment_date IS NOT NULL "
                    + "GROUP BY MONTH(payment_date), MONTHNAME(payment_date) "
                    + "ORDER BY MONTH(payment_date)";

            PreparedStatement ps = conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                revenue.put(
                        rs.getString("month"),
                        rs.getDouble("total"));

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return revenue;

    }
    public Map<String, Integer> getAppointmentStatusCount() {

        Map<String, Integer> status = new LinkedHashMap<>();

        try {

            String sql =
                    "SELECT status, COUNT(*) total "
                  + "FROM appointments "
                  + "GROUP BY status";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()){

                status.put(

                        rs.getString("status"),

                        rs.getInt("total")

                );

            }

        } catch(Exception e){

            e.printStackTrace();

        }

        return status;

    }
    public Map<String, Double> getMonthlyRevenue(String fromDate, String toDate) {

        Map<String, Double> revenue = new LinkedHashMap<>();

        try {

            String sql =
                    "SELECT MONTHNAME(payment_date) AS month, " +
                    "SUM(amount) AS total " +
                    "FROM billing " +
                    "WHERE payment_status='Paid' " +
                    "AND payment_date BETWEEN ? AND ? " +
                    "GROUP BY MONTH(payment_date), MONTHNAME(payment_date) " +
                    "ORDER BY MONTH(payment_date)";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, fromDate);
            ps.setString(2, toDate);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                revenue.put(
                        rs.getString("month"),
                        rs.getDouble("total"));

            }

            rs.close();
            ps.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return revenue;
    }
    public Map<String, Integer> getAppointmentStatusCount(String fromDate, String toDate) {

        Map<String, Integer> status = new LinkedHashMap<>();

        try {

            String sql =
                    "SELECT status, COUNT(*) total " +
                    "FROM appointments " +
                    "WHERE appointment_date BETWEEN ? AND ? " +
                    "GROUP BY status";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, fromDate);
            ps.setString(2, toDate);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                status.put(
                        rs.getString("status"),
                        rs.getInt("total"));

            }

            rs.close();
            ps.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return status;
    }
}