package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import model.User;
import util.DBConnection;

import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // =========================
    // LOGIN
    // =========================

    public User login(String username, String password) {

        User user = null;

        try {

            Connection con = DBConnection.getConnection();

            String sql =
                    "SELECT * FROM users " +
                    "WHERE username=? AND password=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                user = new User();

                user.setId(
                        rs.getInt("id")
                );

                user.setUsername(
                        rs.getString("username")
                );

                user.setPassword(
                        rs.getString("password")
                );

                user.setFullName(
                        rs.getString("full_name")
                );

                user.setEmail(
                        rs.getString("email")
                );

                user.setPhone(
                        rs.getString("phone")
                );

                user.setRole(
                        rs.getString("role")
                );
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return user;
    }


    // =========================
    // REGISTER USER + PATIENT
    // =========================

    public boolean register(User user) {

        Connection con = null;

        try {

            con = DBConnection.getConnection();

            // Start transaction
            con.setAutoCommit(false);


            // =========================
            // INSERT USER
            // =========================

            String userSql =
                    "INSERT INTO users " +
                    "(username, password, full_name, email, phone, role) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";

            PreparedStatement userPs =
                    con.prepareStatement(
                            userSql,
                            Statement.RETURN_GENERATED_KEYS
                    );

            userPs.setString(
                    1,
                    user.getUsername()
            );

            userPs.setString(
                    2,
                    user.getPassword()
            );

            userPs.setString(
                    3,
                    user.getFullName()
            );

            userPs.setString(
                    4,
                    user.getEmail()
            );

            userPs.setString(
                    5,
                    user.getPhone()
            );

            userPs.setString(
                    6,
                    user.getRole()
            );


            int result =
                    userPs.executeUpdate();


            if (result == 0) {

                con.rollback();

                userPs.close();

                return false;
            }


            // =========================
            // GET NEW USER ID
            // =========================

            int userId = 0;

            ResultSet keys =
                    userPs.getGeneratedKeys();

            if (keys.next()) {

                userId =
                        keys.getInt(1);

            } else {

                con.rollback();

                keys.close();
                userPs.close();

                return false;
            }

            keys.close();
            userPs.close();


            // =========================
            // SPLIT FULL NAME
            // =========================

            String fullName =
                    user.getFullName().trim();

            String firstName;
            String lastName;


            if (fullName.contains(" ")) {

                int spaceIndex =
                        fullName.indexOf(" ");

                firstName =
                        fullName.substring(
                                0,
                                spaceIndex
                        );

                lastName =
                        fullName.substring(
                                spaceIndex + 1
                        );

            } else {

                firstName = fullName;

                lastName = fullName;
            }


            // =========================
            // INSERT PATIENT
            // =========================

            String patientSql =
                    "INSERT INTO patients " +
                    "(user_id, first_name, last_name, phone, email) " +
                    "VALUES (?, ?, ?, ?, ?)";

            PreparedStatement patientPs =
                    con.prepareStatement(patientSql);

            patientPs.setInt(
                    1,
                    userId
            );

            patientPs.setString(
                    2,
                    firstName
            );

            patientPs.setString(
                    3,
                    lastName
            );

            patientPs.setString(
                    4,
                    user.getPhone()
            );

            patientPs.setString(
                    5,
                    user.getEmail()
            );


            int patientResult =
                    patientPs.executeUpdate();


            if (patientResult == 0) {

                con.rollback();

                patientPs.close();

                return false;
            }


            patientPs.close();


            // =========================
            // COMMIT
            // =========================

            con.commit();

            con.setAutoCommit(true);

            return true;


        } catch (Exception e) {

            e.printStackTrace();

            try {

                if (con != null) {

                    con.rollback();

                }

            } catch (Exception rollbackError) {

                rollbackError.printStackTrace();

            }

            return false;


        } finally {

            try {

                if (con != null &&
                    !con.isClosed()) {

                    con.close();

                }

            } catch (Exception closeError) {

                closeError.printStackTrace();

            }
        }
    }


    // =========================
    // CHECK USERNAME
    // =========================

    public boolean usernameExists(String username) {

        boolean exists = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "SELECT id FROM users WHERE username=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, username);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                exists = true;

            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return exists;
    }


    // =========================
    // CHECK EMAIL
    // =========================

    public boolean emailExists(String email) {

        boolean exists = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "SELECT id FROM users WHERE email=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, email);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                exists = true;

            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return exists;
    }
 // =========================
 // GET ALL USERS
 // =========================

 public List<User> getAllUsers() {

     List<User> list = new ArrayList<>();

     try {

         Connection con =
                 DBConnection.getConnection();

         String sql =
                 "SELECT * FROM users ORDER BY id DESC";

         PreparedStatement ps =
                 con.prepareStatement(sql);

         ResultSet rs =
                 ps.executeQuery();

         while (rs.next()) {

             User user = new User();

             user.setId(rs.getInt("id"));
             user.setUsername(rs.getString("username"));
             user.setPassword(rs.getString("password"));
             user.setFullName(rs.getString("full_name"));
             user.setEmail(rs.getString("email"));
             user.setPhone(rs.getString("phone"));
             user.setRole(rs.getString("role"));

             list.add(user);
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
 // SEARCH USERS
 // =========================

 public List<User> searchUsers(String keyword) {

     List<User> list = new ArrayList<>();

     try {

         Connection con =
                 DBConnection.getConnection();

         String sql =
                 "SELECT * FROM users WHERE " +
                 "username LIKE ? OR " +
                 "full_name LIKE ? OR " +
                 "email LIKE ? OR " +
                 "role LIKE ? " +
                 "ORDER BY id DESC";

         PreparedStatement ps =
                 con.prepareStatement(sql);

         String search =
                 "%" + keyword + "%";

         ps.setString(1, search);
         ps.setString(2, search);
         ps.setString(3, search);
         ps.setString(4, search);

         ResultSet rs =
                 ps.executeQuery();

         while (rs.next()) {

             User user = new User();

             user.setId(rs.getInt("id"));
             user.setUsername(rs.getString("username"));
             user.setPassword(rs.getString("password"));
             user.setFullName(rs.getString("full_name"));
             user.setEmail(rs.getString("email"));
             user.setPhone(rs.getString("phone"));
             user.setRole(rs.getString("role"));

             list.add(user);
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
 // UPDATE USER ROLE
 // =========================

 public boolean updateUserRole(
         int userId,
         String role) {

     boolean success = false;

     try {

         Connection con =
                 DBConnection.getConnection();

         String sql =
                 "UPDATE users SET role=? WHERE id=?";

         PreparedStatement ps =
                 con.prepareStatement(sql);

         ps.setString(1, role);
         ps.setInt(2, userId);

         success =
                 ps.executeUpdate() > 0;

         ps.close();
         con.close();

     } catch (Exception e) {

         e.printStackTrace();
     }

     return success;
 }


 // =========================
 // DELETE USER
 // =========================

 public boolean deleteUser(int userId) {

     boolean success = false;

     try {

         Connection con =
                 DBConnection.getConnection();

         String sql =
                 "DELETE FROM users WHERE id=?";

         PreparedStatement ps =
                 con.prepareStatement(sql);

         ps.setInt(1, userId);

         success =
                 ps.executeUpdate() > 0;

         ps.close();
         con.close();

     } catch (Exception e) {

         e.printStackTrace();
     }

     return success;
 }

    
}