package controller;

import java.io.IOException;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    UserDAO dao = new UserDAO();


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        // =========================
        // GET FORM DATA
        // =========================

        String fullName =
                request.getParameter("fullName");

        String email =
                request.getParameter("email");

        String phone =
                request.getParameter("phone");

        String username =
                request.getParameter("username");

        String password =
                request.getParameter("password");

        String confirmPassword =
                request.getParameter("confirmPassword");


        // =========================
        // BASIC VALIDATION
        // =========================

        if (fullName == null ||
                fullName.trim().isEmpty() ||

                email == null ||
                email.trim().isEmpty() ||

                phone == null ||
                phone.trim().isEmpty() ||

                username == null ||
                username.trim().isEmpty() ||

                password == null ||
                password.isEmpty() ||

                confirmPassword == null ||
                confirmPassword.isEmpty()) {

            response.sendRedirect(
                    "user-register.jsp?error=empty"
            );

            return;
        }


        // =========================
        // PASSWORD CHECK
        // =========================

        if (!password.equals(confirmPassword)) {

            response.sendRedirect(
                    "user-register.jsp?error=password"
            );

            return;
        }


        // =========================
        // USERNAME CHECK
        // =========================

        if (dao.usernameExists(username)) {

            response.sendRedirect(
                    "user-register.jsp?error=exists"
            );

            return;
        }


        // =========================
        // EMAIL CHECK
        // =========================

        if (dao.emailExists(email)) {

            response.sendRedirect(
                    "user-register.jsp?error=email"
            );

            return;
        }


        // =========================
        // CREATE USER OBJECT
        // =========================

        User user = new User();

        user.setFullName(fullName);

        user.setEmail(email);

        user.setPhone(phone);

        user.setUsername(username);

        user.setPassword(password);

        // Every new registered user
        // is a patient

        user.setRole("PATIENT");


        // =========================
        // REGISTER USER
        // =========================

        boolean success =
                dao.register(user);


        // =========================
        // RESULT
        // =========================

        if (success) {

            response.sendRedirect(
                    "login.jsp?registered=true"
            );

        } else {

            response.sendRedirect(
                    "user-register.jsp?error=failed"
            );

        }

    }

}