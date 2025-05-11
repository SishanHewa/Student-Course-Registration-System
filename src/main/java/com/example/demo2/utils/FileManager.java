
package com.example.demo2.utils;

import java.io.*;
import java.util.*;

public class FileManager {
    public List<String> readLines(String filePath) throws IOException {
        List<String> lines = new ArrayList<>();
        File file = new File(filePath);
        if (!file.exists()) return lines;
        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                lines.add(line);
            }
        }
        return lines;
    }

    public void appendLine(String filePath, String line) throws IOException {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filePath, true))) {
            bw.write(line);
            bw.newLine();
        }
    }

    public void writeLines(String filePath, List<String> lines) throws IOException {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filePath))) {
            for (String line : lines) {
                bw.write(line);
                bw.newLine();
            }
        }
    }

    public void updateLine(String filePath, String identifier, String newLine) throws IOException {
        File file = new File(filePath);
        if (!file.exists()) return;
        List<String> lines = readLines(filePath);
        List<String> updated = new ArrayList<>();
        for (String line : lines) {
            if (line.startsWith(identifier + ",")) {
                updated.add(newLine);
            } else {
                updated.add(line);
            }
        }
        writeLines(filePath, updated);
    }
}
