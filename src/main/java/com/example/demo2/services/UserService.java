
package com.example.demo2.services;

import com.example.demo2.entities.*;
import com.example.demo2.utils.FileManager;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class UserService {
    private final FileManager fileManager = new FileManager();
    private final String USERS_FILE_PATH = "data/users.txt";
    private final String USER_DETAILS_PATH = "data/userdetails.txt";
    private final String STATUS_FILE_PATH = "data/status.txt";
    private final String PERSONAL_INFO_PATH = "data/personalinfo.txt";
    private final String ACADEMIC_INFO_PATH = "data/academicinfo.txt";
    private final String REGISTERED_TIME_PATH = "data/registeredtime.txt";


    public boolean authenticate(String username, String password) throws IOException {
        return fileManager.readLines(USERS_FILE_PATH).stream()
                .anyMatch(line -> line.equalsIgnoreCase(username + "," + password));
    }

    public boolean usernameExists(String username) throws IOException {
        return fileManager.readLines(USERS_FILE_PATH).stream()
                .anyMatch(line -> line.split(",")[0].equalsIgnoreCase(username));
    }

    public void createUser(User user) throws IOException {
        fileManager.appendLine(USERS_FILE_PATH, user.getUsername() + "," + user.getPassword());
        fileManager.appendLine(USER_DETAILS_PATH, user.getName() + "," + user.getEmail() + "," + user.getNic() + "," + user.getUsername());
    }

    public String[] getUserDetails(String username) throws IOException {
        for (String line : fileManager.readLines(USER_DETAILS_PATH)) {
            String[] parts = line.split(",");
            if (parts.length == 4 && parts[3].equalsIgnoreCase(username)) {
                return new String[]{parts[0], parts[1], parts[2]};
            }
        }
        return null;
    }

    public String getUserStatus(String username) throws IOException {
        for (String line : fileManager.readLines(STATUS_FILE_PATH)) {
            String[] parts = line.split(",");
            if (parts.length == 2 && parts[0].equalsIgnoreCase(username)) {
                return parts[1];
            }
        }
        return null;
    }

    public void setUserStatus(String username, String status) throws IOException {
        fileManager.appendLine(STATUS_FILE_PATH, username + "," + status);
    }

    public void updateUserStatus(String username, String newStatus) throws IOException {
        fileManager.updateLine(STATUS_FILE_PATH, username, username + "," + newStatus);
    }

}