
package com.example.demo2.controllers;

import com.example.demo2.entities.Course;
import com.example.demo2.services.CourseService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AddCourseServlet extends HttpServlet {
    private final CourseService courseService = new CourseService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Course course = new Course(
                request.getParameter("courseId").trim(),
                request.getParameter("courseName").trim(),
                Integer.parseInt(request.getParameter("courseDuration").trim()),
                Double.parseDouble(request.getParameter("coursePrice").trim()),
                request.getParameter("lecturerName").trim(),
                request.getParameter("dayType").trim()
        );

        courseService.addCourse(course);
        response.sendRedirect("adminDashboard.jsp?tab=courses");
    }
}

