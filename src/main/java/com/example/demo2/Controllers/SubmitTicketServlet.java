package com.example.demo2.Controllers;

import com.example.demo2.entities.Ticket;
import com.example.demo2.services.TicketService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.UUID;

@WebServlet("/SubmitTicketServlet")
public class SubmitTicketServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String username = (String) session.getAttribute("loggedUsername");

        String category = request.getParameter("category");
        String message = request.getParameter("message");

        String ticketId = UUID.randomUUID().toString();
        Ticket ticket = new Ticket(ticketId, username, category, message, "pending", "-");

        TicketService service = new TicketService();
        service.submitTicket(ticket);

        response.sendRedirect("profile.jsp?tab=tickets&msg=created");
    }
}
