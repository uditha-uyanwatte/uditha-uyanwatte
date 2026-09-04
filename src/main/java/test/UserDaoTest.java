package test;

import dao.UserDAO;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

public class UserDaoTest {

    private UserDAO userDAO;

    @BeforeEach
    void setUp() {
        userDAO = new UserDAO();
    }

    @Test
    @DisplayName("Test login with incorrect credentials should return null")
    void testLoginWithIncorrectCredentials() {

        UserDAO userDAO = new UserDAO();

        assertNull(
            userDAO.login("invalid_test_user", "wrong_password"),
            "Invalid credentials should return null"
        );
    }
}