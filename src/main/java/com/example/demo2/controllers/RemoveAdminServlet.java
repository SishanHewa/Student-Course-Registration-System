
package com.example.demo2.controllers;

import com.example.demo2.services.AdminService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class RemoveAdminServlet extends HttpServlet {
    private final AdminService adminService = new AdminService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String usernameToRemove = request.getParameter("usernameToRemove").trim();
        String currentAdminPassword = request.getParameter("currentAdminPassword").trim();
        HttpSession session = request.getSession(false);
        String currentAdminUsername = (String) session.getAttribute("adminUsername");

        if (!adminService.authenticateAdmin(currentAdminUsername, currentAdminPassword)) {
            request.setAttribute("errorMessage", "Your password is incorrect.");
            request.getRequestDispatcher("removeAdmin.jsp?usernameToRemove=" + usernameToRemove).forward(request, response);
            return;
        }

        adminService.removeAdmin(usernameToRemove);
        response.sendRedirect("adminDashboard.jsp?tab=admins");
    }
}
