
package com.example.demo2.Controllers;

import com.example.demo2.entities.Enrollment;
import com.example.demo2.services.EnrollmentService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class EnrollmentServlet extends HttpServlet {
    private final EnrollmentService enrollmentService = new EnrollmentService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUsername") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String studentId = (String) session.getAttribute("loggedUsername");
        String courseId = request.getParameter("courseId").trim();
        String paymentMethod = request.getParameter("paymentMethod").trim();
        String paymentAmount = request.getParameter("paymentAmount").trim();
        String paymentReference = request.getParameter("paymentReference").trim();

        Enrollment enrollment = new Enrollment(courseId, studentId, "pending");
        enrollmentService.saveCourseStatus(enrollment);
        enrollmentService.savePendingCourse(courseId, studentId, paymentMethod, paymentAmount, paymentReference);

        response.sendRedirect("profile.jsp?tab=courses&msg=success");
    }
}