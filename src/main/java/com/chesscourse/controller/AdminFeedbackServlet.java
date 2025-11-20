package com.chesscourse.controller;

import com.chesscourse.dao.FeedbackDAO;
import com.chesscourse.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin-feedback")
public class AdminFeedbackServlet extends HttpServlet {
    private FeedbackDAO feedbackDAO = new FeedbackDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect("login.jsp?error=Access denied");
            return;
        }
        
        var feedbackList = feedbackDAO.getAllFeedback();
        request.setAttribute("feedbackList", feedbackList);
        
        request.getRequestDispatcher("admin-feedback.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect("login.jsp?error=Access denied");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            deleteFeedback(request, response);
        }
    }
    
    private void deleteFeedback(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        try {
            int feedbackId = Integer.parseInt(request.getParameter("id"));
            
            if (feedbackDAO.delete(feedbackId)) {
                System.out.println("✅ Admin deleted feedback ID: " + feedbackId);
                response.sendRedirect("admin-feedback?success=Feedback deleted successfully");
            } else {
                response.sendRedirect("admin-feedback?error=Failed to delete feedback");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin-feedback?error=Error: " + e.getMessage());
        }
    }
}
