package test;

import static org.junit.jupiter.api.Assertions.*;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import dao.AppointmentDAO;
import model.Appointment;

public class AppointmentDaoTest {

    private AppointmentDAO appointmentDAO;

    @BeforeEach
    void setUp() {
        appointmentDAO = new AppointmentDAO();
    }

    @Test
    @DisplayName("Test retrieving all appointments")
    void testGetAllAppointments() {

        List<Appointment> appointments =
                appointmentDAO.getAllAppointments();

        assertNotNull(
            appointments,
            "Appointment list should not be null"
        );
    }

    @Test
    @DisplayName("Test retrieving appointment with invalid ID")
    void testGetAppointmentWithInvalidId() {

        Appointment appointment =
                appointmentDAO.getAppointmentById(-1);

        assertNull(
            appointment,
            "Invalid appointment ID should return null"
        );
    }
}