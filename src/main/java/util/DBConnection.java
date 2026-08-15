package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
            "jdbc:mysql://localhost:3306/sunrise_dental_clinic?useSSL=false&serverTimezone=Asia/Colombo";

    private static final String USER = "root";

    private static final String PASSWORD = "Uditha@3033";

    public static Connection getConnection() {

        Connection con = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(URL, USER, PASSWORD);

            System.out.println("Database Connected Successfully!");
            System.out.println("Connected Database = " + con.getCatalog());

        } catch (ClassNotFoundException | SQLException e) {

            e.printStackTrace();

        }

        return con;
    }
    }
