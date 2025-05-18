
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
    public void updatePersonalInfo(String username, String updatedLine) throws IOException {
        fileManager.updateLine(PERSONAL_INFO_PATH, username, updatedLine);
    }

    public void updateAcademicInfo(String username, String updatedLine) throws IOException {
        fileManager.updateLine(ACADEMIC_INFO_PATH, username, updatedLine);
    }

    public void updateUserDetails(String username, String updatedLine) throws IOException {
        fileManager.updateLine(USER_DETAILS_PATH, username, updatedLine);
    }

    public PersonalInfo getPersonalInfo(String username) throws IOException {
        for (String line : fileManager.readLines(PERSONAL_INFO_PATH)) {
            String[] parts = line.split(",");
            if (parts.length == 9 && parts[0].equalsIgnoreCase(username)) {
                return new PersonalInfo(
                        parts[0], // username
                        parts[1], // address
                        parts[2], // email
                        parts[3], // phone
                        parts[4], // nic
                        parts[5], // dob
                        parts[6], // gender
                        parts[7], // nationality
                        parts[8]  // name
                );
            }
        }
        return null;
    }

    public AcademicInfo getAcademicInfo(String username) throws IOException {
        for (String line : fileManager.readLines(ACADEMIC_INFO_PATH)) {
            String[] parts = line.split(",");
            if (parts.length == 4 && parts[0].equalsIgnoreCase(username)) {
                return new AcademicInfo(
                        parts[0], // username
                        parts[1], // school
                        parts[2], // stream
                        parts[3]  // passedSubjects
                );
            }
        }
        return null;
    }
    public void savePersonalInfo(PersonalInfo pInfo) throws IOException {
        String line = String.join(",", pInfo.getUsername(), pInfo.getAddress(), pInfo.getEmail(), pInfo.getPhone(),
                pInfo.getNic(), pInfo.getDob(), pInfo.getGender(), pInfo.getNationality(), pInfo.getName());
        fileManager.appendLine(PERSONAL_INFO_PATH, line);
    }

    public void saveAcademicInfo(AcademicInfo aInfo) throws IOException {
        String line = String.join(",", aInfo.getUsername(), aInfo.getSchool(), aInfo.getStream(), aInfo.getPassedSubjects());
        fileManager.appendLine(ACADEMIC_INFO_PATH, line);
    }

    public void recordRegistrationTime(String username) throws IOException {
        String timestamp = java.time.LocalDateTime.now()
                .atZone(ZoneId.systemDefault())
                .format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        fileManager.appendLine(REGISTERED_TIME_PATH, username + "," + timestamp);
    }

}