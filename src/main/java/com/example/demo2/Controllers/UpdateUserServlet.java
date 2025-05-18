package com.example.demo2.Controllers;

import com.example.demo2.services.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class UpdateUserServlet extends HttpServlet {
    UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String nic = request.getParameter("nic");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String nationality = request.getParameter("nationality");
        String school = request.getParameter("school");
        String stream = request.getParameter("stream");
        String passedSubjects = request.getParameter("passedSubjects");

        String personalInfoLine = String.join(",", username, address, email, phone,
                nic, dob, gender, nationality, name);
        String academicInfoLine = String.join(",", username, school, stream, passedSubjects);
        String userDetailsLine = String.join(",", name, email, nic, username);

        userService.updatePersonalInfo(username, personalInfoLine);
        userService.updateAcademicInfo(username, academicInfoLine);
        userService.updateUserDetails(username, userDetailsLine);

        response.sendRedirect("adminUserDetails.jsp?username=" + username);
    }
}
