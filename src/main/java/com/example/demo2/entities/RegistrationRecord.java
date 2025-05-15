package com.example.demo2.entities;

import java.time.LocalDateTime;

public class RegistrationRecord {
    private String username;
    private LocalDateTime registrationTime;

    public RegistrationRecord(String username, LocalDateTime registrationTime) {
        this.username = username;
        this.registrationTime = registrationTime;
    }

    public String getUsername() { return username; }
    public LocalDateTime getRegistrationTime() { return registrationTime; }
}
