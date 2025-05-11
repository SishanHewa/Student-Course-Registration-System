package com.example.demo2.entities;

public class Test {
    private String courseId;
    private String courseName;
    private int courseDuration;
    private double coursePrice;
    private String lecturerName;
    private String dayType;

    public Test(String courseId, String courseName, int courseDuration, double coursePrice,
                  String lecturerName, String dayType) {
        this.courseId = courseId;
        this.courseName = courseName;
        this.courseDuration = courseDuration;
        this.coursePrice = coursePrice;
        this.lecturerName = lecturerName;
        this.dayType = dayType;
    }

}