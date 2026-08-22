package controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.UUID;

import dao.DentistDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Dentist;

@WebServlet("/AddDentistServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
public class AddDentistServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private DentistDAO dao = new DentistDAO();

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {

            // =========================
            // GET FORM DATA
            // =========================

            String firstName =
                    request.getParameter("firstName");

            String lastName =
                    request.getParameter("lastName");

            String specialization =
                    request.getParameter("specialization");

            String phone =
                    request.getParameter("phone");

            String email =
                    request.getParameter("email");


            // =========================
            // GET PROFILE IMAGE
            // =========================

            Part imagePart =
                    request.getPart("profileImage");


            String imageName =
                    "doctor-default.jpg";


            // =========================
            // IMAGE UPLOAD
            // =========================

            if (imagePart != null
                    && imagePart.getSize() > 0) {

                String originalFileName =
                        Paths.get(
                                imagePart
                                        .getSubmittedFileName()
                        ).getFileName()
                         .toString();


                // Get file extension

                String extension = "";

                int dotIndex =
                        originalFileName.lastIndexOf(".");

                if (dotIndex >= 0) {

                    extension =
                            originalFileName
                                    .substring(dotIndex)
                                    .toLowerCase();

                }


                // Allow only image extensions

                if (!extension.equals(".jpg")
                        && !extension.equals(".jpeg")
                        && !extension.equals(".png")
                        && !extension.equals(".webp")) {

                    response.sendRedirect(
                            "dentists.jsp?error=invalidImage"
                    );

                    return;
                }


                // Generate unique filename

                imageName =
                        "dentist_"
                        + UUID.randomUUID()
                        + extension;


                // =========================
                // IMAGE DIRECTORY
                // =========================

                String uploadPath =
                        getServletContext()
                                .getRealPath(
                                        "/assets/images/doctors"
                                );


                File uploadDirectory =
                        new File(uploadPath);


                if (!uploadDirectory.exists()) {

                    uploadDirectory.mkdirs();

                }


                // =========================
                // SAVE IMAGE
                // =========================

                String filePath =
                        uploadPath
                        + File.separator
                        + imageName;


                imagePart.write(filePath);
            }


            // =========================
            // CREATE DENTIST
            // =========================

            Dentist dentist =
                    new Dentist();

            dentist.setFirstName(firstName);

            dentist.setLastName(lastName);

            dentist.setSpecialization(
                    specialization
            );

            dentist.setPhone(phone);

            dentist.setEmail(email);

            dentist.setProfileImage(
                    imageName
            );


            // =========================
            // SAVE TO DATABASE
            // =========================

            boolean success =
                    dao.addDentist(dentist);


            // =========================
            // REDIRECT
            // =========================

            if (success) {

                response.sendRedirect(
                        "dentists.jsp?success=1"
                );

            } else {

                response.sendRedirect(
                        "dentists.jsp?error=add"
                );

            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "dentists.jsp?error=exception"
            );
        }
    }
}