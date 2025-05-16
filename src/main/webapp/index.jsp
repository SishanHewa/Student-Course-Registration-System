<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
<div class="login-container">
    <h2>Login to Your Account</h2>

    <!-- Error message if login fails -->
    <p class="error-message" id="errorMessage">
        <script>
            const params = new URLSearchParams(window.location.search);
            if (params.has("error")) {
                document.write("Invalid username or password. Please try again.");
            }
        </script>
    </p>

    <form action="LoginServlet" method="post">
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Login</button>
    </form>

    <p>Don't have an account? <a href="signup.jsp">Sign up here</a></p>
</div>
</body>
</html>
