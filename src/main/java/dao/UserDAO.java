package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.User;
import util.DBConnection;

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
    // REGISTER
    // =========================

    public boolean register(User user) {

        boolean success = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "INSERT INTO users " +
                    "(username, password, full_name, email, phone, role) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(
                    1,
                    user.getUsername()
            );

            ps.setString(
                    2,
                    user.getPassword()
            );

            ps.setString(
                    3,
                    user.getFullName()
            );

            ps.setString(
                    4,
                    user.getEmail()
            );

            ps.setString(
                    5,
                    user.getPhone()
            );

            ps.setString(
                    6,
                    user.getRole()
            );

            int result =
                    ps.executeUpdate();

            if (result > 0) {

                success = true;

            }

            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return success;
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

}