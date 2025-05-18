<%@ page import="com.example.demo2.entities.PersonalInfo" %>
<%@ page import="com.example.demo2.entities.AcademicInfo" %>
<%@ page import="com.example.demo2.entities.Course" %>
<%@ page import="com.example.demo2.entities.Ticket" %>
<%@ page import="com.example.demo2.services.UserService" %>
<%@ page import="com.example.demo2.services.CourseService" %>
<%@ page import="com.example.demo2.services.TicketService" %>
<%@ page import="java.util.List" %>

<%
  HttpSession sessionObj = request.getSession(false);
  if (sessionObj == null || sessionObj.getAttribute("loggedUsername") == null) {
    response.sendRedirect("login.jsp");
    return;
  }

  String username = (String) sessionObj.getAttribute("loggedUsername");

  UserService userService = new UserService();
  PersonalInfo pInfo = userService.getPersonalInfo(username);
  AcademicInfo aInfo = userService.getAcademicInfo(username);

  CourseService courseService = new CourseService();
  List<Course> courseList = courseService.getAllCourses();

  TicketService ticketService = new TicketService();
  List<Ticket> userTickets = ticketService.getTicketsByUser(username);

  String tab = request.getParameter("tab");
  if (tab == null) tab = "personal";
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Student Portal</title>
  <style>
    /*
     Simple Dashboard CSS using color palette:
     - #335765 (Dark Blue)
     - #74A8A4 (Teal)
     - #B6D9E0 (Light Blue)
     - #DBE2DC (Light Gray)
     - #7F543D (Brown)
    */

    /* Reset and Base Styles */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    html, body {
      height: 100%;
      width: 100%;
      overflow-x: hidden;
    }

    body {
      font-family: 'Segoe UI', Arial, sans-serif;
      background-color: #DBE2DC;
      color: #335765;
      line-height: 1.6;
      margin: 0;
      padding: 0;
    }

    .container {
      width: 100%;
      min-height: 100vh;
      margin: 0;
      background-color: white;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
      display: flex;
      flex-direction: column;
    }

    /* Header */
    .app-header {
      background-color: #335765;
      padding: 15px 20px;
      color: white;
      text-align: left;
    }

    .portal-title {
      margin: 0;
      font-size: 1.5rem;
      font-weight: 600;
    }

    /* Main Navigation */
    .main-nav {
      display: flex;
      background-color: #74A8A4;
      padding: 0 10px;
      overflow-x: auto;
    }

    .main-nav a {
      color: white;
      text-decoration: none;
      padding: 12px 15px;
      font-weight: 500;
      border-bottom: 3px solid transparent;
      white-space: nowrap;
      display: flex;
      align-items: center;
    }

    .main-nav a svg {
      margin-right: 6px;
      width: 16px;
      height: 16px;
    }

    .main-nav a:hover {
      background-color: rgba(255, 255, 255, 0.1);
      border-bottom: 3px solid rgba(255, 255, 255, 0.5);
    }

    .main-nav a.active {
      background-color: #B6D9E0;
      color: #335765;
      border-bottom: 3px solid #335765;
    }

    .main-nav .logout-link {
      margin-left: auto;
      color: #DBE2DC;
    }

    .main-nav .logout-link:hover {
      background-color: rgba(127, 84, 61, 0.2);
    }

    /* Welcome Bar */
    .welcome-bar {
      background-color: #B6D9E0;
      padding: 15px 20px;
      border-bottom: 1px solid #DBE2DC;
    }

    .welcome-bar h2 {
      margin: 0;
      font-size: 1.3rem;
      color: #335765;
    }

    /* Main Content Area */
    .content {
      padding: 20px;
      flex: 1;
    }

    .section-title {
      margin-bottom: 20px;
      color: #335765;
      font-size: 1.3rem;
      font-weight: 600;
      padding-bottom: 8px;
      border-bottom: 2px solid #74A8A4;
      display: flex;
      align-items: center;
    }

    .section-title svg {
      margin-right: 8px;
      width: 22px;
      height: 22px;
    }

    .content-section {
      margin-bottom: 30px;
    }

    /* Information Display */
    .info-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 20px;
    }

    .info-item {
      margin-bottom: 15px;
      padding: 0 0 5px 0;
      border-bottom: 1px solid #DBE2DC;
    }

    .info-label {
      font-weight: 600;
      color: #7F543D;
      margin-right: 10px;
      min-width: 120px;
      display: inline-block;
    }

    .info-value {
      color: #335765;
    }

    /* Course List */
    .course-list {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
      gap: 20px;
    }

    .course-card {
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
      overflow: hidden;
      border-left: 4px solid #74A8A4;
    }

    .course-header {
      background-color: #DBE2DC;
      padding: 12px 15px;
      border-bottom: 1px solid #DBE2DC;
    }

    .course-title {
      margin: 0;
      color: #335765;
      font-size: 1.1rem;
    }

    .course-id {
      font-size: 0.8rem;
      color: #7F543D;
    }

    .course-details {
      padding: 15px;
    }

    .course-info {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 10px;
      margin-bottom: 15px;
    }

    .course-detail {
      font-size: 0.9rem;
      display: flex;
      align-items: center;
    }

    .course-detail svg {
      margin-right: 5px;
      width: 14px;
      height: 14px;
      flex-shrink: 0;
    }

    .course-status {
      margin-top: 10px;
      text-align: right;
    }

    .enroll-button {
      background-color: #74A8A4;
      color: white;
      border: none;
      padding: 8px 16px;
      border-radius: 4px;
      cursor: pointer;
      font-weight: 500;
      transition: background-color 0.2s;
    }

    .enroll-button:hover {
      background-color: #335765;
    }

    .status {
      display: inline-block;
      padding: 6px 12px;
      border-radius: 4px;
      font-size: 0.85rem;
      font-weight: 500;
    }

    .status.pending {
      background-color: #ffe58f;
      color: #856404;
    }

    .status.enrolled {
      background-color: #74A8A4;
      color: white;
    }

    .status.other {
      background-color: #DBE2DC;
      color: #335765;
    }

    /* Tickets */
    .new-ticket-button {
      background-color: #335765;
      color: white;
      text-decoration: none;
      padding: 8px 16px;
      border-radius: 4px;
      display: inline-flex;
      align-items: center;
      margin-bottom: 20px;
      font-weight: 500;
    }

    .new-ticket-button svg {
      margin-right: 5px;
      width: 14px;
      height: 14px;
    }

    .new-ticket-button:hover {
      background-color: #74A8A4;
    }

    .empty-tickets {
      text-align: center;
      padding: 30px;
      color: #7F543D;
      background-color: #f5f5f5;
      border-radius: 8px;
    }

    .ticket-list {
      display: flex;
      flex-direction: column;
      gap: 15px;
    }

    .ticket-card {
      background-color: white;
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
      border-left: 4px solid #74A8A4;
    }

    .ticket-header {
      background-color: #DBE2DC;
      padding: 10px 15px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .ticket-id {
      font-weight: 600;
      color: #335765;
    }

    .ticket-status {
      padding: 4px 8px;
      border-radius: 4px;
      font-size: 0.8rem;
    }

    .ticket-status.open {
      background-color: #74A8A4;
      color: white;
    }

    .ticket-status.closed {
      background-color: #DBE2DC;
      color: #7F543D;
    }

    .ticket-status.processing {
      background-color: #B6D9E0;
      color: #335765;
    }

    .ticket-details {
      padding: 15px;
    }

    .ticket-details p {
      margin-bottom: 10px;
    }

    .admin-response {
      margin-top: 15px;
      padding: 10px;
      background-color: #f5f5f5;
      border-radius: 4px;
      border-left: 3px solid #7F543D;
    }

    /* Footer */
    .app-footer {
      text-align: center;
      padding: 15px;
      background-color: #335765;
      color: #DBE2DC;
      font-size: 0.9rem;
      margin-top: auto;
    }

    /* Responsive Adjustments */
    @media (max-width: 768px) {
      .info-grid {
        grid-template-columns: 1fr;
      }

      .course-list {
        grid-template-columns: 1fr;
      }

      .course-info {
        grid-template-columns: 1fr;
      }

      .main-nav {
        flex-wrap: wrap;
      }

      .main-nav a {
        flex: 1 1 auto;
        text-align: center;
        justify-content: center;
      }

      .main-nav .logout-link {
        margin-left: 0;
        width: 100%;
      }
    }
  </style>
</head>
<body>

<div class="container">
  <!-- Header -->
  <header class="app-header">
    <h1 class="portal-title">Student Portal</h1>
  </header>

  <!-- Navigation Bar with SVG Icons -->
  <nav class="main-nav">
    <a href="?tab=personal" class="<%= "personal".equals(tab) ? "active" : "" %>">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
        <circle cx="12" cy="7" r="4"></circle>
      </svg>
      Personal Info
    </a>
    <a href="?tab=academic" class="<%= "academic".equals(tab) ? "active" : "" %>">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"></path>
        <path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"></path>
      </svg>
      Academic Info
    </a>
    <a href="?tab=courses" class="<%= "courses".equals(tab) ? "active" : "" %>">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path>
        <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path>
      </svg>
      Course List
    </a>
    <a href="?tab=tickets" class="<%= "tickets".equals(tab) ? "active" : "" %>">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <rect x="2" y="7" width="20" height="14" rx="2" ry="2"></rect>
        <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"></path>
      </svg>
      My Tickets
    </a>
    <a href="LogoutServlet" class="logout-link">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
        <polyline points="16 17 21 12 16 7"></polyline>
        <line x1="21" y1="12" x2="9" y2="12"></line>
      </svg>
      Logout
    </a>
  </nav>

  <!-- Welcome Bar -->
  <div class="welcome-bar">
    <h2>Welcome, <%= username %></h2>
  </div>

  <!-- Main Content -->
  <main class="content">

    <% if ("personal".equals(tab)) { %>
    <section class="content-section">
      <h3 class="section-title">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
          <circle cx="12" cy="7" r="4"></circle>
        </svg>
        Personal Information
      </h3>
      <div class="info-grid">
        <div class="info-column">
          <div class="info-item">
            <span class="info-label">Username:</span>
            <span class="info-value"><%= pInfo.getUsername() %></span>
          </div>
          <div class="info-item">
            <span class="info-label">Name:</span>
            <span class="info-value"><%= pInfo.getName() %></span>
          </div>
          <div class="info-item">
            <span class="info-label">Email:</span>
            <span class="info-value"><%= pInfo.getEmail() %></span>
          </div>
          <div class="info-item">
            <span class="info-label">Address:</span>
            <span class="info-value"><%= pInfo.getAddress() %></span>
          </div>
          <div class="info-item">
            <span class="info-label">Phone:</span>
            <span class="info-value"><%= pInfo.getPhone() %></span>
          </div>
        </div>
        <div class="info-column">
          <div class="info-item">
            <span class="info-label">NIC:</span>
            <span class="info-value"><%= pInfo.getNic() %></span>
          </div>
          <div class="info-item">
            <span class="info-label">Date of Birth:</span>
            <span class="info-value"><%= pInfo.getDob() %></span>
          </div>
          <div class="info-item">
            <span class="info-label">Gender:</span>
            <span class="info-value"><%= pInfo.getGender() %></span>
          </div>
          <div class="info-item">
            <span class="info-label">Nationality:</span>
            <span class="info-value"><%= pInfo.getNationality() %></span>
          </div>
        </div>
      </div>
    </section>

    <% } else if ("academic".equals(tab)) { %>
    <section class="content-section">
      <h3 class="section-title">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"></path>
          <path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"></path>
        </svg>
        Academic Information
      </h3>
      <div class="info-item">
        <span class="info-label">Username:</span>
        <span class="info-value"><%= aInfo.getUsername() %></span>
      </div>
      <div class="info-item">
        <span class="info-label">School:</span>
        <span class="info-value"><%= aInfo.getSchool() %></span>
      </div>
      <div class="info-item">
        <span class="info-label">Stream:</span>
        <span class="info-value"><%= aInfo.getStream() %></span>
      </div>
      <div class="info-item">
        <span class="info-label">Passed Subjects:</span>
        <span class="info-value"><%= aInfo.getPassedSubjects() %></span>
      </div>
    </section>

    <% } else if ("courses".equals(tab)) { %>
    <section class="content-section">
      <h3 class="section-title">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path>
          <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path>
        </svg>
        Available Courses
      </h3>

      <div class="course-list">
        <% for (Course course : courseList) {
          String status = courseService.getCourseStatusForStudent(username, course.getCourseId());
        %>
        <div class="course-card">
          <div class="course-header">
            <h4 class="course-title"><%= course.getCourseName() %></h4>
            <span class="course-id">ID: <%= course.getCourseId() %></span>
          </div>
          <div class="course-details">
            <div class="course-info">
              <span class="course-detail">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                  <circle cx="12" cy="12" r="10"></circle>
                  <polyline points="12 6 12 12 16 14"></polyline>
                </svg>
                Duration: <%= course.getCourseDuration() %> year(s)
              </span>
              <span class="course-detail">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                  <rect x="2" y="4" width="20" height="16" rx="2"></rect>
                  <path d="M12 16v.01"></path>
                  <path d="M6 10h4"></path>
                  <path d="M14 10h4"></path>
                  <path d="M6 14h12"></path>
                </svg>
                Price: LKR <%= course.getCoursePrice() %>
              </span>
              <span class="course-detail">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                  <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                  <circle cx="12" cy="7" r="4"></circle>
                </svg>
                Lecturer: <%= course.getLecturerName() %>
              </span>
              <span class="course-detail">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                  <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                  <line x1="16" y1="2" x2="16" y2="6"></line>
                  <line x1="8" y1="2" x2="8" y2="6"></line>
                  <line x1="3" y1="10" x2="21" y2="10"></line>
                </svg>
                Type: <%= course.getDayType() %>
              </span>
            </div>
            <div class="course-status">
              <% if (status == null || status.trim().isEmpty()) { %>
              <form method="post" action="EnrollmentServlet">
                <input type="hidden" name="courseId" value="<%= course.getCourseId() %>" />
                <input type="hidden" name="paymentMethod" value="Online" />
                <input type="hidden" name="paymentAmount" value="<%= course.getCoursePrice() %>" />
                <input type="hidden" name="paymentReference" value="REF-<%= course.getCourseId() %>-<%= username %>" />
                <button type="submit" class="enroll-button">Enroll Now</button>
              </form>
              <% } else if ("pending".equalsIgnoreCase(status)) { %>
              <span class="status pending">
                <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="display:inline-block;vertical-align:middle;margin-right:4px;">
                  <circle cx="12" cy="12" r="10"></circle>
                  <polyline points="12 6 12 12 16 14"></polyline>
                </svg>
                Pending
              </span>
              <% } else if ("enrolled".equalsIgnoreCase(status)) { %>
              <span class="status enrolled">
                <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="display:inline-block;vertical-align:middle;margin-right:4px;">
                  <path d="M20 6L9 17l-5-5"></path>
                </svg>
                Enrolled
              </span>
              <% } else { %>
              <span class="status other"><%= status %></span>
              <% } %>
            </div>
          </div>
        </div>
        <% } %>
      </div>
    </section>

    <% } else if ("tickets".equals(tab)) { %>
    <section class="content-section">
      <h3 class="section-title">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <rect x="2" y="7" width="20" height="14" rx="2" ry="2"></rect>
          <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"></path>
        </svg>
        My Tickets
      </h3>
      <a href="submitTicket.jsp" class="new-ticket-button">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <line x1="12" y1="5" x2="12" y2="19"></line>
          <line x1="5" y1="12" x2="19" y2="12"></line>
        </svg>
        Submit New Ticket
      </a>

      <% if (userTickets.isEmpty()) { %>
      <div class="empty-tickets">
        <p>You haven't submitted any tickets yet.</p>
      </div>
      <% } else { %>
      <div class="ticket-list">
        <% for (Ticket t : userTickets) { %>
        <div class="ticket-card">
          <div class="ticket-header">
            <span class="ticket-id">Ticket #<%= t.getTicketId() %></span>
            <span class="ticket-status <%= t.getStatus().toLowerCase() %>"><%= t.getStatus() %></span>
          </div>
          <div class="ticket-details">
            <p><strong>Category:</strong> <%= t.getCategory() %></p>
            <p><strong>Message:</strong> <%= t.getMessage() %></p>
            <% if (t.getAdminComment() != null && !t.getAdminComment().isEmpty()) { %>
            <div class="admin-response">
              <p><strong>Admin Response:</strong></p>
              <p><%= t.getAdminComment() %></p>
            </div>
            <% } %>
          </div>
        </div>
        <% } %>
      </div>
      <% } %>
    </section>
    <% } %>

  </main>

  <!-- Footer -->
  <footer class="app-footer">
    <p>&copy; 2025 Student Management System</p>
  </footer>
</div>

</body>
</html>