package com.chesscourse.controller;

import com.chesscourse.dao.EnrollmentDAO;
import com.chesscourse.model.Enrollment;
import com.chesscourse.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/enroll")
public class EnrollmentServlet extends HttpServlet {
    private EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Check if user is logged in
        if (user == null) {
            response.sendRedirect("login.jsp?error=Please login to enroll in courses");
            return;
        }
        
        String action = request.getParameter("action");
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        
        if ("enroll".equals(action)) {
            enrollUser(user.getId(), courseId, response);
        } else if ("cancel".equals(action)) {
            cancelEnrollment(user.getId(), courseId, response);
        }
    }
    
    private void enrollUser(int userId, int courseId, HttpServletResponse response) 
            throws IOException {
        
        try {
            // Check if already enrolled
            if (enrollmentDAO.isUserEnrolled(userId, courseId)) {
                response.sendRedirect("courses?error=You are already enrolled in this course");
                return;
            }
            
            Enrollment enrollment = new Enrollment(userId, courseId);
            
            if (enrollmentDAO.enroll(enrollment)) {
                System.out.println("✅ User " + userId + " enrolled in course " + courseId);
                response.sendRedirect("my-enrollments?success=Successfully enrolled in course");
            } else {
                response.sendRedirect("courses?error=Failed to enroll in course");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("courses?error=Error: " + e.getMessage());
        }
    }
    
    private void cancelEnrollment(int userId, int courseId, HttpServletResponse response) 
            throws IOException {
        
        try {
            if (enrollmentDAO.cancelEnrollment(userId, courseId)) {
                System.out.println("✅ User " + userId + " canceled enrollment in course " + courseId);
                response.sendRedirect("my-enrollments?success=Enrollment canceled successfully");
            } else {
                response.sendRedirect("my-enrollments?error=Failed to cancel enrollment");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("my-enrollments?error=Error: " + e.getMessage());
        }
    }
}
