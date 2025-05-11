package com.example.demo2.entities;

public class User {
    private String username;
    private String password;
    private String name;
    private String email;
    private String nic;

    public User(String username, String password, String name, String email, String nic) {
        this.username = username;
        this.password = password;
        this.name = name;
        this.email = email;
        this.nic = nic;
    }

    public String getUsername() { return username; }
    public String getPassword() { return password; }
    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getNic() {return nic;}
}