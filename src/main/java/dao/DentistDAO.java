package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Dentist;
import util.DBConnection;

public class DentistDAO {

    // =========================================================
    // ADD DENTIST
    // =========================================================

    public boolean addDentist(Dentist dentist) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql =
                    "INSERT INTO dentists " +
                    "(first_name, last_name, specialization, phone, email, profile_image) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, dentist.getFirstName());
            ps.setString(2, dentist.getLastName());
            ps.setString(3, dentist.getSpecialization());
            ps.setString(4, dentist.getPhone());
            ps.setString(5, dentist.getEmail());

            // Profile image
            String profileImage =
                    dentist.getProfileImage();

            if (profileImage == null ||
                    profileImage.trim().isEmpty()) {

                profileImage = "doctor-default.jpg";
            }

            ps.setString(6, profileImage);

            status =
                    ps.executeUpdate() > 0;

            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return status;
    }


    // =========================================================
    // GET ALL DENTISTS
    // =========================================================

    public List<Dentist> getAllDentists() {

        List<Dentist> list =
                new ArrayList<>();

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM dentists " +
                    "ORDER BY dentist_id DESC";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while (rs.next()) {

                Dentist dentist =
                        new Dentist();

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

                dentist.setProfileImage(
                        rs.getString("profile_image")
                );

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


    // =========================================================
    // GET DENTIST BY ID
    // =========================================================

    public Dentist getDentistById(int id) {

        Dentist dentist = null;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM dentists " +
                    "WHERE dentist_id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, id);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                dentist =
                        new Dentist();

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

                dentist.setProfileImage(
                        rs.getString("profile_image")
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


    // =========================================================
    // UPDATE DENTIST
    // =========================================================
    //
    // This method updates dentist details WITHOUT changing
    // the existing profile image.
    //
    // This is useful when editing only:
    // Name / Specialization / Phone / Email
    //
    // =========================================================

    public boolean updateDentist(Dentist dentist) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "UPDATE dentists SET " +
                    "first_name=?, " +
                    "last_name=?, " +
                    "specialization=?, " +
                    "phone=?, " +
                    "email=? " +
                    "WHERE dentist_id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(
                    1,
                    dentist.getFirstName()
            );

            ps.setString(
                    2,
                    dentist.getLastName()
            );

            ps.setString(
                    3,
                    dentist.getSpecialization()
            );

            ps.setString(
                    4,
                    dentist.getPhone()
            );

            ps.setString(
                    5,
                    dentist.getEmail()
            );

            ps.setInt(
                    6,
                    dentist.getDentistId()
            );

            status =
                    ps.executeUpdate() > 0;

            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return status;
    }


    // =========================================================
    // UPDATE DENTIST + PROFILE IMAGE
    // =========================================================

    public boolean updateDentistWithImage(
            Dentist dentist) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "UPDATE dentists SET " +
                    "first_name=?, " +
                    "last_name=?, " +
                    "specialization=?, " +
                    "phone=?, " +
                    "email=?, " +
                    "profile_image=? " +
                    "WHERE dentist_id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(
                    1,
                    dentist.getFirstName()
            );

            ps.setString(
                    2,
                    dentist.getLastName()
            );

            ps.setString(
                    3,
                    dentist.getSpecialization()
            );

            ps.setString(
                    4,
                    dentist.getPhone()
            );

            ps.setString(
                    5,
                    dentist.getEmail()
            );

            String profileImage =
                    dentist.getProfileImage();

            if (profileImage == null ||
                    profileImage.trim().isEmpty()) {

                profileImage =
                        "doctor-default.jpg";
            }

            ps.setString(
                    6,
                    profileImage
            );

            ps.setInt(
                    7,
                    dentist.getDentistId()
            );

            status =
                    ps.executeUpdate() > 0;

            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return status;
    }


    // =========================================================
    // DELETE DENTIST
    // =========================================================

    public boolean deleteDentist(int id) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "DELETE FROM dentists " +
                    "WHERE dentist_id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, id);

            status =
                    ps.executeUpdate() > 0;

            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return status;
    }


    // =========================================================
    // SEARCH DENTISTS
    // =========================================================

    public List<Dentist> searchDentists(
            String keyword) {

        List<Dentist> list =
                new ArrayList<>();

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM dentists WHERE " +
                    "first_name LIKE ? OR " +
                    "last_name LIKE ? OR " +
                    "specialization LIKE ? OR " +
                    "phone LIKE ? OR " +
                    "email LIKE ? " +
                    "ORDER BY dentist_id DESC";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            String search =
                    "%" + keyword + "%";

            ps.setString(1, search);
            ps.setString(2, search);
            ps.setString(3, search);
            ps.setString(4, search);
            ps.setString(5, search);

            ResultSet rs =
                    ps.executeQuery();

            while (rs.next()) {

                Dentist dentist =
                        new Dentist();

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

                dentist.setProfileImage(
                        rs.getString("profile_image")
                );

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


    // =========================================================
    // GET DENTIST BY USER ID
    // =========================================================

    public Dentist getDentistByUserId(
            int userId) {

        Dentist dentist = null;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM dentists " +
                    "WHERE user_id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                dentist =
                        new Dentist();

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

                dentist.setProfileImage(
                        rs.getString("profile_image")
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
    
 
 // =====================================================
 // UPDATE DENTIST PROFILE
 // =====================================================

 public boolean updateDentistProfile(Dentist dentist) {

     boolean status = false;

     try {

         Connection con = DBConnection.getConnection();

         String sql =
                 "UPDATE dentists SET " +
                 "first_name=?, " +
                 "last_name=?, " +
                 "specialization=?, " +
                 "phone=?, " +
                 "email=?, " +
                 "profile_image=? " +
                 "WHERE dentist_id=?";

         PreparedStatement ps =
                 con.prepareStatement(sql);

         ps.setString(
                 1,
                 dentist.getFirstName()
         );

         ps.setString(
                 2,
                 dentist.getLastName()
         );

         ps.setString(
                 3,
                 dentist.getSpecialization()
         );

         ps.setString(
                 4,
                 dentist.getPhone()
         );

         ps.setString(
                 5,
                 dentist.getEmail()
         );

         ps.setString(
                 6,
                 dentist.getProfileImage()
         );

         ps.setInt(
                 7,
                 dentist.getDentistId()
         );

         status =
                 ps.executeUpdate() > 0;

         ps.close();
         con.close();

     } catch (Exception e) {

         e.printStackTrace();
     }

     return status;
 }

}