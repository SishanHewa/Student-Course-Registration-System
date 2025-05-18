<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Admin</title>
    <link rel="stylesheet" href="css/add-admin.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="main-container">
    <div class="card">
        <div class="card-header">
            <h2>Add New Admin</h2>
        </div>
        <div class="card-body">
            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
            <% if (errorMessage != null) { %>
            <div class="alert alert-danger"><%= errorMessage %></div>
            <% } %>

            <form action="AddNewAdminServlet" method="post">
                <div class="form-group mb-3">
                    <label for="adminUsername" class="form-label">New Admin Username</label>
                    <input type="text" class="form-control" id="adminUsername" name="adminUsername" required>
                </div>

                <div class="form-group mb-3">
                    <label for="adminPassword" class="form-label">New Admin Password</label>
                    <input type="password" class="form-control" id="adminPassword" name="adminPassword" required>
                </div>

                <div class="form-group mb-3">
                    <label for="adminRole" class="form-label">Role</label>
                    <select class="form-control" id="adminRole" name="adminRole" required>
                        <option value="student-administrator">Student Administrator</option>
                        <option value="registration administrator">Registration Administrator</option>
                        <option value="course administrator">Course Administrator</option>
                        <option value="system administrator">System Administrator</option>
                    </select>
                </div>

                <div class="form-group mb-4">
                    <label for="currentAdminPassword" class="form-label">Your Password</label>
                    <input type="password" class="form-control" id="currentAdminPassword" name="currentAdminPassword" required>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">Add Admin</button>
                    <a href="adminDashboard.jsp?tab=admins" class="btn btn-secondary">Back to Dashboard</a>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
