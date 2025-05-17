<%@ page import="com.example.demo2.entities.Ticket, com.example.demo2.services.TicketService" %>
<%@ page import="java.util.List" %>
<%
  String username = (String) session.getAttribute("loggedUsername");
  TicketService ticketService = new TicketService();
  List<Ticket> tickets = ticketService.getTicketsByUser(username);
%>
<div class="tickets-container">
  <div class="tickets-header">
    <h2><i class="ticket-icon">🎫</i> My Tickets</h2>
  </div>

  <% if (tickets.isEmpty()) { %>
  <div class="empty-state">
    <p>You haven't submitted any tickets yet.</p>
  </div>
  <% } else { %>
  <div class="tickets-list">
    <% for (Ticket t : tickets) { %>
    <div class="ticket-card">
      <div class="ticket-header">
        <span class="ticket-id">Ticket #<%= t.getTicketId() %></span>
        <span class="ticket-status status-<%= t.getStatus().toLowerCase() %>"><%= t.getStatus() %></span>
      </div>
      <div class="ticket-body">
        <div class="ticket-row">
          <span class="ticket-label">Category:</span>
          <span class="ticket-value"><%= t.getCategory() %></span>
        </div>
        <div class="ticket-row">
          <span class="ticket-label">Message:</span>
          <span class="ticket-value message"><%= t.getMessage() %></span>
        </div>
        <div class="ticket-row">
          <span class="ticket-label">Admin Comment:</span>
          <span class="ticket-value admin-comment"><%= t.getAdminComment() %></span>
        </div>
      </div>
    </div>
    <% } %>
  </div>
  <% } %>
</div>
<link rel="stylesheet" href="css/myTickets.css">

