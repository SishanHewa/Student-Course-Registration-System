<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <link rel="stylesheet" href="css/adminLogin.css">
</head>
<body>
<div class="login-container">
    <div class="login-card">
        <div class="login-header">
            <h2>Admin Login</h2>
        </div>
        <% if (request.getParameter("error") != null) { %>
        <p class="error-message">Invalid username or password!</p>
        <% } %>
        <form action="AdminLoginServlet" method="post">
            <div class="form-group">
                <label for="adminUsername">Username</label>
                <input type="text" id="adminUsername" name="adminUsername" required>
            </div>
            <div class="form-group">
                <label for="adminPassword">Password</label>
                <input type="password" id="adminPassword" name="adminPassword" required>
            </div>
            <button type="submit" class="login-button">Login</button>
        </form>
    </div>
</div>
</body>
</html>