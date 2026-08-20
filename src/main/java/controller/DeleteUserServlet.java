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

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {

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

        try {

            int userId =
                    Integer.parseInt(
                            request.getParameter("id")
                    );


            // Prevent deleting own account

            if (userId == loggedUser.getId()) {

                response.sendRedirect(
                        "UserManagementServlet?error=selfdelete"
                );

                return;
            }


            boolean success =
                    userDAO.deleteUser(userId);


            if (success) {

                response.sendRedirect(
                        "UserManagementServlet?deleted=true"
                );

            } else {

                response.sendRedirect(
                        "UserManagementServlet?error=failed"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "UserManagementServlet?error=failed"
            );
        }
    }
}