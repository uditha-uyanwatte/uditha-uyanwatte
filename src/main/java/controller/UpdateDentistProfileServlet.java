package controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

import dao.DentistDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import model.Dentist;

@WebServlet("/UpdateDentistProfileServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
public class UpdateDentistProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private DentistDAO dao =
            new DentistDAO();

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session =
                request.getSession();

        if (session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");

            return;
        }

        try {

            int dentistId =
                    Integer.parseInt(
                            request.getParameter(
                                    "dentistId"
                            )
                    );

            Dentist dentist =
                    dao.getDentistById(
                            dentistId
                    );

            if (dentist == null) {

                response.sendRedirect(
                        "DentistProfileServlet?error=profile"
                );

                return;
            }


            // =========================
            // BASIC DETAILS
            // =========================

            dentist.setFirstName(
                    request.getParameter(
                            "firstName"
                    )
            );

            dentist.setLastName(
                    request.getParameter(
                            "lastName"
                    )
            );

            dentist.setSpecialization(
                    request.getParameter(
                            "specialization"
                    )
            );

            dentist.setPhone(
                    request.getParameter(
                            "phone"
                    )
            );

            dentist.setEmail(
                    request.getParameter(
                            "email"
                    )
            );


            // =========================
            // PROFILE IMAGE
            // =========================

            Part imagePart =
                    request.getPart(
                            "profileImage"
                    );

            if (imagePart != null &&
                imagePart.getSize() > 0) {

                String contentType =
                        imagePart.getContentType();

                if (!contentType.equals(
                        "image/jpeg") &&
                    !contentType.equals(
                        "image/png") &&
                    !contentType.equals(
                        "image/webp")) {

                    response.sendRedirect(
                            "DentistProfileServlet?error=invalidImage"
                    );

                    return;
                }


                // =========================
                // FILE EXTENSION
                // =========================

                String extension =
                        ".jpg";

                if (contentType.equals(
                        "image/png")) {

                    extension = ".png";

                } else if (
                        contentType.equals(
                                "image/webp")) {

                    extension = ".webp";
                }


                // =========================
                // UNIQUE FILE NAME
                // =========================

                String fileName =
                        "dentist_"
                        + dentistId
                        + "_"
                        + UUID.randomUUID()
                        + extension;


                // =========================
                // UPLOAD DIRECTORY
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

                File imageFile =
                        new File(
                                uploadDirectory,
                                fileName
                        );

                Files.copy(
                        imagePart.getInputStream(),
                        imageFile.toPath(),
                        StandardCopyOption.REPLACE_EXISTING
                );


                // =========================
                // SAVE FILE NAME TO DB
                // =========================

                dentist.setProfileImage(
                        fileName
                );
            }


            // =========================
            // UPDATE DATABASE
            // =========================

            boolean updated =
                    dao.updateDentistProfile(
                            dentist
                    );


            if (updated) {

                // Update session name
                session.setAttribute(
                        "fullName",
                        dentist.getFirstName()
                        + " "
                        + dentist.getLastName()
                );

                response.sendRedirect(
                        "DentistProfileServlet?success=1"
                );

            } else {

                response.sendRedirect(
                        "DentistProfileServlet?error=update"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "DentistProfileServlet?error=update"
            );
        }
    }
}