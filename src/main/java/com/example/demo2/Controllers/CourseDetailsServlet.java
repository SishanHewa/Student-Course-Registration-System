
package com.example.demo2.Controllers;

import com.example.demo2.entities.Course;
import com.example.demo2.services.CourseService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class CourseDetailsServlet extends HttpServlet {
    private final CourseService courseService = new CourseService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String courseId = request.getParameter("courseId");
        if (courseId == null || courseId.trim().isEmpty()) {
            response.sendRedirect("adminDashboard.jsp?tab=courses");
            return;
        }

        Course course = courseService.getCourseById(courseId);
        List<String> enrolledStudents = courseService.getEnrolledStudents(courseId);

        request.setAttribute("course", course);
        request.setAttribute("enrolledStudents", enrolledStudents);
        request.getRequestDispatcher("courseDetails.jsp").forward(request, response);
    }
}
