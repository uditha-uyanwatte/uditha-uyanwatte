package test;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import dao.BillingDAO;
import model.Billing;

public class BillingDaoTest {

    private BillingDAO billingDAO;

    @BeforeEach
    void setUp() {
        billingDAO = new BillingDAO();
    }

    @Test
    @DisplayName("Test retrieving all bills")
    void testGetAllBills() {

        List<Billing> bills = billingDAO.getAllBills();

        assertNotNull(
            bills,
            "Bill list should not be null"
        );
    }

    @Test
    @DisplayName("Test retrieving bill with invalid ID")
    void testGetBillWithInvalidId() {

        Billing bill = billingDAO.getBillById(-1);

        assertNull(
            bill,
            "Invalid bill ID should return null"
        );
    }

    @Test
    @DisplayName("Test retrieving bill with invalid appointment ID")
    void testGetBillWithInvalidAppointmentId() {

        Billing bill =
                billingDAO.getBillByAppointmentId(-1);

        assertNull(
            bill,
            "Invalid appointment ID should return null"
        );
    }
}