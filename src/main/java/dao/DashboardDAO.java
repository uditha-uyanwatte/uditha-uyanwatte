package dao;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;


import java.util.LinkedHashMap;
import java.util.Map;
import util.DBConnection;

public class DashboardDAO {

    public int getPatientCount() {

        int count = 0;

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement("SELECT COUNT(*) FROM patients");

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public int getDentistCount() {

        int count = 0;

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement("SELECT COUNT(*) FROM dentists");

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public int getAppointmentCount() {

        int count = 0;

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement("SELECT COUNT(*) FROM appointments");

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public int getTreatmentCount() {

        int count = 0;

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement("SELECT COUNT(*) FROM treatments");

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public int getBillingCount() {

        int count = 0;

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement("SELECT COUNT(*) FROM billing");

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public double getTotalRevenue() {

        double total = 0;

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                        "SELECT IFNULL(SUM(amount),0) FROM billing WHERE payment_status='Paid'");

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                total = rs.getDouble(1);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }
    public Map<String, Double> getMonthlyRevenue() {

        Map<String, Double> data = new LinkedHashMap<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql =
            		"SELECT MONTHNAME(payment_date) AS month, " +
            		"SUM(amount) AS total " +
            		"FROM billing " +
            		"WHERE payment_status='Paid' " +
            		"AND payment_date IS NOT NULL " +
            		"GROUP BY MONTH(payment_date), MONTHNAME(payment_date) " +
            		"ORDER BY MONTH(payment_date)";
            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){

                data.put(
                    rs.getString("month"),
                    rs.getDouble("total")
                );

            }

            rs.close();
            ps.close();
            con.close();

        }catch(Exception e){
            e.printStackTrace();
        }

        return data;
    }
    public Map<String,Integer> getAppointmentStatusCount(){

        Map<String,Integer> data = new LinkedHashMap<>();

        try{

            Connection con = DBConnection.getConnection();

            String sql =
                "SELECT status,COUNT(*) total " +
                "FROM appointments " +
                "GROUP BY status";

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){

                data.put(
                    rs.getString("status"),
                    rs.getInt("total")
                );

            }

            rs.close();
            ps.close();
            con.close();

        }catch(Exception e){
            e.printStackTrace();
        }

        return data;
    }
}