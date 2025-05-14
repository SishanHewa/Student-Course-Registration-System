
package com.example.demo2.utils;

import com.example.demo2.entities.Enrollment;

import java.io.*;
import java.util.*;

public class CourseRequestQueue {
    private final String FILE_PATH = "/Users/sishanhewapathirana/pendingcourse.txt";
    private final String STATUS_FILE = "/Users/sishanhewapathirana/coursestatus.txt";
    private final Queue<String[]> requestQueue = new LinkedList<>();

    public CourseRequestQueue() throws IOException {
        loadRequests();
    }

    private void loadRequests() throws IOException {
        requestQueue.clear();
        File file = new File(FILE_PATH);
        if (!file.exists()) return;
        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 5) {
                    requestQueue.offer(parts);
                }
            }
        }
    }

    public String[] peekRequest() {
        return requestQueue.peek();
    }

    public void updateStatus(Enrollment enrollment) throws IOException {
        FileManager fileManager = new FileManager();
        List<String> lines = fileManager.readLines(STATUS_FILE);
        List<String> updatedLines = new ArrayList<>();

        for (String line : lines) {
            String[] parts = line.split(",");
            if (parts.length == 3 && parts[0].equals(enrollment.getCourseId()) && parts[1].equals(enrollment.getUsername())) {
                updatedLines.add(enrollment.getCourseId() + "," + enrollment.getUsername() + "," + enrollment.getStatus());
            } else {
                updatedLines.add(line);
            }
        }

        fileManager.writeLines(STATUS_FILE, updatedLines);
        dequeueRequest();
    }

    private void dequeueRequest() throws IOException {
        if (!requestQueue.isEmpty()) {
            requestQueue.poll();
            try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH))) {
                for (String[] req : requestQueue) {
                    bw.write(String.join(",", req));
                    bw.newLine();
                }
            }
        }
    }
}
