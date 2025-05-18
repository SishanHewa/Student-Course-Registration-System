
package com.example.demo2.services;

import com.example.demo2.entities.Enrollment;
import com.example.demo2.utils.FileManager;

import java.io.IOException;
import java.util.List;

public class EnrollmentService {
    private final FileManager fileManager = new FileManager();
    private final String COURSE_STATUS_PATH = "/Users/sishanhewapathirana/coursestatus.txt";
    private final String PENDING_COURSE_PATH = "/Users/sishanhewapathirana/pendingcourse.txt";

    public void saveCourseStatus(Enrollment enrollment) throws IOException {
        List<String> lines = fileManager.readLines(COURSE_STATUS_PATH);
        for (String line : lines) {
            String[] parts = line.split(",");
            if (parts.length >= 3 &&
                    parts[0].equalsIgnoreCase(enrollment.getCourseId()) &&
                    parts[1].equalsIgnoreCase(enrollment.getUsername())) {
                return;
            }
        }
        fileManager.appendLine(COURSE_STATUS_PATH,
                enrollment.getCourseId() + "," + enrollment.getUsername() + "," + enrollment.getStatus());
    }

    public void savePendingCourse(String courseId, String studentId,
                                  String paymentMethod, String paymentAmount,
                                  String paymentReference) throws IOException {
        String line = String.join(",", courseId, studentId,
                paymentMethod, paymentAmount, paymentReference);
        fileManager.appendLine(PENDING_COURSE_PATH, line);
    }
}
