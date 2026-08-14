package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.Settings;
import util.DBConnection;

public class SettingsDAO {

    private Connection conn;

    public SettingsDAO() {
        conn = DBConnection.getConnection();
    }

    // =========================
    // Get Settings
    // =========================
    public Settings getSettings() {

        Settings s = new Settings();

        try {

            String sql = "SELECT * FROM settings LIMIT 1";

            PreparedStatement ps = conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){

                s.setId(rs.getInt("id"));
                s.setClinicName(rs.getString("clinic_name"));
                s.setClinicTagline(rs.getString("clinic_tagline"));
                s.setAddress(rs.getString("address"));
                s.setPhone(rs.getString("phone"));
                s.setEmail(rs.getString("email"));
                s.setWebsite(rs.getString("website"));
                s.setWorkingHours(rs.getString("working_hours"));

                s.setAdminName(rs.getString("admin_name"));
                s.setUsername(rs.getString("username"));
                s.setAdminEmail(rs.getString("admin_email"));

                s.setClinicLogo(rs.getString("clinic_logo"));
                s.setProfileImage(rs.getString("profile_image"));

                s.setTheme(rs.getString("theme"));
                s.setAccentColor(rs.getString("accent_color"));

                s.setLanguage(rs.getString("language"));
                s.setCurrency(rs.getString("currency"));

                s.setNotifications(rs.getBoolean("notifications"));

            }

        } catch(Exception e){

            e.printStackTrace();

        }

        return s;

    }

    // =========================
    // Update Clinic Information
    // =========================

    public boolean updateClinicInfo(Settings s){

        try{

            String sql =
            "UPDATE settings SET clinic_name=?, clinic_tagline=?, address=?, phone=?, email=?, website=?, working_hours=? WHERE id=?";

            PreparedStatement ps =
            conn.prepareStatement(sql);

            ps.setString(1,s.getClinicName());
            ps.setString(2,s.getClinicTagline());
            ps.setString(3,s.getAddress());
            ps.setString(4,s.getPhone());
            ps.setString(5,s.getEmail());
            ps.setString(6,s.getWebsite());
            ps.setString(7,s.getWorkingHours());
            ps.setInt(8,s.getId());

            return ps.executeUpdate()>0;

        }catch(Exception e){

            e.printStackTrace();

        }

        return false;

    }

    // =========================
    // Update Admin Profile
    // =========================

    public boolean updateAdminProfile(Settings s){

        try{

            String sql =
            "UPDATE settings SET admin_name=?, username=?, admin_email=? WHERE id=?";

            PreparedStatement ps =
            conn.prepareStatement(sql);

            ps.setString(1,s.getAdminName());
            ps.setString(2,s.getUsername());
            ps.setString(3,s.getAdminEmail());
            ps.setInt(4,s.getId());

            return ps.executeUpdate()>0;

        }catch(Exception e){

            e.printStackTrace();

        }

        return false;

    }

    // =========================
    // Appearance
    // =========================

    public boolean updateAppearance(Settings s){

        try{

            String sql =
            "UPDATE settings SET theme=?, accent_color=? WHERE id=?";

            PreparedStatement ps =
            conn.prepareStatement(sql);

            ps.setString(1,s.getTheme());
            ps.setString(2,s.getAccentColor());
            ps.setInt(3,s.getId());

            return ps.executeUpdate()>0;

        }catch(Exception e){

            e.printStackTrace();

        }

        return false;

    }

    // =========================
    // System Settings
    // =========================

    public boolean updateSystem(Settings s){

        try{

            String sql =
            "UPDATE settings SET language=?, currency=?, notifications=? WHERE id=?";

            PreparedStatement ps =
            conn.prepareStatement(sql);

            ps.setString(1,s.getLanguage());
            ps.setString(2,s.getCurrency());
            ps.setBoolean(3,s.isNotifications());
            ps.setInt(4,s.getId());

            return ps.executeUpdate()>0;

        }catch(Exception e){

            e.printStackTrace();

        }

        return false;

    }

}