<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*, java.util.*,                 com.example.demo2.services.UserService,
                 com.example.demo2.services.AdminService,
                 com.example.demo2.services.CourseService,
                 com.example.demo2.entities.RegistrationRecord,
                 com.example.demo2.entities.Course,
                 com.example.demo2.entities.Admin,
                 com.example.demo2.utils.RegistrationSorter,
                 com.example.demo2.utils.CourseRequestQueue" %>
<%
    HttpSession mySession = request.getSession(false);
    if (mySession == null || mySession.getAttribute("adminUsername") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    String activeTab = request.getParameter("tab");
    if (activeTab == null || activeTab.isEmpty()) {
        activeTab = "users";
    }

    List<String> registeredUsers = new ArrayList<>();
    List<String> pendingUsers = new ArrayList<>();
    File statusFile = new File("/Users/sishanhewapathirana/status.txt");
    if (statusFile.exists()) {
        try (BufferedReader br = new BufferedReader(new FileReader(statusFile))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 2) {
                    String uname = parts[0].trim();
                    String stat = parts[1].trim().toLowerCase();
                    if (stat.equals("registered")) {
                        registeredUsers.add(uname);
                    } else if (stat.equals("pending")) {
                        pendingUsers.add(uname);
                    }
                }
            }
        }
    }

    List<RegistrationRecord> pendingRecords = new ArrayList<>();
    File regTimeFile = new File("/Users/sishanhewapathirana/registeredtime.txt");
    if (regTimeFile.exists()) {
        try (BufferedReader br = new BufferedReader(new FileReader(regTimeFile))) {
            String line;
            java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 2) {
                    String uname = parts[0].trim();
                    if (pendingUsers.contains(uname)) {
                        java.time.LocalDateTime regTime = java.time.LocalDateTime.parse(parts[1].trim(), formatter);
                        pendingRecords.add(new RegistrationRecord(uname, regTime));
                    }
                }
            }
        }
    }

    String sortOrder = request.getParameter("sortOrder");
    if (sortOrder == null || sortOrder.isEmpty()) {
        sortOrder = "old";
    }
    RegistrationSorter sorter = new RegistrationSorter();
    sorter.sortByTime(pendingRecords, true);
    if ("new".equals(sortOrder)) {
        java.util.Collections.reverse(pendingRecords);
    }

    AdminService adminService = new AdminService();
    List<Admin> adminRecords = adminService.getAllAdmins();
    String currentAdmin = (String) mySession.getAttribute("adminUsername");
    Admin currentAdminRecord = null;
    List<Admin> otherAdmins = new ArrayList<>();
    for (Admin admin : adminRecords) {
        if (admin.getUsername().equalsIgnoreCase(currentAdmin)) {
            currentAdminRecord = admin;
        } else {
            otherAdmins.add(admin);
        }
    }

    CourseService courseService = new CourseService();
    List<Course> courseList = courseService.getAllCourses();

    // Import the TicketService and get ticket data
    TicketService ticketService = new TicketService();
    List<Ticket> allTickets = ticketService.getAllTickets();
%>
<%@ page import="com.example.demo2.entities.Ticket, com.example.demo2.services.TicketService" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/adminDashboard.css">
</head>
<body>
<div class="dashboard-wrapper">
    <div class="dashboard-container">
        <div class="dashboard-header">
            <h2>Admin Dashboard</h2>
            <div class="admin-info">
                <span>Welcome, <%= currentAdmin %></span>
                <a href="AdminLogoutServlet" class="logout-btn">Logout</a>
            </div>
        </div>


        <ul class="nav nav-tabs custom-tabs" id="adminTabs">
            <li class="nav-item">
                <a class="nav-link <%= ("users".equals(activeTab) ? "active" : "") %>" id="users-tab" data-bs-toggle="tab" href="#users">Registered Users</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <%= ("pending".equals(activeTab) ? "active" : "") %>" id="pending-tab" data-bs-toggle="tab" href="#pending">Pending Students</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <%= ("admins".equals(activeTab) ? "active" : "") %>" id="admins-tab" data-bs-toggle="tab" href="#admins">Admin List</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <%= ("courses".equals(activeTab) ? "active" : "") %>" id="courses-tab" data-bs-toggle="tab" href="#courses">Course List</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <%= ("requests".equals(activeTab) ? "active" : "") %>" id="requests-tab" data-bs-toggle="tab" href="#requests">Course Requests</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <%= ("tickets".equals(activeTab) ? "active" : "") %>" id="tickets-tab" data-bs-toggle="tab" href="#tickets">🎟️ Tickets</a>
            </li>
        </ul>


        <div class="tab-content mt-4" id="adminTabContent">
            <div class="tab-pane fade <%= ("users".equals(activeTab) ? "show active" : "") %>" id="users">
                <div class="card content-card">
                    <div class="card-header">
                        <h3>Registered Users</h3>
                    </div>
                    <div class="card-body">
                        <ul class="list-group custom-list">
                            <% if (registeredUsers.isEmpty()) { %>
                            <p class="empty-message">No registered users found.</p>
                            <% } else { %>
                            <% for (String user : registeredUsers) { %>
                            <li class="list-group-item">
                                <a href="adminUserDetails.jsp?username=<%= user %>"><%= user %></a>
                            </li>
                            <% } %>
                            <% } %>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="tab-pane fade <%= ("pending".equals(activeTab) ? "show active" : "") %>" id="pending">
                <div class="card content-card">
                    <div class="card-header">
                        <h3>Pending Students</h3>
                        <form method="get" action="adminDashboard.jsp" class="sort-form">
                            <input type="hidden" name="tab" value="pending">
                            <div class="form-group">
                                <label for="sortOrder">Sort by:</label>
                                <select name="sortOrder" id="sortOrder" class="form-select" onchange="this.form.submit()">
                                    <option value="old" <%= ("old".equals(sortOrder)) ? "selected" : "" %>>Oldest to Newest</option>
                                    <option value="new" <%= ("new".equals(sortOrder)) ? "selected" : "" %>>Newest to Oldest</option>
                                </select>
                            </div>
                        </form>
                    </div>
                    <div class="card-body">
                        <ul class="list-group custom-list">
                            <% if (pendingRecords.isEmpty()) { %>
                            <p class="empty-message">No pending students found.</p>
                            <% } else { %>
                            <% for (RegistrationRecord rec : pendingRecords) { %>
                            <li class="list-group-item">
                                <a href="adminUserDetails.jsp?username=<%= rec.getUsername() %>">
                                    <span class="user-name"><%= rec.getUsername() %></span>
                                    <span class="registration-time">Registered: <%= rec.getRegistrationTime().toString() %></span>
                                </a>
                            </li>
                            <% } %>
                            <% } %>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="tab-pane fade <%= ("admins".equals(activeTab) ? "show active" : "") %>" id="admins">
                <div class="card content-card">
                    <div class="card-header">
                        <h3>Admin List</h3>
                    </div>
                    <div class="card-body">
                        <ul class="list-group custom-list">
                            <% if (currentAdminRecord != null) { %>
                            <li class="list-group-item current-admin">
                                <div class="admin-info">
                                    <strong><%= currentAdminRecord.getUsername() %></strong>
                                    <span class="badge role-badge"><%= currentAdminRecord.getRole() %></span>
                                    <span class="logged-in-indicator">currently logged in</span>
                                </div>
                            </li>
                            <% } %>
                            <% for (Admin adminRec : otherAdmins) { %>
                            <li class="list-group-item">
                                <div class="admin-info">
                                    <strong><%= adminRec.getUsername() %></strong>
                                    <span class="badge role-badge"><%= adminRec.getRole() %></span>
                                </div>
                                <a href="removeAdmin.jsp?usernameToRemove=<%= adminRec.getUsername() %>" class="btn btn-danger btn-sm">Remove</a>
                            </li>
                            <% } %>
                        </ul>
                        <div class="action-buttons">
                            <a href="addNewAdmin.jsp" class="btn custom-btn">Add New Admin</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="tab-pane fade <%= ("courses".equals(activeTab) ? "show active" : "") %>" id="courses">
                <div class="card content-card">
                    <div class="card-header">
                        <h3>Course List</h3>
                    </div>
                    <div class="card-body">
                        <div class="action-buttons mb-3">
                            <a href="addNewCourse.jsp" class="btn custom-btn">Add New Course</a>
                        </div>
                        <ul class="list-group custom-list">
                            <% if (courseList.isEmpty()) { %>
                            <p class="empty-message">No courses found.</p>
                            <% } else { %>
                            <% for (Course course : courseList) { %>
                            <li class="list-group-item">
                                <a href="CourseDetailsServlet?courseId=<%= course.getCourseId() %>">
                                    <span class="course-name"><%= course.getCourseName() %></span>
                                    <span class="course-id">ID: <%= course.getCourseId() %></span>
                                </a>
                            </li>
                            <% } %>
                            <% } %>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="tab-pane fade <%= ("requests".equals(activeTab) ? "show active" : "") %>" id="requests">
                <div class="card content-card">
                    <div class="card-header">
                        <h3>Course Registration Requests</h3>
                    </div>
                    <div class="card-body">
                        <% if ("updated".equals(request.getParameter("msg"))) { %>
                        <div class="alert alert-success">Request updated successfully.</div>
                        <% } %>
                        <%
                            CourseRequestQueue queue = new CourseRequestQueue();
                            String[] req = queue.peekRequest();
                            if (req == null) {
                        %>
                        <p class="empty-message">No pending requests found.</p>
                        <% } else { %>
                        <div class="request-card">
                            <div class="request-details">
                                <div class="detail-item">
                                    <span class="label">Course ID:</span>
                                    <span class="value"><%= req[0] %></span>
                                </div>
                                <div class="detail-item">
                                    <span class="label">Username:</span>
                                    <span class="value"><%= req[1] %></span>
                                </div>
                                <div class="detail-item">
                                    <span class="label">Payment Method:</span>
                                    <span class="value"><%= req[2] %></span>
                                </div>
                                <div class="detail-item">
                                    <span class="label">Amount:</span>
                                    <span class="value">LKR <%= req[3] %></span>
                                </div>
                                <div class="detail-item">
                                    <span class="label">Reference ID:</span>
                                    <span class="value"><%= req[4] %></span>
                                </div>
                            </div>
                            <div class="request-actions">
                                <form method="post" action="HandleCourseRequestServlet">
                                    <input type="hidden" name="courseId" value="<%= req[0] %>"/>
                                    <input type="hidden" name="username" value="<%= req[1] %>"/>
                                    <input type="hidden" name="action" value="accept"/>
                                    <button type="submit" class="btn btn-success">Accept</button>
                                </form>
                                <form method="post" action="HandleCourseRequestServlet">
                                    <input type="hidden" name="courseId" value="<%= req[0] %>"/>
                                    <input type="hidden" name="username" value="<%= req[1] %>"/>
                                    <input type="hidden" name="action" value="reject"/>
                                    <button type="submit" class="btn btn-danger">Reject</button>
                                </form>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>

            <!-- Moved Tickets tab content inside tab-content container -->
            <div class="tab-pane fade <%= ("tickets".equals(activeTab) ? "show active" : "") %>" id="tickets">
                <div class="card content-card">
                    <div class="card-header">
                        <h3>Ticket Management</h3>
                    </div>
                    <div class="card-body">
                        <% if ("updated".equals(request.getParameter("msg"))) { %>
                        <div class="alert alert-success">Ticket updated successfully.</div>
                        <% } %>

                        <% if (allTickets.isEmpty()) { %>
                        <p class="empty-message">No tickets found.</p>
                        <% } else { %>
                        <ul class="list-group custom-list">
                            <% for (Ticket t : allTickets) { %>
                            <li class="list-group-item">
                                <form method="post" action="UpdateTicketServlet">
                                    <input type="hidden" name="ticketId" value="<%= t.getTicketId() %>"/>
                                    <div><strong>Ticket ID:</strong> <%= t.getTicketId() %></div>
                                    <div><strong>User:</strong> <%= t.getUsername() %></div>
                                    <div><strong>Category:</strong> <%= t.getCategory() %></div>
                                    <div><strong>Message:</strong> <%= t.getMessage() %></div>

                                    <div class="mb-2">
                                        <label>Status</label>
                                        <select name="status" class="form-control">
                                            <option value="pending" <%= "pending".equals(t.getStatus()) ? "selected" : "" %>>Pending</option>
                                            <option value="solved" <%= "solved".equals(t.getStatus()) ? "selected" : "" %>>Solved</option>
                                        </select>
                                    </div>

                                    <div class="mb-2">
                                        <label>Admin Comment</label>
                                        <textarea name="adminComment" class="form-control"><%= t.getAdminComment() %></textarea>
                                    </div>

                                    <button type="submit" class="btn btn-sm btn-success">Update</button>
                                </form>
                            </li>
                            <% } %>
                        </ul>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
