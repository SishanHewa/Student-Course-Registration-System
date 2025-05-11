package com.example.demo2.entities;

public class Course {
    private String courseId;
    private String courseName;
    private int courseDuration;
    private double coursePrice;
    private String lecturerName;
    private String dayType;

    public Course(String courseId, String courseName, int courseDuration, double coursePrice,
                  String lecturerName, String dayType) {
        this.courseId = courseId;
        this.courseName = courseName;
        this.courseDuration = courseDuration;
        this.coursePrice = coursePrice;
        this.lecturerName = lecturerName;
        this.dayType = dayType;
    }

    public String getCourseId() { return courseId; }
    public String getCourseName() { return courseName; }
    public int getCourseDuration() { return courseDuration; }
    public double getCoursePrice() { return coursePrice; }
    public String getLecturerName() { return lecturerName; }
    public String getDayType() { return dayType; }
}
