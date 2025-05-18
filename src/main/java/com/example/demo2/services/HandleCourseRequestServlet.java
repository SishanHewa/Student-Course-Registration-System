
package com.example.demo2.services;

import com.example.demo2.entities.Enrollment;
import com.example.demo2.utils.CourseRequestQueue;
import jakarta.servlet.http.*;
import java.io.IOException;

public class HandleCourseRequestServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String courseId = request.getParameter("courseId");
        String username = request.getParameter("username");
        String action = request.getParameter("action");

        String newStatus;
        if ("accept".equalsIgnoreCase(action)) {
            newStatus = "enrolled";
        } else if ("reject".equalsIgnoreCase(action)) {
            newStatus = "rejected";
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action specified.");
            return;
        }

        try {
            CourseRequestQueue queue = new CourseRequestQueue();
            queue.updateStatus(new Enrollment(courseId, username, newStatus));
        } catch (IOException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update status.");
            return;
        }

        response.sendRedirect("adminDashboard.jsp?tab=requests&msg=updated");
    }
}

