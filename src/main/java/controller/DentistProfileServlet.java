package controller;

import java.io.IOException;

import dao.DentistDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Dentist;
import model.User;

@WebServlet("/DentistProfileServlet")
public class DentistProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private DentistDAO dao = new DentistDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // =========================
        // LOGIN CHECK
        // =========================

        Object userObject =
                session.getAttribute("user");

        if (userObject == null) {

            response.sendRedirect("login.jsp");

            return;
        }

        try {

            // =========================
            // GET LOGGED USER
            // =========================

            User user = (User) userObject;

            int userId = user.getId();


            // =========================
            // GET DENTIST
            // =========================

            Dentist dentist =
                    dao.getDentistByUserId(userId);


            // =========================
            // DENTIST NOT FOUND
            // =========================

            if (dentist == null) {

                response.sendRedirect(
                        "dentist-dashboard.jsp?error=profile"
                );

                return;
            }


            // =========================
            // SEND TO JSP
            // =========================

            request.setAttribute(
                    "dentist",
                    dentist
            );


            request.getRequestDispatcher(
                    "dentist-profile.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "dentist-dashboard.jsp?error=profile"
            );
        }
    }
}