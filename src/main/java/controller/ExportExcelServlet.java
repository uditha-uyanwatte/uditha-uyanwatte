package controller;

import java.io.IOException;

import dao.ReportsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jxl.Workbook;
import jxl.write.Label;
import jxl.write.Number;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import model.Report;

@WebServlet("/ExportExcelServlet")
public class ExportExcelServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        ReportsDAO dao = new ReportsDAO();
        Report report = dao.getDashboardReport();

        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition",
                "attachment; filename=Sunrise_Dental_Report.xls");

        try {

            WritableWorkbook workbook =
                    Workbook.createWorkbook(response.getOutputStream());

            WritableSheet sheet =
                    workbook.createSheet("Clinic Report", 0);

            sheet.addCell(new Label(0, 0,
                    "SUNRISE DENTAL CLINIC"));

            sheet.addCell(new Label(0, 1,
                    "Management System Report"));

            sheet.addCell(new Label(0, 3,
                    "Total Patients"));
            sheet.addCell(new Number(1, 3,
                    report.getTotalPatients()));

            sheet.addCell(new Label(0, 4,
                    "Total Appointments"));
            sheet.addCell(new Number(1, 4,
                    report.getTotalAppointments()));

            sheet.addCell(new Label(0, 5,
                    "Total Treatments"));
            sheet.addCell(new Number(1, 5,
                    report.getTotalTreatments()));

            sheet.addCell(new Label(0, 6,
                    "Paid Bills"));
            sheet.addCell(new Number(1, 6,
                    report.getPaidBills()));

            sheet.addCell(new Label(0, 7,
                    "Pending Bills"));
            sheet.addCell(new Number(1, 7,
                    report.getPendingBills()));

            sheet.addCell(new Label(0, 8,
                    "Total Revenue"));
            sheet.addCell(new Number(1, 8,
                    report.getTotalRevenue()));

            workbook.write();
            workbook.close();

        } catch (Exception e) {

            throw new ServletException(e);

        }

    }
}