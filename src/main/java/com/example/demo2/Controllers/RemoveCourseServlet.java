package com.example.demo2.Controllers;

import com.example.demo2.services.CourseService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.io.IOException;

public class RemoveCourseServlet extends HttpServlet {
    private final CourseService courseService = new CourseService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String courseId = request.getParameter("courseId");
        if (courseId != null && !courseId.trim().isEmpty()) {
            courseService.removeCourse(courseId.trim());
        }

        response.sendRedirect("adminDashboard.jsp?tab=courses");
    }
}
