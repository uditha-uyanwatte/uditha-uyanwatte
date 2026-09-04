package test;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.sql.Connection;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import util.DBConnection;

public class DBConnectionTest {

    @Test
    @DisplayName("Test database connection")
    void testDatabaseConnection() {

        Connection connection = DBConnection.getConnection();

        assertNotNull(
            connection,
            "Database connection should not be null"
        );
    }
}