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

@WebServlet("/UpdateUserRoleServlet")
public class UpdateUserRoleServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

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

            int userId =
                    Integer.parseInt(
                            request.getParameter(
                                    "userId"
                            )
                    );

            String role =
                    request.getParameter("role");


            // =========================
            // VALID ROLE CHECK
            // =========================

            if (!"PATIENT".equalsIgnoreCase(role) &&
                !"DENTIST".equalsIgnoreCase(role) &&
                !"RECEPTIONIST".equalsIgnoreCase(role) &&
                !"ADMIN".equalsIgnoreCase(role)) {

                response.sendRedirect(
                        "UserManagementServlet?error=role"
                );

                return;
            }


            // =========================
            // PREVENT SELF ROLE CHANGE
            // =========================

            if (userId == loggedUser.getId()) {

                response.sendRedirect(
                        "UserManagementServlet?error=self"
                );

                return;
            }


            boolean success =
                    userDAO.updateUserRole(
                            userId,
                            role.toUpperCase()
                    );


            if (success) {

                response.sendRedirect(
                        "UserManagementServlet?updated=true"
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