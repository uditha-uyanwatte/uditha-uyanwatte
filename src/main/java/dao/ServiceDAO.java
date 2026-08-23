package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Service;
import util.DBConnection;

public class ServiceDAO {

    // =========================
    // ADD SERVICE
    // =========================
    public boolean addService(Service service) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql =
                    "INSERT INTO services "
                    + "(service_name, description, price, duration, image) "
                    + "VALUES (?, ?, ?, ?, ?)";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(
                    1,
                    service.getServiceName()
            );

            ps.setString(
                    2,
                    service.getDescription()
            );

            ps.setDouble(
                    3,
                    service.getPrice()
            );

            ps.setString(
                    4,
                    service.getDuration()
            );

            ps.setString(
                    5,
                    service.getImage()
            );

            status = ps.executeUpdate() > 0;

            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return status;
    }


    // =========================
    // GET ALL SERVICES
    // =========================
    public List<Service> getAllServices() {

        List<Service> list =
                new ArrayList<>();

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM services "
                    + "ORDER BY service_id DESC";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while (rs.next()) {

                Service service =
                        new Service();

                service.setServiceId(
                        rs.getInt("service_id")
                );

                service.setServiceName(
                        rs.getString("service_name")
                );

                service.setDescription(
                        rs.getString("description")
                );

                service.setPrice(
                        rs.getDouble("price")
                );

                service.setDuration(
                        rs.getString("duration")
                );

                service.setImage(
                        rs.getString("image")
                );

                list.add(service);
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
    // GET SERVICE BY ID
    // =========================
    public Service getServiceById(int id) {

        Service service = null;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM services "
                    + "WHERE service_id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, id);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                service =
                        new Service();

                service.setServiceId(
                        rs.getInt("service_id")
                );

                service.setServiceName(
                        rs.getString("service_name")
                );

                service.setDescription(
                        rs.getString("description")
                );

                service.setPrice(
                        rs.getDouble("price")
                );

                service.setDuration(
                        rs.getString("duration")
                );

                service.setImage(
                        rs.getString("image")
                );
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return service;
    }


    // =========================
    // UPDATE SERVICE
    // =========================
    public boolean updateService(Service service) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "UPDATE services SET "
                    + "service_name=?, "
                    + "description=?, "
                    + "price=?, "
                    + "duration=?, "
                    + "image=? "
                    + "WHERE service_id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(
                    1,
                    service.getServiceName()
            );

            ps.setString(
                    2,
                    service.getDescription()
            );

            ps.setDouble(
                    3,
                    service.getPrice()
            );

            ps.setString(
                    4,
                    service.getDuration()
            );

            ps.setString(
                    5,
                    service.getImage()
            );

            ps.setInt(
                    6,
                    service.getServiceId()
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


    // =========================
    // DELETE SERVICE
    // =========================
    public boolean deleteService(int id) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "DELETE FROM services "
                    + "WHERE service_id=?";

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


    // =========================
    // SEARCH SERVICES
    // =========================
    public List<Service> searchServices(
            String keyword
    ) {

        List<Service> list =
                new ArrayList<>();

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM services "
                    + "WHERE service_name LIKE ? "
                    + "OR description LIKE ? "
                    + "OR duration LIKE ? "
                    + "ORDER BY service_id DESC";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            String search =
                    "%" + keyword + "%";

            ps.setString(1, search);
            ps.setString(2, search);
            ps.setString(3, search);

            ResultSet rs =
                    ps.executeQuery();

            while (rs.next()) {

                Service service =
                        new Service();

                service.setServiceId(
                        rs.getInt("service_id")
                );

                service.setServiceName(
                        rs.getString("service_name")
                );

                service.setDescription(
                        rs.getString("description")
                );

                service.setPrice(
                        rs.getDouble("price")
                );

                service.setDuration(
                        rs.getString("duration")
                );

                service.setImage(
                        rs.getString("image")
                );

                list.add(service);
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