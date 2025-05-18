<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  HttpSession httpSession = request.getSession(false);
  if (httpSession == null) {
    response.sendRedirect("index.jsp");
    return;
  }
  String loggedUser  = (String) httpSession.getAttribute("loggedUsername");
  String loggedName  = (String) httpSession.getAttribute("loggedName");
  String loggedEmail = (String) httpSession.getAttribute("loggedEmail");
  String loggedNic   = (String) httpSession.getAttribute("loggedNic");
  if (loggedUser == null) {
    response.sendRedirect("index.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>User Information Form</title>
  <!-- Link the updated CSS -->
  <link rel="stylesheet" href="css/userForm.css">
</head>
<body>
<div class="container">
  <header>
    <h1>User Information Form</h1>
  </header>
  <form action="UserFormServlet" method="post">
    <div class="form-grid">
      <!-- Personal Information -->
      <div class="form-section">
        <h2>Personal Information</h2>
        <div class="form-group">
          <label for="name">Name</label>
          <input type="text" id="name" name="name" value="<%= (loggedName != null ? loggedName : "") %>" readonly>
        </div>
        <div class="form-group">
          <label for="email">Email</label>
          <input type="email" id="email" name="email" value="<%= (loggedEmail != null ? loggedEmail : "") %>" readonly>
        </div>
        <div class="form-group">
          <label for="nic">NIC</label>
          <input type="text" id="nic" name="nic" value="<%= (loggedNic != null ? loggedNic : "") %>" readonly>
        </div>
        <div class="form-group">
          <label for="address">Address</label>
          <input type="text" id="address" name="address" placeholder="Enter Address" required>
        </div>
        <div class="form-group">
          <label for="phone">Phone Number</label>
          <input type="tel" id="phone" name="phone" placeholder="Enter Phone Number" required>
        </div>
        <div class="form-group">
          <label for="dob">Date of Birth</label>
          <input type="date" id="dob" name="dob" required>
        </div>
        <div class="form-group">
          <label for="gender">Gender</label>
          <select id="gender" name="gender" required>
            <option value="">-- Select Gender --</option>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
            <option value="Prefer not to say">Prefer not to say</option>
          </select>
        </div>
        <div class="form-group">
          <label for="nationality">Nationality</label>
          <input type="text" id="nationality" name="nationality" placeholder="Enter Nationality" required>
        </div>
      </div>

      <!-- Academic Information -->
      <div class="form-section">
        <h2>Academic Information</h2>
        <div class="form-group">
          <label for="school">School</label>
          <input type="text" id="school" name="school" placeholder="Enter School" required>
        </div>
        <div class="form-group">
          <label for="stream">A/L Stream</label>
          <select id="stream" name="stream" required>
            <option value="">-- Select Stream --</option>
            <option value="Commerce">Commerce</option>
            <option value="Physical Sciences">Physical Sciences</option>
            <option value="Biological Science">Biological Science</option>
            <option value="Technology">Technology</option>
          </select>
        </div>
        <div class="form-group">
          <label for="passedSubjects">No. of Passed Subjects (1-4)</label>
          <select id="passedSubjects" name="passedSubjects" required>
            <option value="">-- Select Number --</option>
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
          </select>
        </div>
      </div>
    </div>
    <div class="form-actions">
      <button type="submit">Submit Information</button>
    </div>
  </form>
</div>
</body>
</html>