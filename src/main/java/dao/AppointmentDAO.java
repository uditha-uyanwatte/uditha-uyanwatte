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
        
     // =========================
     // CHECK APPOINTMENT SLOT
     // =========================

     public boolean isAppointmentSlotBooked(
             int dentistId,
             String appointmentDate,
             String appointmentTime) {

         boolean booked = false;

         try {

             Connection con =
                     DBConnection.getConnection();

             String sql =
                     "SELECT appointment_id " +
                     "FROM appointments " +
                     "WHERE dentist_id = ? " +
                     "AND appointment_date = ? " +
                     "AND appointment_time = ? " +
                     "AND status NOT IN ('Cancelled')";

             PreparedStatement ps =
                     con.prepareStatement(sql);

             ps.setInt(
                     1,
                     dentistId
             );

             ps.setString(
                     2,
                     appointmentDate
             );

             ps.setString(
                     3,
                     appointmentTime
             );

             ResultSet rs =
                     ps.executeQuery();

             if (rs.next()) {

                 booked = true;
             }

             rs.close();
             ps.close();
             con.close();

         } catch (Exception e) {

             e.printStackTrace();
         }

         return booked;
     }
    
    
    

  // Get All Appointments
     public List<Appointment> getAllAppointments() {

         List<Appointment> list = new ArrayList<>();

         try {

             Connection con = DBConnection.getConnection();

             String sql =
                     "SELECT a.*, " +
                     "CONCAT(p.first_name, ' ', p.last_name) AS patient_name, " +
                     "CONCAT(d.first_name, ' ', d.last_name) AS dentist_name " +
                     "FROM appointments a " +
                     "LEFT JOIN patients p ON a.patient_id = p.patient_id " +
                     "LEFT JOIN dentists d ON a.dentist_id = d.dentist_id " +
                     "ORDER BY a.appointment_id DESC";

             PreparedStatement ps = con.prepareStatement(sql);

             ResultSet rs = ps.executeQuery();

             while (rs.next()) {

                 Appointment appointment = new Appointment();

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

                 appointment.setPatientName(
                         rs.getString("patient_name")
                 );

                 appointment.setDentistName(
                         rs.getString("dentist_name")
                 );

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

  // =====================================
  // GET FULL APPOINTMENT DETAILS BY ID
  // =====================================

  public Appointment getAppointmentById(int id) {

      Appointment appointment = null;

      try {

          Connection con =
                  DBConnection.getConnection();

          String sql =
                  "SELECT a.*, " +
                  "CONCAT(p.first_name, ' ', p.last_name) " +
                  "AS patient_name, " +
                  "p.phone AS patient_phone, " +
                  "p.email AS patient_email, " +
                  "CONCAT(d.first_name, ' ', d.last_name) " +
                  "AS dentist_name, " +
                  "d.specialization AS dentist_specialization " +
                  "FROM appointments a " +
                  "LEFT JOIN patients p " +
                  "ON a.patient_id = p.patient_id " +
                  "LEFT JOIN dentists d " +
                  "ON a.dentist_id = d.dentist_id " +
                  "WHERE a.appointment_id = ?";

          PreparedStatement ps =
                  con.prepareStatement(sql);

          ps.setInt(1, id);

          ResultSet rs =
                  ps.executeQuery();

          if (rs.next()) {

              appointment =
                      new Appointment();

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

              appointment.setPatientName(
                      rs.getString("patient_name")
              );

              appointment.setDentistName(
                      rs.getString("dentist_name")
                      
              );
              
              appointment.setPatientPhone(
            	        rs.getString("patient_phone")
            	);

            	appointment.setPatientEmail(
            	        rs.getString("patient_email")
            	);

            	appointment.setDentistSpecialization(
            	        rs.getString("dentist_specialization")
            	);
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
 // =========================
 // SEARCH + STATUS FILTER
 // =========================

 public List<Appointment> searchAppointments(
         String keyword,
         String status) {

     List<Appointment> list = new ArrayList<>();

     try {

         Connection con = DBConnection.getConnection();

         StringBuilder sql = new StringBuilder(
             "SELECT * FROM appointments WHERE 1=1 "
         );

         List<String> params = new ArrayList<>();

         // Search
         if (keyword != null &&
             !keyword.trim().isEmpty()) {

             sql.append(
                 "AND (" +
                 "appointment_date LIKE ? OR " +
                 "status LIKE ? OR " +
                 "treatment LIKE ?" +
                 ") "
             );

             String search =
                 "%" + keyword.trim() + "%";

             params.add(search);
             params.add(search);
             params.add(search);
         }

         // Status filter
         if (status != null &&
             !status.trim().isEmpty() &&
             !"All".equalsIgnoreCase(status)) {

             sql.append("AND status = ? ");

             params.add(status);
         }

         sql.append(
             "ORDER BY appointment_date DESC, " +
             "appointment_time DESC"
         );

         PreparedStatement ps =
             con.prepareStatement(sql.toString());

         for (int i = 0; i < params.size(); i++) {

             ps.setString(
                 i + 1,
                 params.get(i)
             );
         }

         ResultSet rs =
             ps.executeQuery();

         while (rs.next()) {

             Appointment a =
                 new Appointment();

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
//=========================
//GET APPOINTMENTS BY DENTIST
//=========================

public List<Appointment> getAppointmentsByDentist(int dentistId) {

  List<Appointment> list = new ArrayList<>();

  try {

      Connection con =
              DBConnection.getConnection();

      String sql =
              "SELECT a.*, " +
              "CONCAT(p.first_name, ' ', p.last_name) AS patient_name " +
              "FROM appointments a " +
              "JOIN patients p " +
              "ON a.patient_id = p.patient_id " +
              "WHERE a.dentist_id = ? " +
              "ORDER BY a.appointment_date ASC, " +
              "a.appointment_time ASC";

      PreparedStatement ps =
              con.prepareStatement(sql);

      ps.setInt(1, dentistId);

      ResultSet rs =
              ps.executeQuery();

      while (rs.next()) {

          Appointment a =
                  new Appointment();

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

          a.setPatientName(
                  rs.getString("patient_name")
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


//=========================
//UPDATE APPOINTMENT STATUS
//=========================

public boolean updateAppointmentStatus(
      int appointmentId,
      int dentistId,
      String status) {

  boolean success = false;

  try {

      Connection con =
              DBConnection.getConnection();

      String sql =
              "UPDATE appointments " +
              "SET status=? " +
              "WHERE appointment_id=? " +
              "AND dentist_id=?";

      PreparedStatement ps =
              con.prepareStatement(sql);

      ps.setString(1, status);
      ps.setInt(2, appointmentId);
      ps.setInt(3, dentistId);

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