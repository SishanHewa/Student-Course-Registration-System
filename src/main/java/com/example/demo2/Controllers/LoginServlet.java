
package com.example.demo2.Controllers;

import com.example.demo2.entities.User;
import com.example.demo2.services.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class LoginServlet extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username").trim();
        String password = request.getParameter("password").trim();

        if (userService.authenticate(username, password)) {
            String[] details = userService.getUserDetails(username);
            HttpSession session = request.getSession(true);
            session.setAttribute("loggedUsername", username);
            if (details != null) {
                session.setAttribute("loggedName", details[0]);
                session.setAttribute("loggedEmail", details[1]);
                session.setAttribute("loggedNic", details[2]);
            }

            String currentStatus = userService.getUserStatus(username);
            if (currentStatus == null) {
                response.sendRedirect("userForm.jsp");
            } else {
                switch (currentStatus.trim().toLowerCase()) {
                    case "pending" -> response.sendRedirect("pending.jsp");
                    case "registered" -> response.sendRedirect("ProfileServlet");
                    default -> response.sendRedirect("userForm.jsp");
                }
            }
        } else {
            response.sendRedirect("index.jsp?error=1");
        }
    }
}
