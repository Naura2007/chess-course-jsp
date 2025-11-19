package com.chesscourse.controller;

import com.chesscourse.dao.UserDAO;
import com.chesscourse.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin-users")
public class AdminUserServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is admin
        HttpSession session = request.getSession();
        User adminUser = (User) session.getAttribute("user");
        
        if (adminUser == null || !"admin".equals(adminUser.getRole())) {
            response.sendRedirect("login.jsp?error=Access denied");
            return;
        }
        
        // Get all users
        var users = userDAO.getAllUsers();
        request.setAttribute("users", users);
        
        request.getRequestDispatcher("admin-users.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User adminUser = (User) session.getAttribute("user");
        
        // Check if user is admin
        if (adminUser == null || !"admin".equals(adminUser.getRole())) {
            response.sendRedirect("login.jsp?error=Access denied");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            deleteUser(request, response, adminUser);
        }
    }
    
    private void deleteUser(HttpServletRequest request, HttpServletResponse response, User adminUser) 
            throws IOException {
        
        try {
            int userId = Integer.parseInt(request.getParameter("id"));
            
            // Prevent admin from deleting themselves
            if (userId == adminUser.getId()) {
                response.sendRedirect("admin-users?error=Cannot delete your own account");
                return;
            }
            
            if (userDAO.deleteUser(userId)) {
                System.out.println("✅ Admin deleted user ID: " + userId);
                response.sendRedirect("admin-users?success=User deleted successfully");
            } else {
                response.sendRedirect("admin-users?error=Failed to delete user");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin-users?error=Error: " + e.getMessage());
        }
    }
}