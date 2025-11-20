package com.chesscourse.controller;

import com.chesscourse.dao.CourseDAO;
import com.chesscourse.model.Course;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin-courses")
public class AdminCourseServlet extends HttpServlet {
    private CourseDAO courseDAO = new CourseDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        com.chesscourse.model.User user = (com.chesscourse.model.User) session.getAttribute("user");
        
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect("login.jsp?error=Access denied");
            return;
        }
        
        List<Course> courses = courseDAO.findAll();
        request.setAttribute("courses", courses);
        
        request.getRequestDispatcher("admin-courses.jsp").forward(request, response);
    }
}