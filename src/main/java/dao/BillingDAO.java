package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Billing;
import util.DBConnection;




public class BillingDAO {

    // Add Bill
    public boolean addBill(Billing bill) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO billing(patient_id,treatment_id,amount,payment_status,payment_date) VALUES(?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, bill.getPatientId());
            ps.setInt(2, bill.getTreatmentId());
            ps.setDouble(3, bill.getAmount());
            ps.setString(4, bill.getPaymentStatus());
            ps.setString(5, bill.getPaymentDate());

            status = ps.executeUpdate() > 0;

            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // Get All Bills
    public List<Billing> getAllBills() {

        List<Billing> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql =
            		"SELECT b.bill_id, b.patient_id, b.treatment_id, " +
            		"p.first_name, p.last_name, " +
            		"t.treatment_name, " +
            		"b.amount, b.payment_status, b.payment_date " +
            		"FROM billing b " +
            		"JOIN patients p ON b.patient_id = p.patient_id " +
            		"JOIN treatments t ON b.treatment_id = t.treatment_id " +
            		"ORDER BY b.bill_id DESC";
            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Billing bill = new Billing();

                bill.setBillId(rs.getInt("bill_id"));
                bill.setPatientId(rs.getInt("patient_id"));
                bill.setTreatmentId(rs.getInt("treatment_id"));

                bill.setPatientName(
                    rs.getString("first_name") + " " + rs.getString("last_name")
                );

                bill.setTreatmentName(
                    rs.getString("treatment_name")
                );

                bill.setAmount(rs.getDouble("amount"));
                bill.setPaymentStatus(rs.getString("payment_status"));
                bill.setPaymentDate(rs.getString("payment_date"));
                list.add(bill);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Get Bill By ID
    public Billing getBillById(int id) {

        Billing bill = null;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM billing WHERE bill_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                bill = new Billing();

                bill.setBillId(rs.getInt("bill_id"));
                bill.setPatientId(rs.getInt("patient_id"));
                bill.setTreatmentId(rs.getInt("treatment_id"));
                bill.setAmount(rs.getDouble("amount"));
                bill.setPaymentStatus(rs.getString("payment_status"));
                bill.setPaymentDate(rs.getString("payment_date"));
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return bill;
    }

    // Update Bill
    public boolean updateBill(Billing bill) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "UPDATE billing SET patient_id=?, treatment_id=?, amount=?, payment_status=?, payment_date=? WHERE bill_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, bill.getPatientId());
            ps.setInt(2, bill.getTreatmentId());
            ps.setDouble(3, bill.getAmount());
            ps.setString(4, bill.getPaymentStatus());
            ps.setString(5, bill.getPaymentDate());
            ps.setInt(6, bill.getBillId());

            status = ps.executeUpdate() > 0;

            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // Delete Bill
    public boolean deleteBill(int id) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "DELETE FROM billing WHERE bill_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, id);

            status = ps.executeUpdate() > 0;

            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
 // Search Bills
    public List<Billing> searchBills(String keyword) {

        List<Billing> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM billing WHERE "
                       + "CAST(amount AS CHAR) LIKE ? OR "
                       + "payment_status LIKE ? OR "
                       + "payment_date LIKE ? "
                       + "ORDER BY bill_id DESC";

            PreparedStatement ps = con.prepareStatement(sql);

            String search = "%" + keyword + "%";

            ps.setString(1, search);
            ps.setString(2, search);
            ps.setString(3, search);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Billing bill = new Billing();

                bill.setBillId(rs.getInt("bill_id"));
                bill.setPatientId(rs.getInt("patient_id"));
                bill.setTreatmentId(rs.getInt("treatment_id"));
                bill.setAmount(rs.getDouble("amount"));
                bill.setPaymentStatus(rs.getString("payment_status"));
                bill.setPaymentDate(rs.getString("payment_date"));

                list.add(bill);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}