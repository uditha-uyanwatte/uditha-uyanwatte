package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


import model.Billing;
import util.DBConnection;

public class BillingDAO {

    // =========================================================
    // ADD BILL
    // =========================================================

    public boolean addBill(Billing bill) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "INSERT INTO billing "
                    + "(appointment_id, patient_id, treatment_id, "
                    + "amount, payment_status, payment_date) "
                    + "VALUES (?, ?, ?, ?, ?, ?)";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(
                    1,
                    bill.getAppointmentId()
            );

            ps.setInt(
                    2,
                    bill.getPatientId()
            );

            ps.setInt(
                    3,
                    bill.getTreatmentId()
            );

            ps.setDouble(
                    4,
                    bill.getAmount()
            );

            ps.setString(
                    5,
                    bill.getPaymentStatus()
            );

            ps.setString(
                    6,
                    bill.getPaymentDate()
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
    // GET ALL BILLS
    // =========================================================

    public List<Billing> getAllBills() {

        List<Billing> list =
                new ArrayList<>();

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "SELECT b.bill_id, "
                    + "b.appointment_id, "
                    + "b.patient_id, "
                    + "b.treatment_id, "
                    + "p.first_name, "
                    + "p.last_name, "
                    + "t.treatment_name, "
                    + "b.amount, "
                    + "b.payment_status, "
                    + "b.payment_date "
                    + "FROM billing b "
                    + "JOIN patients p "
                    + "ON b.patient_id = p.patient_id "
                    + "JOIN treatments t "
                    + "ON b.treatment_id = t.treatment_id "
                    + "ORDER BY b.bill_id DESC";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while (rs.next()) {

                Billing bill =
                        new Billing();

                bill.setBillId(
                        rs.getInt("bill_id")
                );

                bill.setAppointmentId(
                        rs.getInt("appointment_id")
                );

                bill.setPatientId(
                        rs.getInt("patient_id")
                );

                bill.setTreatmentId(
                        rs.getInt("treatment_id")
                );

                bill.setPatientName(
                        rs.getString("first_name")
                        + " "
                        + rs.getString("last_name")
                );

                bill.setTreatmentName(
                        rs.getString(
                                "treatment_name"
                        )
                );

                bill.setAmount(
                        rs.getDouble("amount")
                );

                bill.setPaymentStatus(
                        rs.getString(
                                "payment_status"
                        )
                );

                bill.setPaymentDate(
                        rs.getString(
                                "payment_date"
                        )
                );

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


    // =========================================================
    // GET BILL BY ID
    // =========================================================

    public Billing getBillById(int billId) {

        Billing bill = null;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "SELECT b.bill_id, "
                    + "b.appointment_id, "
                    + "b.patient_id, "
                    + "b.treatment_id, "
                    + "p.first_name, "
                    + "p.last_name, "
                    + "t.treatment_name, "
                    + "b.amount, "
                    + "b.payment_status, "
                    + "b.payment_date "
                    + "FROM billing b "
                    + "JOIN patients p "
                    + "ON b.patient_id = p.patient_id "
                    + "JOIN treatments t "
                    + "ON b.treatment_id = t.treatment_id "
                    + "WHERE b.bill_id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, billId);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                bill =
                        new Billing();

                bill.setBillId(
                        rs.getInt("bill_id")
                );

                bill.setAppointmentId(
                        rs.getInt("appointment_id")
                );

                bill.setPatientId(
                        rs.getInt("patient_id")
                );

                bill.setTreatmentId(
                        rs.getInt("treatment_id")
                );

                bill.setPatientName(
                        rs.getString("first_name")
                        + " "
                        + rs.getString("last_name")
                );

                bill.setTreatmentName(
                        rs.getString(
                                "treatment_name"
                        )
                );

                bill.setAmount(
                        rs.getDouble("amount")
                );

                bill.setPaymentStatus(
                        rs.getString(
                                "payment_status"
                        )
                );

                bill.setPaymentDate(
                        rs.getString(
                                "payment_date"
                        )
                );
            }

            rs.close();

            ps.close();

            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return bill;
    }


    // =========================================================
    // GET BILL BY APPOINTMENT
    // =========================================================

    public Billing getBillByAppointmentId(
            int appointmentId
    ) {

        Billing bill = null;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "SELECT bill_id "
                    + "FROM billing "
                    + "WHERE appointment_id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(
                    1,
                    appointmentId
            );

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                bill =
                        getBillById(
                                rs.getInt("bill_id")
                        );
            }

            rs.close();

            ps.close();

            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return bill;
    }


    // =========================================================
    // MARK BILL AS PAID
    // =========================================================

    public boolean markAsPaid(
            int billId,
            int patientId
    ) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "UPDATE billing "
                    + "SET payment_status='Paid', "
                    + "payment_date=CURDATE() "
                    + "WHERE bill_id=? "
                    + "AND patient_id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, billId);

            ps.setInt(2, patientId);

            status =
                    ps.executeUpdate() > 0;

            ps.close();

            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return status;
    }
    
 // =========================
 // GET BILLS BY PATIENT ID
 // =========================

 public List<Billing> getBillsByPatientId(int patientId) {

     List<Billing> list =
             new ArrayList<>();

     try {

         Connection con =
                 DBConnection.getConnection();

         String sql =
                 "SELECT b.*, " +
                 "u.full_name AS patient_name, " +
                 "a.treatment AS treatment_name " +
                 "FROM billing b " +
                 "JOIN patients p ON b.patient_id = p.patient_id " +
                 "JOIN users u ON p.user_id = u.id " +
                 "LEFT JOIN appointments a " +
                 "ON b.treatment_id = a.appointment_id " +
                 "WHERE b.patient_id = ? " +
                 "ORDER BY b.bill_id DESC";

         PreparedStatement ps =
                 con.prepareStatement(sql);

         ps.setInt(1, patientId);

         ResultSet rs =
                 ps.executeQuery();

         while (rs.next()) {

             Billing bill =
                     new Billing();

             bill.setBillId(
                     rs.getInt("bill_id")
             );

             bill.setPatientId(
                     rs.getInt("patient_id")
             );

             bill.setTreatmentId(
                     rs.getInt("treatment_id")
             );

             bill.setAmount(
                     rs.getDouble("amount")
             );

             bill.setPaymentStatus(
                     rs.getString("payment_status")
             );

             bill.setPaymentDate(
                     rs.getString("payment_date")
             );

             bill.setPatientName(
                     rs.getString("patient_name")
             );

             bill.setTreatmentName(
                     rs.getString("treatment_name")
             );

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
 public boolean deleteBill(int billId) {

	    boolean status = false;

	    try {

	        Connection con =
	                DBConnection.getConnection();

	        String sql =
	                "DELETE FROM billing WHERE bill_id=?";

	        PreparedStatement ps =
	                con.prepareStatement(sql);

	        ps.setInt(1, billId);

	        status =
	                ps.executeUpdate() > 0;

	        ps.close();
	        con.close();

	    } catch (Exception e) {

	        e.printStackTrace();

	    }

	    return status;
	}
//=========================
//SEARCH BILLS
//=========================
public List<Billing> searchBills(String keyword) {

  List<Billing> list = new ArrayList<>();

  try {

      Connection con = DBConnection.getConnection();

      String sql =
              "SELECT b.*, p.first_name, p.last_name, "
            + "t.treatment_name "
            + "FROM billing b "
            + "JOIN patients p ON b.patient_id = p.patient_id "
            + "JOIN treatments t ON b.treatment_id = t.treatment_id "
            + "WHERE CAST(b.bill_id AS CHAR) LIKE ? "
            + "OR b.payment_status LIKE ? "
            + "OR CAST(b.payment_date AS CHAR) LIKE ? "
            + "OR CAST(b.amount AS CHAR) LIKE ? "
            + "ORDER BY b.bill_id DESC";

      PreparedStatement ps =
              con.prepareStatement(sql);

      String search = "%" + keyword + "%";

      ps.setString(1, search);
      ps.setString(2, search);
      ps.setString(3, search);
      ps.setString(4, search);

      ResultSet rs = ps.executeQuery();

      while (rs.next()) {

          Billing bill = new Billing();

          bill.setBillId(
                  rs.getInt("bill_id")
          );

          bill.setPatientId(
                  rs.getInt("patient_id")
          );

          bill.setTreatmentId(
                  rs.getInt("treatment_id")
          );

          bill.setAmount(
                  rs.getDouble("amount")
          );

          bill.setPaymentStatus(
                  rs.getString("payment_status")
          );

          bill.setPaymentDate(
                  rs.getString("payment_date")
          );

          bill.setPatientName(
                  rs.getString("first_name")
                  + " "
                  + rs.getString("last_name")
          );

          bill.setTreatmentName(
                  rs.getString("treatment_name")
          );

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

//=========================
//UPDATE BILL
//=========================

public boolean updateBill(Billing bill) {

 boolean status = false;

 try {

     Connection con =
             DBConnection.getConnection();

     String sql =
             "UPDATE billing SET "
             + "patient_id=?, "
             + "treatment_id=?, "
             + "amount=?, "
             + "payment_status=?, "
             + "payment_date=? "
             + "WHERE bill_id=?";

     PreparedStatement ps =
             con.prepareStatement(sql);

     ps.setInt(
             1,
             bill.getPatientId()
     );

     ps.setInt(
             2,
             bill.getTreatmentId()
     );

     ps.setDouble(
             3,
             bill.getAmount()
     );

     ps.setString(
             4,
             bill.getPaymentStatus()
     );

     ps.setString(
             5,
             bill.getPaymentDate()
     );

     ps.setInt(
             6,
             bill.getBillId()
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


public Billing getBillByIdAndPatient(int billId, int patientId) {

    Billing bill = null;

    try {
        Connection con = DBConnection.getConnection();

        String sql =
                "SELECT b.*, p.first_name, p.last_name, " +
                "t.treatment_name " +
                "FROM billing b " +
                "JOIN patients p ON b.patient_id = p.patient_id " +
                "JOIN treatments t ON b.treatment_id = t.treatment_id " +
                "WHERE b.bill_id=? AND b.patient_id=?";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setInt(1, billId);
        ps.setInt(2, patientId);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {

            bill = new Billing();

            bill.setBillId(rs.getInt("bill_id"));
            bill.setPatientId(rs.getInt("patient_id"));
            bill.setTreatmentId(rs.getInt("treatment_id"));
            bill.setAmount(rs.getDouble("amount"));
            bill.setPaymentStatus(rs.getString("payment_status"));
            bill.setPaymentDate(rs.getString("payment_date"));

            bill.setPatientName(
                    rs.getString("first_name")
                    + " "
                    + rs.getString("last_name")
            );

            bill.setTreatmentName(
                    rs.getString("treatment_name")
            );
        }

        rs.close();
        ps.close();
        con.close();

    } catch (Exception e) {
        e.printStackTrace();
    }

    return bill;
}

public boolean payBill(int billId, int patientId) {

    boolean success = false;

    try {

        Connection con = DBConnection.getConnection();

        String sql = "UPDATE billing SET payment_status = 'Paid' "
                + "WHERE bill_id = ? AND patient_id = ?";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setInt(1, billId);
        ps.setInt(2, patientId);

        int rows = ps.executeUpdate();

        success = rows > 0;

        ps.close();
        con.close();

    } catch (Exception e) {

        e.printStackTrace();

    }

    return success;
}
}