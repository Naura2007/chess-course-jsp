package com.chesscourse.controller;

import com.chesscourse.dao.UserDAO;
import com.chesscourse.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Check if user already exists
        if (userDAO.findByEmail(email) != null) {
            request.setAttribute("error", "Email already registered");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Create new user with 'user' role
        User newUser = new User(name, email, password, "user");
        
        if (userDAO.create(newUser)) {
            response.sendRedirect("login.jsp?success=Registration successful. Please login.");
        } else {
            request.setAttribute("error", "Registration failed");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}