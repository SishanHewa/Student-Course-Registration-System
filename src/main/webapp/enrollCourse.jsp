<%@ page import="com.example.demo2.entities.Course" %>
<%@ page import="java.util.List" %>
<%@ page session="true" %>

<%
    List<Course> courseList = (List<Course>) request.getAttribute("courseList");
    String loggedUsername = (String) session.getAttribute("loggedUsername");
%>

<div class="container">
    <h2>Available Courses</h2>

    <% if (request.getParameter("msg") != null && "success".equals(request.getParameter("msg"))) { %>
    <p style="color: green;">Enrollment successful!</p>
    <% } %>

    <%
        if (courseList != null && !courseList.isEmpty()) {
            for (Course course : courseList) {
    %>
    <div style="border: 1px solid #ccc; padding: 10px; margin: 10px; border-radius: 5px;">
        <strong><%= course.getCourseName() %></strong> (ID: <%= course.getCourseId() %>)<br>
        Duration: <%= course.getCourseDuration() %> year(s), Price: LKR <%= course.getCoursePrice() %><br>
        Lecturer: <%= course.getLecturerName() %>, Day Type: <%= course.getDayType() %>

        <form method="post" action="EnrollmentServlet" style="display:inline;">
            <input type="hidden" name="courseId" value="<%= course.getCourseId() %>" />
            <input type="hidden" name="paymentMethod" value="Online" />
            <input type="hidden" name="paymentAmount" value="<%= course.getCoursePrice() %>" />
            <input type="hidden" name="paymentReference" value="REF-<%= course.getCourseId() %>-<%= loggedUsername %>" />
            <button type="submit" class="btn btn-success" style="float: right;">Enroll to Course</button>
        </form>
    </div>
    <%
        }
    } else {
    %>
    <p>No available courses.</p>
    <%
        }
    %>
</div>

