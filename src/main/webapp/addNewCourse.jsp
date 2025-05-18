<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Course</title>
    <link rel="stylesheet" href="css/add-course.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="page-container">
    <div class="form-container">
        <h2>Add New Course</h2>
        <form action="AddCourseServlet" method="post">
            <div class="form-group">
                <label for="courseId">Course ID</label>
                <input type="text" class="form-control" id="courseId" name="courseId" required>
            </div>
            <div class="form-group">
                <label for="courseName">Course Name</label>
                <input type="text" class="form-control" id="courseName" name="courseName" required>
            </div>
            <div class="form-group">
                <label for="courseDuration">Course Duration (years)</label>
                <input type="number" class="form-control" id="courseDuration" name="courseDuration" required>
            </div>
            <div class="form-group">
                <label for="coursePrice">Course Price (LKR)</label>
                <input type="number" step="0.01" class="form-control" id="coursePrice" name="coursePrice" required>
            </div>
            <div class="form-group">
                <label for="lecturerName">Lecturer Name</label>
                <input type="text" class="form-control" id="lecturerName" name="lecturerName" required>
            </div>
            <div class="form-group">
                <label for="dayType">Day Type</label>
                <select class="form-control" id="dayType" name="dayType" required>
                    <option value="weekday">Weekday</option>
                    <option value="weekend">Weekend</option>
                </select>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Add Course</button>
                <a href="adminDashboard.jsp?tab=courses" class="btn btn-secondary">Back to Dashboard</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>