<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    com.example.demo2.entities.Course course = (com.example.demo2.entities.Course) request.getAttribute("course");
    if (course == null) {
%>
<div class="error-container">
    <h2>No course found. Please check the course ID and try again.</h2>
    <a href="adminDashboard.jsp?tab=courses" class="btn-back">Back to Dashboard</a>
</div>
<%
} else {
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course Details</title>
    <link rel="stylesheet" href="css/adminDashboard.css">
    <link rel="stylesheet" href="css/courseDetails.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="dashboard-container">
    <div class="course-header">
        <h2><%= course.getCourseName() %></h2>
        <span class="course-id">ID: <%= course.getCourseId() %></span>
    </div>

    <div class="info-card">
        <div class="info-grid">
            <div class="info-item">
                <span class="info-label">Duration</span>
                <span class="info-value"><%= course.getCourseDuration() %> years</span>
            </div>
            <div class="info-item">
                <span class="info-label">Price</span>
                <span class="info-value">LKR <%= course.getCoursePrice() %></span>
            </div>
            <div class="info-item">
                <span class="info-label">Lecturer</span>
                <span class="info-value"><%= course.getLecturerName() %></span>
            </div>
            <div class="info-item">
                <span class="info-label">Day Type</span>
                <span class="info-value"><%= course.getDayType() %></span>
            </div>
        </div>
    </div>

    <div class="students-section">
        <h3>Enrolled Students</h3>
        <div class="students-list">
            <%
                java.util.List enrolledStudents = (java.util.List) request.getAttribute("enrolledStudents");
                if (enrolledStudents != null && !enrolledStudents.isEmpty()) {
                    for (Object student : enrolledStudents) {
            %>
            <div class="student-item"><%= student %></div>
            <%
                }
            } else {
            %>
            <div class="student-item empty">No enrolled students yet.</div>
            <%
                }
            %>
        </div>
    </div>

    <div class="action-bar">
        <a href="adminDashboard.jsp?tab=courses" class="btn-back">Back to Dashboard</a>
    </div>
</div>
</body>
</html>
<%
    }
%>
