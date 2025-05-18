
package com.example.demo2.controllers;

import com.example.demo2.entities.Admin;
import com.example.demo2.services.AdminService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AddNewAdminServlet extends HttpServlet {
    private final AdminService adminService = new AdminService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String newAdminUsername = request.getParameter("adminUsername").trim();
        String newAdminPassword = request.getParameter("adminPassword").trim();
        String newAdminRole = request.getParameter("adminRole").trim();
        String currentAdminPassword = request.getParameter("currentAdminPassword").trim();

        HttpSession session = request.getSession(false);
        String currentAdminUsername = (String) session.getAttribute("adminUsername");

        if (!adminService.authenticateAdmin(currentAdminUsername, currentAdminPassword)) {
            request.setAttribute("errorMessage", "Your password is incorrect.");
            request.getRequestDispatcher("addNewAdmin.jsp").forward(request, response);
            return;
        }

        if (adminService.adminUsernameExists(newAdminUsername)) {
            request.setAttribute("errorMessage", "New admin username already exists.");
            request.getRequestDispatcher("addNewAdmin.jsp").forward(request, response);
            return;
        }

        adminService.createAdmin(new Admin(newAdminUsername, newAdminPassword, newAdminRole));
        response.sendRedirect("adminDashboard.jsp?tab=admins");
    }
}

