package controller;

import java.io.IOException;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    UserDAO dao = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = dao.login(username, password);

        if (user != null) {

            HttpSession session = request.getSession();

            session.setAttribute("user", user);
            session.setAttribute("username", user.getUsername());
            session.setAttribute("fullName", user.getFullName());
            session.setAttribute("role", user.getRole());

            String role = user.getRole();

            if ("ADMIN".equalsIgnoreCase(role)) {

                response.sendRedirect("dashboard.jsp");

            } else if ("RECEPTIONIST".equalsIgnoreCase(role)) {

                response.sendRedirect("receptionist-dashboard.jsp");

            } else if ("PATIENT".equalsIgnoreCase(role)) {

                response.sendRedirect("user-dashboard.jsp");

            } else {

                request.setAttribute(
                    "error",
                    "Invalid user role"
                );

                request.getRequestDispatcher(
                    "login.jsp"
                ).forward(request, response);
            }

        } else {

            request.setAttribute("error", "Invalid Username or Password");
            request.getRequestDispatcher("login.jsp").forward(request, response);

        }

    }
}