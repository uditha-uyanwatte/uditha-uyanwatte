package controller;

import java.io.IOException;

import dao.ServiceDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteServiceServlet")
public class DeleteServiceServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final ServiceDAO dao = new ServiceDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws IOException {

        try {

            int id =
                    Integer.parseInt(
                            request.getParameter("id")
                    );

            boolean status =
                    dao.deleteService(id);


            if (status) {

                response.sendRedirect(
                        "services.jsp?deleted=1"
                );

            } else {

                response.sendRedirect(
                        "services.jsp?error=delete"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "services.jsp?error=delete"
            );
        }
    }
}