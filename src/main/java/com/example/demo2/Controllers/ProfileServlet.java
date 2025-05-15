package com.example.demo2.Controllers;

import com.example.demo2.entities.AcademicInfo;
import com.example.demo2.entities.PersonalInfo;
import com.example.demo2.services.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class ProfileServlet extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUsername") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        String username = (String) session.getAttribute("loggedUsername");
        PersonalInfo pInfo = userService.getPersonalInfo(username);
        AcademicInfo aInfo = userService.getAcademicInfo(username);

        request.setAttribute("personalInfo", pInfo);
        request.setAttribute("academicInfo", aInfo);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}
