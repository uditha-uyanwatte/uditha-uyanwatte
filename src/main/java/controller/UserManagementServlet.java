package controller;

import java.io.IOException;
import java.util.List;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet("/UserManagementServlet")
public class UserManagementServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        User loggedUser =
                (User) session.getAttribute("user");

        if (!"ADMIN".equalsIgnoreCase(
                loggedUser.getRole())) {

            response.sendRedirect("login.jsp");
            return;
        }

        String keyword =
                request.getParameter("search");

        List<User> users;

        if (keyword != null &&
            !keyword.trim().isEmpty()) {

            users =
                    userDAO.searchUsers(keyword);

        } else {

            users =
                    userDAO.getAllUsers();
        }

        request.setAttribute(
                "users",
                users
        );

        request.setAttribute(
                "keyword",
                keyword
        );

        request.getRequestDispatcher(
                "user-management.jsp"
        ).forward(
                request,
                response
        );
    }
}