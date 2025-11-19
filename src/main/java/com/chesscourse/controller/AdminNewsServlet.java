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

@WebServlet("/admin-news")
public class AdminNewsServlet extends HttpServlet {
    private NewsDAO newsDAO = new NewsDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is admin
        HttpSession session = request.getSession();
        com.chesscourse.model.User user = (com.chesscourse.model.User) session.getAttribute("user");
        
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect("login.jsp?error=Access denied");
            return;
        }
        
        // Get all news
        request.setAttribute("newsList", newsDAO.findAll());
        request.getRequestDispatcher("admin-news.jsp").forward(request, response);
    }
}