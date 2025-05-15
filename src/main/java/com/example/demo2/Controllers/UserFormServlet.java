
package com.example.demo2.Controllers;

import com.example.demo2.entities.AcademicInfo;
import com.example.demo2.entities.PersonalInfo;
import com.example.demo2.services.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class UserFormServlet extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUsername") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        String username = (String) session.getAttribute("loggedUsername");
        PersonalInfo personalInfo = new PersonalInfo(
                username,
                request.getParameter("address"),
                request.getParameter("email"),
                request.getParameter("phone"),
                request.getParameter("nic"),
                request.getParameter("dob"),
                request.getParameter("gender"),
                request.getParameter("nationality"),
                request.getParameter("name")
        );

        AcademicInfo academicInfo = new AcademicInfo(
                username,
                request.getParameter("school"),
                request.getParameter("stream"),
                request.getParameter("passedSubjects")
        );

        userService.savePersonalInfo(personalInfo);
        userService.saveAcademicInfo(academicInfo);
        userService.setUserStatus(username, "pending");
        userService.recordRegistrationTime(username);

        response.sendRedirect("pending.jsp");
    }
}