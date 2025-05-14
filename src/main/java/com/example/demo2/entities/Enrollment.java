package com.example.demo2.entities;

public class Enrollment {
    private String courseId;
    private String username;
    private String status;

    public Enrollment(String courseId, String username, String status) {
        this.courseId = courseId;
        this.username = username;
        this.status = status;
    }

    public String getCourseId() { return courseId; }
    public String getUsername() { return username; }
    public String getStatus() { return status; }
}