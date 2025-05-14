
package com.example.demo2.Controllers;

import com.example.demo2.services.AdminService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AdminLoginServlet extends HttpServlet {
    private final AdminService adminService = new AdminService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String adminUsername = request.getParameter("adminUsername").trim();
        String adminPassword = request.getParameter("adminPassword").trim();

        if (adminService.authenticateAdmin(adminUsername, adminPassword)) {
            HttpSession session = request.getSession(true);
            session.setAttribute("adminUsername", adminUsername);
            response.sendRedirect("adminDashboard.jsp");
        } else {
            response.sendRedirect("adminLogin.jsp?error=1");
        }
    }
}
