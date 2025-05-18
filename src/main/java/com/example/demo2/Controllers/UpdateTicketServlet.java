package com.example.demo2.Controllers;

import com.example.demo2.services.TicketService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

    @WebServlet("/UpdateTicketServlet")
    public class UpdateTicketServlet extends HttpServlet {
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String ticketId = request.getParameter("ticketId");
            String status = request.getParameter("status");
            String comment = request.getParameter("adminComment");

            TicketService service = new TicketService();
            service.updateTicket(ticketId, status, comment);

            response.sendRedirect("adminDashboard.jsp?tab=tickets&msg=updated");
        }
    }


