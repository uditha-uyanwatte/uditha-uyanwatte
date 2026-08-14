package controller;

import dao.SettingsDAO;
import model.Settings;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.annotation.WebServlet;
@WebServlet("/UpdateSettingsServlet")
public class UpdateSettingsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Settings settings = new Settings();

        // Primary key (settings table එකේ row එක)
        settings.setId(Integer.parseInt(request.getParameter("id")));

        // ==========================
        // Clinic Information
        // ==========================

        settings.setClinicName(request.getParameter("clinicName"));
        settings.setClinicTagline(request.getParameter("clinicTagline"));
        settings.setAddress(request.getParameter("address"));
        settings.setPhone(request.getParameter("phone"));
        settings.setEmail(request.getParameter("email"));
        settings.setWebsite(request.getParameter("website"));
        settings.setWorkingHours(request.getParameter("workingHours"));

        // ==========================
        // Admin Information
        // ==========================

        settings.setAdminName(request.getParameter("adminName"));
        settings.setUsername(request.getParameter("username"));
        settings.setAdminEmail(request.getParameter("adminEmail"));

        // ==========================
        // Appearance
        // ==========================

        settings.setTheme(request.getParameter("theme"));
        settings.setAccentColor(request.getParameter("accentColor"));

        // ==========================
        // System
        // ==========================

        settings.setLanguage(request.getParameter("language"));
        settings.setCurrency(request.getParameter("currency"));

        String notifications = request.getParameter("notifications");

        settings.setNotifications(notifications != null);

        SettingsDAO dao = new SettingsDAO();

        System.out.println("ID = " + settings.getId());
        System.out.println("Clinic = " + settings.getClinicName());
        System.out.println("Theme = " + settings.getTheme());

        boolean clinic = dao.updateClinicInfo(settings);
        System.out.println("Clinic Update = " + clinic);

        boolean admin = dao.updateAdminProfile(settings);
        System.out.println("Admin Update = " + admin);

        boolean appearance = dao.updateAppearance(settings);
        System.out.println("Appearance Update = " + appearance);

        boolean system = dao.updateSystem(settings);
        System.out.println("System Update = " + system);
        
        // Theme එක Session එකට Save කරනවා
        session.setAttribute("theme", settings.getTheme());

        if(clinic || admin || appearance || system){

            response.sendRedirect("settings.jsp?success");

        }else{

            response.sendRedirect("settings.jsp?error");

        }

    }

}