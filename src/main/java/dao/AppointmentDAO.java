package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Appointment;
import util.DBConnection;

public class AppointmentDAO {

    // Add Appointment
    public boolean addAppointment(Appointment appointment) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO appointments(patient_id,dentist_id,appointment_date,appointment_time,status,treatment,notes) VALUES(?,?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, appointment.getPatientId());
            ps.setInt(2, appointment.getDentistId());
            ps.setString(3, appointment.getAppointmentDate());
            ps.setString(4, appointment.getAppointmentTime());
            ps.setString(5, appointment.getStatus());
            ps.setString(6, appointment.getTreatment());
            ps.setString(7, appointment.getNotes());

            status = ps.executeUpdate() > 0;

            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // Get All Appointments
    public List<Appointment> getAllAppointments() {

        List<Appointment> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM appointments ORDER BY appointment_id DESC";

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Appointment appointment = new Appointment();

                appointment.setAppointmentId(rs.getInt("appointment_id"));
                appointment.setPatientId(rs.getInt("patient_id"));
                appointment.setDentistId(rs.getInt("dentist_id"));
                appointment.setAppointmentDate(rs.getString("appointment_date"));
                appointment.setAppointmentTime(rs.getString("appointment_time"));
                appointment.setStatus(rs.getString("status"));
                appointment.setTreatment(rs.getString("treatment"));
                appointment.setNotes(rs.getString("notes"));

                list.add(appointment);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Get Appointment By ID
    public Appointment getAppointmentById(int id) {

        Appointment appointment = null;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM appointments WHERE appointment_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                appointment = new Appointment();

                appointment.setAppointmentId(rs.getInt("appointment_id"));
                appointment.setPatientId(rs.getInt("patient_id"));
                appointment.setDentistId(rs.getInt("dentist_id"));
                appointment.setAppointmentDate(rs.getString("appointment_date"));
                appointment.setAppointmentTime(rs.getString("appointment_time"));
                appointment.setStatus(rs.getString("status"));
                appointment.setTreatment(rs.getString("treatment"));
                appointment.setNotes(rs.getString("notes"));
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return appointment;
    }

    // Update Appointment
    public boolean updateAppointment(Appointment appointment) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "UPDATE appointments SET patient_id=?, dentist_id=?, appointment_date=?, appointment_time=?, status=?, treatment=?, notes=? WHERE appointment_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, appointment.getPatientId());
            ps.setInt(2, appointment.getDentistId());
            ps.setString(3, appointment.getAppointmentDate());
            ps.setString(4, appointment.getAppointmentTime());
            ps.setString(5, appointment.getStatus());
            ps.setString(6, appointment.getTreatment());
            ps.setString(7, appointment.getNotes());
            ps.setInt(8, appointment.getAppointmentId());

            status = ps.executeUpdate() > 0;

            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // Delete Appointment
    public boolean deleteAppointment(int id) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "DELETE FROM appointments WHERE appointment_id=?";

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
    public List<Appointment> getRecentAppointments() {

        List<Appointment> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql =
            		"SELECT a.*, " +
            		"CONCAT(p.first_name,' ',p.last_name) AS patient_name, " +
            		"CONCAT(d.first_name,' ',d.last_name) AS dentist_name " +
            		"FROM appointments a " +
            		"JOIN patients p ON a.patient_id = p.patient_id " +
            		"JOIN dentists d ON a.dentist_id = d.dentist_id " +
            		"ORDER BY a.appointment_date DESC, a.appointment_time DESC " +
            		"LIMIT 5";

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Appointment a = new Appointment();

                a.setAppointmentId(rs.getInt("appointment_id"));
                a.setPatientId(rs.getInt("patient_id"));
                a.setDentistId(rs.getInt("dentist_id"));
                a.setAppointmentDate(rs.getString("appointment_date"));
                a.setAppointmentTime(rs.getString("appointment_time"));
                a.setStatus(rs.getString("status"));
                a.setTreatment(rs.getString("treatment"));
                a.setNotes(rs.getString("notes"));
                a.setPatientName(rs.getString("patient_name"));
                a.setDentistName(rs.getString("dentist_name"));

                list.add(a);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public List<Appointment> searchAppointments(String keyword) {

        List<Appointment> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql =
                "SELECT * FROM appointments WHERE " +
                "appointment_date LIKE ? OR " +
                "status LIKE ? OR " +
                "treatment LIKE ? " +
                "ORDER BY appointment_date DESC, appointment_time DESC";

            PreparedStatement ps = con.prepareStatement(sql);

            String search = "%" + keyword + "%";

            ps.setString(1, search);
            ps.setString(2, search);
            ps.setString(3, search);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Appointment a = new Appointment();

                a.setAppointmentId(rs.getInt("appointment_id"));
                a.setPatientId(rs.getInt("patient_id"));
                a.setDentistId(rs.getInt("dentist_id"));
                a.setAppointmentDate(rs.getString("appointment_date"));
                a.setAppointmentTime(rs.getString("appointment_time"));
                a.setStatus(rs.getString("status"));
                a.setTreatment(rs.getString("treatment"));
                a.setNotes(rs.getString("notes"));

                list.add(a);
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
 // GET UPCOMING APPOINTMENTS FOR PATIENT
 // =========================

 public List<Appointment> getUpcomingAppointments(int patientId) {

     List<Appointment> list = new ArrayList<>();

     try {

         Connection con = DBConnection.getConnection();

         String sql =
                 "SELECT a.*, " +
                 "CONCAT(d.first_name,' ',d.last_name) AS dentist_name " +
                 "FROM appointments a " +
                 "JOIN dentists d ON a.dentist_id = d.dentist_id " +
                 "WHERE a.patient_id = ? " +
                 "AND a.appointment_date >= CURDATE() " +
                 "AND a.status NOT IN ('Completed', 'Cancelled') " +
                 "ORDER BY a.appointment_date ASC, " +
                 "a.appointment_time ASC";

         PreparedStatement ps =
                 con.prepareStatement(sql);

         ps.setInt(1, patientId);

         ResultSet rs =
                 ps.executeQuery();

         while (rs.next()) {

             Appointment a = new Appointment();

             a.setAppointmentId(
                     rs.getInt("appointment_id")
             );

             a.setPatientId(
                     rs.getInt("patient_id")
             );

             a.setDentistId(
                     rs.getInt("dentist_id")
             );

             a.setAppointmentDate(
                     rs.getString("appointment_date")
             );

             a.setAppointmentTime(
                     rs.getString("appointment_time")
             );

             a.setStatus(
                     rs.getString("status")
             );

             a.setTreatment(
                     rs.getString("treatment")
             );

             a.setNotes(
                     rs.getString("notes")
             );

             a.setDentistName(
                     rs.getString("dentist_name")
             );

             list.add(a);
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