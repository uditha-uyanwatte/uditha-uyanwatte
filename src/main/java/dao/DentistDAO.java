package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Dentist;
import util.DBConnection;

public class DentistDAO {

    // Add Dentist
    public boolean addDentist(Dentist dentist) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO dentists(first_name,last_name,specialization,phone,email) VALUES(?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, dentist.getFirstName());
            ps.setString(2, dentist.getLastName());
            ps.setString(3, dentist.getSpecialization());
            ps.setString(4, dentist.getPhone());
            ps.setString(5, dentist.getEmail());

            status = ps.executeUpdate() > 0;

            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // Get All Dentists
    public List<Dentist> getAllDentists() {

        List<Dentist> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM dentists ORDER BY dentist_id DESC";

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Dentist dentist = new Dentist();

                dentist.setDentistId(rs.getInt("dentist_id"));
                dentist.setFirstName(rs.getString("first_name"));
                dentist.setLastName(rs.getString("last_name"));
                dentist.setSpecialization(rs.getString("specialization"));
                dentist.setPhone(rs.getString("phone"));
                dentist.setEmail(rs.getString("email"));

                list.add(dentist);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Get Dentist By ID
    public Dentist getDentistById(int id) {

        Dentist dentist = null;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM dentists WHERE dentist_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                dentist = new Dentist();

                dentist.setDentistId(rs.getInt("dentist_id"));
                dentist.setFirstName(rs.getString("first_name"));
                dentist.setLastName(rs.getString("last_name"));
                dentist.setSpecialization(rs.getString("specialization"));
                dentist.setPhone(rs.getString("phone"));
                dentist.setEmail(rs.getString("email"));
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return dentist;
    }

    // Update Dentist
    public boolean updateDentist(Dentist dentist) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "UPDATE dentists SET first_name=?, last_name=?, specialization=?, phone=?, email=? WHERE dentist_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, dentist.getFirstName());
            ps.setString(2, dentist.getLastName());
            ps.setString(3, dentist.getSpecialization());
            ps.setString(4, dentist.getPhone());
            ps.setString(5, dentist.getEmail());
            ps.setInt(6, dentist.getDentistId());

            status = ps.executeUpdate() > 0;

            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // Delete Dentist
    public boolean deleteDentist(int id) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "DELETE FROM dentists WHERE dentist_id=?";

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
    
    public List<Dentist> searchDentists(String keyword) {

        List<Dentist> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM dentists WHERE "
                    + "first_name LIKE ? OR "
                    + "last_name LIKE ? OR "
                    + "specialization LIKE ? OR "
                    + "phone LIKE ? OR "
                    + "email LIKE ? "
                    + "ORDER BY dentist_id DESC";

            PreparedStatement ps = con.prepareStatement(sql);

            String search = "%" + keyword + "%";

            ps.setString(1, search);
            ps.setString(2, search);
            ps.setString(3, search);
            ps.setString(4, search);
            ps.setString(5, search);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Dentist d = new Dentist();

                d.setDentistId(rs.getInt("dentist_id"));
                d.setFirstName(rs.getString("first_name"));
                d.setLastName(rs.getString("last_name"));
                d.setSpecialization(rs.getString("specialization"));
                d.setPhone(rs.getString("phone"));
                d.setEmail(rs.getString("email"));

                list.add(d);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
 // =========================
 // GET DENTIST BY USER ID
 // =========================

 public Dentist getDentistByUserId(int userId) {

     Dentist dentist = null;

     try {

         Connection con = DBConnection.getConnection();

         String sql =
                 "SELECT * FROM dentists WHERE user_id=?";

         PreparedStatement ps =
                 con.prepareStatement(sql);

         ps.setInt(1, userId);

         ResultSet rs =
                 ps.executeQuery();

         if (rs.next()) {

             dentist = new Dentist();

             dentist.setDentistId(
                     rs.getInt("dentist_id")
             );

             dentist.setFirstName(
                     rs.getString("first_name")
             );

             dentist.setLastName(
                     rs.getString("last_name")
             );

             dentist.setSpecialization(
                     rs.getString("specialization")
             );

             dentist.setPhone(
                     rs.getString("phone")
             );

             dentist.setEmail(
                     rs.getString("email")
             );
         }

         rs.close();
         ps.close();
         con.close();

     } catch (Exception e) {

         e.printStackTrace();
     }

     return dentist;
 }
}