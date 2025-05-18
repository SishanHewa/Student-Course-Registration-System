<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.example.demo2.entities.Course, com.example.demo2.services.CourseService" %>
<%
    HttpSession session = request.getSession(false);
    if(session == null || session.getAttribute("loggedUsername") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    String username = (String) session.getAttribute("loggedUsername");
    CourseService courseService = new CourseService();
    // Assume getAllCourses() returns a list of all courses.
    List<Course> allCourses = courseService.getAllCourses();
    List<Course> enrolledCourses = new ArrayList<>();
    List<Course> pendingCourses = new ArrayList<>();
    for(Course course : allCourses) {
        String status = courseService.getCourseStatusForStudent(username, course.getCourseId());
        if(status != null) {
            if(status.equalsIgnoreCase("enrolled")) {
                enrolledCourses.add(course);
            } else if(status.equalsIgnoreCase("pending")) {
                pendingCourses.add(course);
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Profile Home</title>
    <link rel="stylesheet" href="css/dashboard.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="dashboard-container">
    <h2>Welcome, <%= username %></h2>
    <ul class="nav nav-tabs">
        <li class="nav-item">
            <a class="nav-link active" data-bs-toggle="tab" href="#enrolled">Enrolled Courses</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="tab" href="#pending">Pending Courses</a>
        </li>
        <!-- Other tabs can be added here -->
    </ul>
    <div class="tab-content mt-3">
        <div id="enrolled" class="tab-pane fade show active">
            <h3>Enrolled Courses</h3>
            <ul class="list-group">
                <% for(Course course : enrolledCourses) { %>
                <li class="list-group-item">
                    <%= course.getCourseName() %> (ID: <%= course.getCourseId() %>)
                </li>
                <% } %>
            </ul>
        </div>
        <div id="pending" class="tab-pane fade">
            <h3>Pending Courses</h3>
            <ul class="list-group">
                <% for(Course course : pendingCourses) { %>
                <li class="list-group-item">
                    <%= course.getCourseName() %> (ID: <%= course.getCourseId() %>)
                </li>
                <% } %>
            </ul>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
