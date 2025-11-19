package com.chesscourse.controller;

import com.chesscourse.dao.EnrollmentDAO;
import com.chesscourse.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/my-enrollments")
public class MyEnrollmentsServlet extends HttpServlet {
    private EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Check if user is logged in
        if (user == null) {
            response.sendRedirect("login.jsp?error=Please login to view your enrollments");
            return;
        }
        
        // Get user's enrollments
        var enrollments = enrollmentDAO.getEnrollmentsByUserId(user.getId());
        request.setAttribute("enrollments", enrollments);
        
        request.getRequestDispatcher("my-enrollments.jsp").forward(request, response);
    }
}
