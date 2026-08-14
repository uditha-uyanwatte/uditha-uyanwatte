package controller;

import java.io.IOException;

import dao.ReportsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Report;

@WebServlet("/ReportsServlet")
public class ReportsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ReportsDAO reportsDAO;

    @Override
    public void init() throws ServletException {
        reportsDAO = new ReportsDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");

        Report report;

        if (fromDate != null && !fromDate.isEmpty()
                && toDate != null && !toDate.isEmpty()) {

            report = reportsDAO.getDashboardReport(fromDate, toDate);

        } else {

            report = reportsDAO.getDashboardReport();

        }

        request.setAttribute("report", report);

        if (fromDate != null && !fromDate.isEmpty()
                && toDate != null && !toDate.isEmpty()) {

            report = reportsDAO.getDashboardReport(fromDate, toDate);

            request.setAttribute("revenueData",
                    reportsDAO.getMonthlyRevenue(fromDate, toDate));

            request.setAttribute("statusData",
                    reportsDAO.getAppointmentStatusCount(fromDate, toDate));

        } else {

            report = reportsDAO.getDashboardReport();

            request.setAttribute("revenueData",
                    reportsDAO.getMonthlyRevenue());

            request.setAttribute("statusData",
                    reportsDAO.getAppointmentStatusCount());

        }

        request.setAttribute("report", report);

        request.getRequestDispatcher("/reports.jsp")
               .forward(request, response);
        }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);

    }
}