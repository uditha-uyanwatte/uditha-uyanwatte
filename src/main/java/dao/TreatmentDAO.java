package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Treatment;
import util.DBConnection;

public class TreatmentDAO {

    // Add Treatment
    public boolean addTreatment(Treatment treatment) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO treatments(appointment_id,treatment_name,description,cost) VALUES(?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, treatment.getAppointmentId());
            ps.setString(2, treatment.getTreatmentName());
            ps.setString(3, treatment.getDescription());
            ps.setDouble(4, treatment.getCost());

            status = ps.executeUpdate() > 0;

            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // Get All Treatments
    public List<Treatment> getAllTreatments() {

        List<Treatment> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM treatments ORDER BY treatment_id DESC";

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Treatment treatment = new Treatment();

                treatment.setTreatmentId(rs.getInt("treatment_id"));
                treatment.setAppointmentId(rs.getInt("appointment_id"));
                treatment.setTreatmentName(rs.getString("treatment_name"));
                treatment.setDescription(rs.getString("description"));
                treatment.setCost(rs.getDouble("cost"));

                list.add(treatment);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Get Treatment By ID
    public Treatment getTreatmentById(int id) {

        Treatment treatment = null;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM treatments WHERE treatment_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                treatment = new Treatment();

                treatment.setTreatmentId(rs.getInt("treatment_id"));
                treatment.setAppointmentId(rs.getInt("appointment_id"));
                treatment.setTreatmentName(rs.getString("treatment_name"));
                treatment.setDescription(rs.getString("description"));
                treatment.setCost(rs.getDouble("cost"));
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return treatment;
    }

    // Update Treatment
    public boolean updateTreatment(Treatment treatment) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "UPDATE treatments SET appointment_id=?, treatment_name=?, description=?, cost=? WHERE treatment_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, treatment.getAppointmentId());
            ps.setString(2, treatment.getTreatmentName());
            ps.setString(3, treatment.getDescription());
            ps.setDouble(4, treatment.getCost());
            ps.setInt(5, treatment.getTreatmentId());

            status = ps.executeUpdate() > 0;

            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // Delete Treatment
    public boolean deleteTreatment(int id) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "DELETE FROM treatments WHERE treatment_id=?";

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
    
    public List<Treatment> searchTreatments(String keyword) {

        List<Treatment> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM treatments WHERE "
                    + "treatment_name LIKE ? OR "
                    + "description LIKE ? OR "
                    + "CAST(cost AS CHAR) LIKE ? "
                    + "ORDER BY treatment_id DESC";

            PreparedStatement ps = con.prepareStatement(sql);

            String search = "%" + keyword + "%";

            ps.setString(1, search);
            ps.setString(2, search);
            ps.setString(3, search);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Treatment t = new Treatment();

                t.setTreatmentId(rs.getInt("treatment_id"));
                t.setAppointmentId(rs.getInt("appointment_id"));
                t.setTreatmentName(rs.getString("treatment_name"));
                t.setDescription(rs.getString("description"));
                t.setCost(rs.getDouble("cost"));

                list.add(t);
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