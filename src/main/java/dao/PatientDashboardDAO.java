package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Appointment;
import util.DBConnection;

import java.util.List;
import java.util.ArrayList;


public class PatientDashboardDAO {

    // =========================
    // GET PATIENT ID
    // =========================

    public int getPatientIdByUserId(int userId) {

        int patientId = 0;

        String sql =
                "SELECT patient_id FROM patients " +
                "WHERE user_id = ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    patientId = rs.getInt("patient_id");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return patientId;
    }


    // =========================
    // UPCOMING APPOINTMENTS
    // =========================

    public int getUpcomingAppointments(int patientId) {

        int count = 0;

        String sql =
                "SELECT COUNT(*) FROM appointments " +
                "WHERE patient_id = ? " +
                "AND appointment_date >= CURDATE() " +
                "AND status NOT IN ('Completed', 'Cancelled')";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, patientId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    
 // =========================
 // GET UPCOMING APPOINTMENT
 // =========================

 public Appointment getUpcomingAppointment(int patientId) {

     Appointment appointment = null;

     String sql =
             "SELECT a.*, " +
             "CONCAT(d.first_name, ' ', d.last_name) AS dentist_name " +
             "FROM appointments a " +
             "INNER JOIN dentists d " +
             "ON a.dentist_id = d.dentist_id " +
             "WHERE a.patient_id = ? " +
             "AND a.appointment_date >= CURDATE() " +
             "AND a.status NOT IN ('Completed', 'Cancelled') " +
             "ORDER BY a.appointment_date ASC, " +
             "a.appointment_time ASC " +
             "LIMIT 1";

     try (
         Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)
     ) {

         ps.setInt(1, patientId);

         try (ResultSet rs = ps.executeQuery()) {

             if (rs.next()) {

                 appointment = new Appointment();

                 appointment.setAppointmentId(
                     rs.getInt("appointment_id")
                 );

                 appointment.setPatientId(
                     rs.getInt("patient_id")
                 );

                 appointment.setDentistId(
                     rs.getInt("dentist_id")
                 );

                 appointment.setAppointmentDate(
                     rs.getString("appointment_date")
                 );

                 appointment.setAppointmentTime(
                     rs.getString("appointment_time")
                 );

                 appointment.setStatus(
                     rs.getString("status")
                 );

                 appointment.setTreatment(
                     rs.getString("treatment")
                 );

                 appointment.setNotes(
                     rs.getString("notes")
                 );

                 appointment.setDentistName(
                     rs.getString("dentist_name")
                 );
             }
         }

     } catch (Exception e) {
         e.printStackTrace();
     }

     return appointment;
 }

    // =========================
    // COMPLETED TREATMENTS
    // =========================

    public int getCompletedTreatments(int patientId) {

        int count = 0;

        String sql =
                "SELECT COUNT(*) " +
                "FROM treatments t " +
                "INNER JOIN appointments a " +
                "ON t.appointment_id = a.appointment_id " +
                "WHERE a.patient_id = ? " +
                "AND a.status = 'Completed'";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, patientId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }


    // =========================
    // TOTAL BILLS
    // =========================

    public int getTotalBills(int patientId) {

        int count = 0;

        String sql =
                "SELECT COUNT(*) FROM billing " +
                "WHERE patient_id = ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, patientId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }


    // =========================
    // TOTAL PAID AMOUNT
    // =========================

    public double getTotalPaidAmount(int patientId) {

        double total = 0;

        String sql =
                "SELECT COALESCE(SUM(amount), 0) " +
                "FROM billing " +
                "WHERE patient_id = ? " +
                "AND payment_status = 'Paid'";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, patientId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    total = rs.getDouble(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }


    // =========================
    // PENDING BILL AMOUNT
    // =========================

    public double getPendingAmount(int patientId) {

        double total = 0;

        String sql =
                "SELECT COALESCE(SUM(amount), 0) " +
                "FROM billing " +
                "WHERE patient_id = ? " +
                "AND payment_status = 'Pending'";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, patientId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    total = rs.getDouble(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }
 // =========================
 // GET ALL PATIENT APPOINTMENTS
 // =========================

 public List<Appointment> getPatientAppointments(int patientId) {

     List<Appointment> list = new ArrayList<>();

     String sql =
             "SELECT a.*, " +
             "CONCAT(d.first_name, ' ', d.last_name) AS dentist_name " +
             "FROM appointments a " +
             "INNER JOIN dentists d " +
             "ON a.dentist_id = d.dentist_id " +
             "WHERE a.patient_id = ? " +
             "ORDER BY a.appointment_date DESC, " +
             "a.appointment_time DESC";

     try (
         Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)
     ) {

         ps.setInt(1, patientId);

         try (ResultSet rs = ps.executeQuery()) {

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
         }

     } catch (Exception e) {

         e.printStackTrace();

     }

     return list;
 }
//=========================
//CANCEL PATIENT APPOINTMENT
//=========================

public boolean cancelAppointment(
      int appointmentId,
      int patientId) {

  boolean success = false;

  String sql =
          "UPDATE appointments " +
          "SET status = 'Cancelled' " +
          "WHERE appointment_id = ? " +
          "AND patient_id = ? " +
          "AND status NOT IN ('Completed', 'Cancelled')";

  try (
      Connection con = DBConnection.getConnection();
      PreparedStatement ps = con.prepareStatement(sql)
  ) {

      ps.setInt(1, appointmentId);
      ps.setInt(2, patientId);

      success =
              ps.executeUpdate() > 0;

  } catch (Exception e) {

      e.printStackTrace();

  }

  return success;
}
}