package com.chesscourse.controller;

import com.chesscourse.dao.NewsDAO;
import com.chesscourse.model.News;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/news")
public class NewsServlet extends HttpServlet {
    private NewsDAO newsDAO = new NewsDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Show all news to everyone
        request.setAttribute("newsList", newsDAO.findAll());
        request.getRequestDispatcher("news.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        com.chesscourse.model.User user = (com.chesscourse.model.User) session.getAttribute("user");
        
        // Check if user is admin
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect("login.jsp?error=Access denied");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("create".equals(action)) {
            createNews(request, response);
        } else if ("delete".equals(action)) {
            deleteNews(request, response);
        }
    }
    
    private void createNews(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            
            System.out.println("=== CREATING NEWS ===");
            System.out.println("Title: " + title);
            System.out.println("Content: " + content);
            
            News news = new News(title, content);
            
            if (newsDAO.create(news)) {
                System.out.println("✅ News created successfully!");
                response.sendRedirect("admin-news?success=News created successfully");
            } else {
                System.out.println("❌ Failed to create news");
                response.sendRedirect("create-news.jsp?error=Failed to create news");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("create-news.jsp?error=Error: " + e.getMessage());
        }
    }
    
    private void deleteNews(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            int newsId = Integer.parseInt(request.getParameter("id"));
            
            if (newsDAO.delete(newsId)) {
                response.sendRedirect("admin-news?success=News deleted successfully");
            } else {
                response.sendRedirect("admin-news?error=Failed to delete news");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin-news?error=Error: " + e.getMessage());
        }
    }
}