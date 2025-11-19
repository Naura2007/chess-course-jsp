package com.chesscourse.controller;

import com.chesscourse.dao.FeedbackDAO;
import com.chesscourse.model.Feedback;
import com.chesscourse.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/my-feedback")
public class FeedbackServlet extends HttpServlet {
    private FeedbackDAO feedbackDAO = new FeedbackDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Check if user is logged in
        if (user == null) {
            response.sendRedirect("login.jsp?error=Please login to view your feedback");
            return;
        }
        
        // Get user's feedback
        var feedbackList = feedbackDAO.getFeedbackByUserId(user.getId());
        request.setAttribute("feedbackList", feedbackList);
        
        request.getRequestDispatcher("my-feedback.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Check if user is logged in
        if (user == null) {
            response.sendRedirect("login.jsp?error=Please login to submit feedback");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("create".equals(action)) {
            createFeedback(user, request, response);
        } else if ("delete".equals(action)) {
            deleteFeedback(user, request, response);
        }
    }
    
    private void createFeedback(User user, HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        try {
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            String message = request.getParameter("message");
            
            System.out.println("=== CREATING FEEDBACK ===");
            System.out.println("User: " + user.getName());
            System.out.println("Course ID: " + courseId);
            System.out.println("Message: " + message);
            
            Feedback feedback = new Feedback(user.getId(), courseId, message);
            
            if (feedbackDAO.create(feedback)) {
                System.out.println("✅ Feedback created successfully!");
                response.sendRedirect("my-feedback?success=Feedback submitted successfully");
            } else {
                response.sendRedirect("give-feedback.jsp?error=Failed to submit feedback");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("give-feedback.jsp?error=Error: " + e.getMessage());
        }
    }
    
    private void deleteFeedback(User user, HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        try {
            int feedbackId = Integer.parseInt(request.getParameter("id"));
            
            if (feedbackDAO.delete(feedbackId)) {
                System.out.println("✅ Feedback deleted successfully!");
                response.sendRedirect("my-feedback?success=Feedback deleted successfully");
            } else {
                response.sendRedirect("my-feedback?error=Failed to delete feedback");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("my-feedback?error=Error: " + e.getMessage());
        }
    }
}