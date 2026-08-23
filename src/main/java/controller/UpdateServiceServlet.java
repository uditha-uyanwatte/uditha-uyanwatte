package controller;

import java.io.IOException;

import dao.ServiceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Service;

@WebServlet("/UpdateServiceServlet")
public class UpdateServiceServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final ServiceDAO dao = new ServiceDAO();

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        try {

            int serviceId =
                    Integer.parseInt(
                            request.getParameter("serviceId")
                    );

            String serviceName =
                    request.getParameter("serviceName");

            String description =
                    request.getParameter("description");

            double price =
                    Double.parseDouble(
                            request.getParameter("price")
                    );

            String duration =
                    request.getParameter("duration");

            String image =
                    request.getParameter("image");


            Service service = new Service();

            service.setServiceId(serviceId);
            service.setServiceName(serviceName);
            service.setDescription(description);
            service.setPrice(price);
            service.setDuration(duration);
            service.setImage(image);


            boolean status =
                    dao.updateService(service);


            if (status) {

                response.sendRedirect(
                        "services.jsp?updated=1"
                );

            } else {

                response.sendRedirect(
                        "services.jsp?error=update"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "services.jsp?error=update"
            );
        }
    }
}