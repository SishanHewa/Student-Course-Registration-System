
package com.example.demo2.Controllers;

import com.example.demo2.services.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AcceptStudentServlet extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        userService.updateUserStatus(username, "registered");
        response.sendRedirect("adminDashboard.jsp");
    }
}

