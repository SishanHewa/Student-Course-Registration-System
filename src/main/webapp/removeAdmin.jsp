<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Remove Admin</title>
    <link rel="stylesheet" href="css/adminDashboard.css">
    <link rel="stylesheet" href="css/removeAdmin.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<div class="container mt-5">
    <div class="card shadow remove-admin-card">
        <div class="card-header">
            <h2 class="text-center"><i class="fas fa-user-minus me-2"></i>Remove Admin</h2>
        </div>
        <div class="card-body">
            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
            <% if(errorMessage != null) { %>
            <div class="alert alert-danger"><%= errorMessage %></div>
            <% } %>

            <form action="RemoveAdminServlet" method="post">
                <div class="mb-4">
                    <label for="usernameToRemove" class="form-label">Admin Username to Remove:</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                        <input type="text" class="form-control" id="usernameToRemove" name="usernameToRemove"
                               value="<%= request.getParameter("usernameToRemove") %>" readonly>
                    </div>
                </div>

                <div class="mb-4">
                    <label for="currentAdminPassword" class="form-label">Your Password:</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        <input type="password" class="form-control" id="currentAdminPassword" name="currentAdminPassword" required>
                    </div>
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-danger"><i class="fas fa-user-minus me-2"></i>Remove Admin</button>
                </div>
            </form>

            <div class="text-center mt-4">
                <a href="adminDashboard.jsp?tab=admins" class="btn btn-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
