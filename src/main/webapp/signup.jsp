<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Signup Page</title>
  <link rel="stylesheet" href="css/signup.css">
</head>
<body>
<div class="page-background"></div>
<div class="container">
  <div class="signup-card">
    <div class="header">
      <h2>Create an Account</h2>
    </div>
    <p class="error-message" id="errorMessage">
      <script>
        const params = new URLSearchParams(window.location.search);
        if (params.has("error")) {
          document.write("Username already exists. Please choose a different one.");
        }
      </script>
    </p>
    <form action="SignupServlet" method="post">
      <div class="form-group">
        <input type="text" name="name" placeholder="Full Name" required>
      </div>
      <div class="form-group">
        <input type="email" name="email" placeholder="Email" required>
      </div>
      <div class="form-group">
        <input type="text" name="nic" placeholder="NIC Number" required>
      </div>
      <div class="form-group">
        <input type="text" name="username" placeholder="Username" required>
      </div>
      <div class="form-group">
        <input type="password" name="password" placeholder="Password" required>
      </div>
      <button type="submit" class="signup-btn">Sign Up</button>
    </form>
    <p class="login-link">Already have an account? <a href="index.jsp">Login here</a></p>
  </div>
</div>
</body>
</html>