
package com.example.demo2.services;

import com.example.demo2.entities.Course;
import com.example.demo2.utils.FileManager;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class CourseService {
    private final FileManager fileManager = new FileManager();
    private final String COURSE_DETAILS_PATH = "data/coursedetails.txt";
    private final String ENROLLED_COURSE_PATH = "data/enrolledcourse.txt";
    private final String COURSE_STATUS_PATH = "data/coursestatus.txt";

    public void addCourse(Course course) throws IOException {
        String line = String.join(",",
                course.getCourseId(), course.getCourseName(),
                String.valueOf(course.getCourseDuration()),
                String.valueOf(course.getCoursePrice()),
                course.getLecturerName(), course.getDayType());
        fileManager.appendLine(COURSE_DETAILS_PATH, line);
    }

    public List<Course> getAllCourses() throws IOException {
        List<Course> courses = new ArrayList<>();
        for (String line : fileManager.readLines(COURSE_DETAILS_PATH)) {
            String[] parts = line.split(",");
            if (parts.length == 6) {
                courses.add(new Course(
                        parts[0], parts[1],
                        Integer.parseInt(parts[2]),
                        Double.parseDouble(parts[3]),
                        parts[4], parts[5]
                ));
            }
        }
        return courses;
    }

    public Course getCourseById(String courseId) throws IOException {
        for (String line : fileManager.readLines(COURSE_DETAILS_PATH)) {
            String[] parts = line.split(",");
            if (parts.length == 6 && parts[0].equalsIgnoreCase(courseId)) {
                return new Course(parts[0], parts[1],
                        Integer.parseInt(parts[2]),
                        Double.parseDouble(parts[3]), parts[4], parts[5]);
            }
        }
        return null;
    }

    public List<String> getEnrolledStudents(String courseId) throws IOException {
        List<String> students = new ArrayList<>();
        for (String line : fileManager.readLines(ENROLLED_COURSE_PATH)) {
            String[] parts = line.split(",");
            if (parts.length == 2 && parts[0].equalsIgnoreCase(courseId)) {
                students.add(parts[1]);
            }
        }
        return students;
    }

    public String getCourseStatusForStudent(String username, String courseId) throws IOException {
        for (String line : fileManager.readLines(COURSE_STATUS_PATH)) {
            String[] parts = line.split(",");
            if (parts.length == 3 && parts[0].equalsIgnoreCase(courseId) && parts[1].equalsIgnoreCase(username)) {
                return parts[2];
            }
        }
        return null;
    }
}

