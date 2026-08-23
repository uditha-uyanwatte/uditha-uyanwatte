package controller;

import java.io.IOException;

import dao.ServiceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Service;

@WebServlet("/AddServiceServlet")
public class AddServiceServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    ServiceDAO dao = new ServiceDAO();

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        // Get form values
        String serviceName =
                request.getParameter("serviceName");

        String description =
                request.getParameter("description");

        String priceValue =
                request.getParameter("price");

        String duration =
                request.getParameter("duration");

        String image =
                request.getParameter("image");


        // Create Service Object
        Service service =
                new Service();

        service.setServiceName(serviceName);
        service.setDescription(description);
        service.setDuration(duration);
        service.setImage(image);


        // Convert price
        try {

            double price =
                    Double.parseDouble(priceValue);

            service.setPrice(price);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "services.jsp?error=price"
            );

            return;
        }


        // Save Service
        boolean status =
                dao.addService(service);


        if (status) {

            response.sendRedirect(
                    "services.jsp?success=1"
            );

        } else {

            response.sendRedirect(
                    "services.jsp?error=1"
            );
        }
    }
}