
package com.example.demo2.Controllers;

import com.example.demo2.entities.User;
import com.example.demo2.services.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class SignupServlet extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String nic = request.getParameter("nic");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (userService.usernameExists(username)) {
            response.sendRedirect("signup.jsp?error=1");
        } else {
            User user = new User(username, password, name, email, nic);
            userService.createUser(user);
            response.sendRedirect("index.jsp");
        }
    }
}
