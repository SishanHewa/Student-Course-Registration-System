package com.example.demo2.entities;

    public class Ticket {
        private String ticketId;
        private String username;
        private String category;
        private String message;
        private String status; // pending, solved
        private String adminComment;

        public Ticket(String ticketId, String username, String category, String message, String status, String adminComment) {
            this.ticketId = ticketId;
            this.username = username;
            this.category = category;
            this.message = message;
            this.status = status;
            this.adminComment = adminComment;
        }

        public String getTicketId() { return ticketId; }
        public String getUsername() { return username; }
        public String getCategory() { return category; }
        public String getMessage() { return message; }
        public String getStatus() { return status; }
        public String getAdminComment() { return adminComment; }

        public void setStatus(String status) { this.status = status; }
        public void setAdminComment(String adminComment) { this.adminComment = adminComment; }
    }