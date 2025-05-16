<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Pending</title>
    <!-- Link to external CSS -->
    <link rel="stylesheet" href="css/pending.css">
    <!-- Google Fonts - Poppins -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<div class="pending-container">
    <!-- Exclamation Icon (inline SVG) -->
    <div class="icon">
        <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <circle cx="12" cy="12" r="11" fill="#335765"/>
            <path d="M12 7V13" stroke="#B6D9EO" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            <path d="M12 17H12.01" stroke="#B6D9EO" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
    </div>
    <h2>Registration Pending</h2>
    <p>We have received your information. We will notify you once it has been reviewed.</p>
    <div class="button-container">
        <a href="index.jsp" class="return-link">Return to Home</a>
    </div>
</div>
</body>
</html>