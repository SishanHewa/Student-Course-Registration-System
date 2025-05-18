
package com.example.demo2.services;

import com.example.demo2.entities.Admin;
import com.example.demo2.utils.FileManager;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class AdminService {
    private final FileManager fileManager = new FileManager();
    private final String ADMIN_CREDENTIALS_PATH = "/Users/sishanhewapathirana/admin_credentials.txt";

    public boolean authenticateAdmin(String username, String password) throws IOException {
        return fileManager.readLines(ADMIN_CREDENTIALS_PATH).stream()
                .anyMatch(line -> {
                    String[] parts = line.split(",");
                    return parts.length >= 2 && parts[0].equals(username) && parts[1].equals(password);
                });
    }

    public void createAdmin(Admin admin) throws IOException {
        fileManager.appendLine(ADMIN_CREDENTIALS_PATH,
                admin.getUsername() + "," + admin.getPassword() + "," + admin.getRole());
    }

    public List<Admin> getAllAdmins() throws IOException {
        List<Admin> admins = new ArrayList<>();
        for (String line : fileManager.readLines(ADMIN_CREDENTIALS_PATH)) {
            String[] parts = line.split(",");
            if (parts.length == 3) {
                admins.add(new Admin(parts[0], parts[1], parts[2]));
            }
        }
        return admins;
    }

    public boolean adminUsernameExists(String username) throws IOException {
        return getAllAdmins().stream().anyMatch(admin -> admin.getUsername().equalsIgnoreCase(username));
    }

    public void removeAdmin(String username) throws IOException {
        List<String> updated = new ArrayList<>();
        for (String line : fileManager.readLines(ADMIN_CREDENTIALS_PATH)) {
            String[] parts = line.split(",");
            if (parts.length >= 1 && !parts[0].equalsIgnoreCase(username)) {
                updated.add(line);
            }
        }
        fileManager.writeLines(ADMIN_CREDENTIALS_PATH, updated);
    }
}
