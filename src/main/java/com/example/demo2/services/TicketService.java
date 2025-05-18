package com.example.demo2.services;

import com.example.demo2.entities.Ticket;
import com.example.demo2.utils.FileManager;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class TicketService {
    private final String FILE_PATH = "data/tickets.txt";
    private final FileManager fileManager = new FileManager();

    public void submitTicket(Ticket ticket) throws IOException {
        String record = String.join(",", ticket.getTicketId(), ticket.getUsername(), ticket.getCategory(),
                ticket.getMessage().replace(",", " "), ticket.getStatus(), ticket.getAdminComment());
        fileManager.appendLine(FILE_PATH, record);
    }

    public List<Ticket> getAllTickets() throws IOException {
        List<Ticket> tickets = new ArrayList<>();
        for (String line : fileManager.readLines(FILE_PATH)) {
            String[] parts = line.split(",", 6);
            if (parts.length == 6) {
                tickets.add(new Ticket(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5]));
            }
        }
        return tickets;
    }

    public List<Ticket> getTicketsByUser(String username) throws IOException {
        List<Ticket> all = getAllTickets();
        List<Ticket> userTickets = new ArrayList<>();
        for (Ticket t : all) {
            if (t.getUsername().equalsIgnoreCase(username)) {
                userTickets.add(t);
            }
        }
        return userTickets;
    }

    public void updateTicket(String ticketId, String newStatus, String adminComment) throws IOException {
        List<String> updated = new ArrayList<>();
        for (Ticket t : getAllTickets()) {
            if (t.getTicketId().equals(ticketId)) {
                t.setStatus(newStatus);
                t.setAdminComment(adminComment);
            }
            String line = String.join(",", t.getTicketId(), t.getUsername(), t.getCategory(),
                    t.getMessage().replace(",", " "), t.getStatus(), t.getAdminComment());
            updated.add(line);
        }
        fileManager.writeLines(FILE_PATH, updated);
    }
}
