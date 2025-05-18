<%@ page import="com.example.demo2.entities.Ticket, com.example.demo2.services.TicketService" %>
<%@ page import="java.util.List" %>
<%
    TicketService ticketService = new TicketService();
    List<Ticket> tickets = ticketService.getAllTickets();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ticket Management</title>
    <link rel="stylesheet" href="ticket-styles.css">
</head>
<body>
<div class="container">
    <header class="header">
        <h1><span class="ticket-icon">🎟</span> Manage Student Tickets</h1>
    </header>

    <% if ("updated".equals(request.getParameter("msg"))) { %>
    <div class="alert alert-success">
        <span class="alert-icon">✓</span> Ticket updated successfully!
    </div>
    <% } %>

    <div class="tickets-container">
        <% if (tickets.isEmpty()) { %>
        <div class="empty-state">
            <p>No tickets found.</p>
        </div>
        <% } else { %>
        <div class="tickets-list">
            <% for (Ticket t : tickets) { %>
            <div class="ticket-card">
                <div class="ticket-header">
                    <div class="ticket-id">ID: <%= t.getTicketId() %></div>
                    <div class="ticket-status <%= "solved".equals(t.getStatus()) ? "status-solved" : "status-pending" %>">
                        <%= t.getStatus().toUpperCase() %>
                    </div>
                </div>

                <div class="ticket-info">
                    <div class="info-row">
                        <span class="label">User:</span>
                        <span class="value"><%= t.getUsername() %></span>
                    </div>
                    <div class="info-row">
                        <span class="label">Category:</span>
                        <span class="value"><%= t.getCategory() %></span>
                    </div>
                    <div class="info-row message">
                        <span class="label">Message:</span>
                        <span class="value"><%= t.getMessage() %></span>
                    </div>
                </div>

                <form method="post" action="UpdateTicketServlet" class="ticket-form">
                    <input type="hidden" name="ticketId" value="<%= t.getTicketId() %>"/>

                    <div class="form-group">
                        <label for="status-<%= t.getTicketId() %>">Status</label>
                        <select id="status-<%= t.getTicketId() %>" name="status" class="form-control">
                            <option value="pending" <%= "pending".equals(t.getStatus()) ? "selected" : "" %>>Pending</option>
                            <option value="solved" <%= "solved".equals(t.getStatus()) ? "selected" : "" %>>Solved</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="comment-<%= t.getTicketId() %>">Admin Comment</label>
                        <textarea id="comment-<%= t.getTicketId() %>" name="adminComment" class="form-control"><%= t.getAdminComment() %></textarea>
                    </div>

                    <button type="submit" class="btn-update">Update Ticket</button>
                </form>
            </div>
            <% } %>
        </div>
        <% } %>
    </div>
</div>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>
