package test;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import dao.PatientDAO;
import model.Patient;

public class PatientDaoTest {

    private PatientDAO patientDAO;

    @BeforeEach
    void setUp() {
        patientDAO = new PatientDAO();
    }

    @Test
    @DisplayName("Test retrieving patient with invalid ID")
    void testGetPatientWithInvalidId() {

        Patient patient = patientDAO.getPatientById(-1);

        assertNull(
            patient,
            "Invalid patient ID should return null"
        );
    }
}