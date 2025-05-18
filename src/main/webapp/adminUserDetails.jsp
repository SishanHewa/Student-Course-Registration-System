<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%
    // Get the selected username from the request parameter
    String selectedUser = request.getParameter("username");

    // Variables to hold file data
    String userDetails = "";
    String academicDetails = "";
    String status = "";

    // Read the student's status from status.txt
    File statusFile = new File("/Users/sishanhewapathirana/status.txt");
    if (statusFile.exists()) {
        try (BufferedReader br = new BufferedReader(new FileReader(statusFile))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (line.startsWith(selectedUser + ",")) {
                    String[] parts = line.split(",");
                    if (parts.length == 2) {
                        status = parts[1].trim();
                    }
                    break;
                }
            }
        }
    }

    // Read personal information from personalinfo.txt
    File personalInfoFile = new File("/Users/sishanhewapathirana/personalinfo.txt");
    if (personalInfoFile.exists()) {
        try (BufferedReader br = new BufferedReader(new FileReader(personalInfoFile))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (line.startsWith(selectedUser + ",")) {
                    userDetails = line;
                    break;
                }
            }
        }
    }

    // Read academic information from academicinfo.txt
    File academicInfoFile = new File("/Users/sishanhewapathirana/academicinfo.txt");
    if (academicInfoFile.exists()) {
        try (BufferedReader br = new BufferedReader(new FileReader(academicInfoFile))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (line.startsWith(selectedUser + ",")) {
                    academicDetails = line;
                    break;
                }
            }
        }
    }

    // Split the details into parts
    String[] userParts = userDetails.split(",");
    String[] academicParts = academicDetails.split(",");

    // personalinfo.txt: username, address, email, telephone number, NIC number, birthday, gender, nationality, name
    String address = (userParts.length > 1) ? userParts[1] : "";
    String email = (userParts.length > 2) ? userParts[2] : "";
    String phone = (userParts.length > 3) ? userParts[3] : "";
    String nic = (userParts.length > 4) ? userParts[4] : "";
    String dob = (userParts.length > 5) ? userParts[5] : "";
    String gender = (userParts.length > 6) ? userParts[6] : "";
    String nationality = (userParts.length > 7) ? userParts[7] : "";
    String name = (userParts.length > 8) ? userParts[8] : "";

    // academicinfo.txt: username, school, stream, number of passed subjects
    String school = (academicParts.length > 1) ? academicParts[1] : "";
    String stream = (academicParts.length > 2) ? academicParts[2] : "";
    String passedSubjects = (academicParts.length > 3) ? academicParts[3] : "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Details for <%= selectedUser %></title>
    <link rel="stylesheet" href="css/userDetails.css">
</head>
<body>
<div class="container">
    <header>
        <h1>User Profile</h1>
        <h2><%= selectedUser %></h2>
        <div class="status-badge <%= status.toLowerCase() %>"><%= status %></div>
    </header>

    <form action="<%= ("registered".equalsIgnoreCase(status) ? "UpdateUserServlet" : "AcceptStudentServlet") %>" method="post">
        <input type="hidden" name="username" value="<%= selectedUser %>">

        <div class="card">
            <div class="card-header">
                <h3>Personal Information</h3>
            </div>
            <div class="card-body">
                <div class="form-group">
                    <label for="name">Full Name</label>
                    <input type="text" id="name" name="name" value="<%= name %>" <%= ("registered".equalsIgnoreCase(status)) ? "readonly" : "readonly" %>>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input type="text" id="email" name="email" value="<%= email %>" <%= ("registered".equalsIgnoreCase(status)) ? "readonly" : "readonly" %>>
                    </div>

                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="text" id="phone" name="phone" value="<%= phone %>" <%= ("registered".equalsIgnoreCase(status)) ? "readonly" : "readonly" %>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="address">Address</label>
                    <input type="text" id="address" name="address" value="<%= address %>" <%= ("registered".equalsIgnoreCase(status)) ? "readonly" : "readonly" %>>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="nic">NIC Number</label>
                        <input type="text" id="nic" name="nic" value="<%= nic %>" <%= ("registered".equalsIgnoreCase(status)) ? "readonly" : "readonly" %>>
                    </div>

                    <div class="form-group">
                        <label for="dob">Date of Birth</label>
                        <input type="text" id="dob" name="dob" value="<%= dob %>" <%= ("registered".equalsIgnoreCase(status)) ? "readonly" : "readonly" %>>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="gender">Gender</label>
                        <input type="text" id="gender" name="gender" value="<%= gender %>" <%= ("registered".equalsIgnoreCase(status)) ? "readonly" : "readonly" %>>
                    </div>

                    <div class="form-group">
                        <label for="nationality">Nationality</label>
                        <input type="text" id="nationality" name="nationality" value="<%= nationality %>" <%= ("registered".equalsIgnoreCase(status)) ? "readonly" : "readonly" %>>
                    </div>
                </div>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <h3>Academic Information</h3>
            </div>
            <div class="card-body">
                <div class="form-group">
                    <label for="school">School</label>
                    <input type="text" id="school" name="school" value="<%= school %>" <%= ("registered".equalsIgnoreCase(status)) ? "readonly" : "readonly" %>>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="stream">Stream</label>
                        <input type="text" id="stream" name="stream" value="<%= stream %>" <%= ("registered".equalsIgnoreCase(status)) ? "readonly" : "readonly" %>>
                    </div>

                    <div class="form-group">
                        <label for="passedSubjects">Passed Subjects</label>
                        <input type="text" id="passedSubjects" name="passedSubjects" value="<%= passedSubjects %>" <%= ("registered".equalsIgnoreCase(status)) ? "readonly" : "readonly" %>>
                    </div>
                </div>
            </div>
        </div>

        <div class="action-buttons">
            <% if ("pending".equalsIgnoreCase(status)) { %>
            <button type="submit" class="btn btn-primary">Accept Student</button>
            <% } else if ("registered".equalsIgnoreCase(status)) { %>
            <button type="button" id="editBtn" class="btn btn-secondary">Edit Profile</button>
            <button type="submit" id="saveBtn" class="btn btn-primary" style="display:none;">Save Changes</button>
            <% } %>
            <a href="adminDashboard.jsp" class="btn btn-outline">Back to Dashboard</a>
        </div>
    </form>
</div>

<script>
    // Only add the edit functionality if the student is registered
    if (document.getElementById("editBtn")) {
        document.getElementById("editBtn").addEventListener("click", function() {
            // Remove readonly from all text inputs
            let inputs = document.querySelectorAll("input[type='text']");
            inputs.forEach(function(input) {
                input.removeAttribute("readonly");
            });
            // Hide the edit button and show the save button
            document.getElementById("editBtn").style.display = "none";
            document.getElementById("saveBtn").style.display = "inline-block";
        });
    }
</script>
</body>
</html>
