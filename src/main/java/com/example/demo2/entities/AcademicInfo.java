package com.example.demo2.entities;

public class AcademicInfo {
    private String username;
    private String school;
    private String stream;
    private String passedSubjects;

    public AcademicInfo(String username, String school, String stream, String passedSubjects) {
        this.username = username;
        this.school = school;
        this.stream = stream;
        this.passedSubjects = passedSubjects;
    }

    public String getUsername() { return username; }
    public String getSchool() { return school; }
    public String getStream() { return stream; }
    public String getPassedSubjects() { return passedSubjects; }
}
