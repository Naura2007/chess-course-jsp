package com.chesscourse.controller;

import com.chesscourse.dao.CourseDAO;
import com.chesscourse.model.Course;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/courses")
public class CourseServlet extends HttpServlet {
    private CourseDAO courseDAO = new CourseDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        System.out.println("=== COURSE SERVLET DOGET ===");
        System.out.println("Action: " + action);
        
        if ("create".equals(action)) {
            // Show create course form
            request.getRequestDispatcher("create-course.jsp").forward(request, response);
        } else if ("edit".equals(action)) {
            // Show edit course form
            try {
                int courseId = Integer.parseInt(request.getParameter("id"));
                System.out.println("Editing course ID: " + courseId);
                
                Course course = courseDAO.findById(courseId);
                System.out.println("Found course: " + course);
                
                if (course != null) {
                    request.setAttribute("course", course);
                    request.getRequestDispatcher("edit-course.jsp").forward(request, response);
                } else {
                    response.sendRedirect("admin-courses?error=Course not found");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("admin-courses?error=Invalid course ID");
            }
        } else {
            // Show all courses
            request.setAttribute("courses", courseDAO.findAll());
            request.getRequestDispatcher("courses.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        System.out.println("=== COURSE SERVLET DOPOST ===");
        System.out.println("Action: " + action);
        
        if ("create".equals(action)) {
            createCourse(request, response);
        } else if ("update".equals(action)) {
            updateCourse(request, response);
        } else if ("delete".equals(action)) {
            deleteCourse(request, response);
        }
    }
    
    private void createCourse(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String level = request.getParameter("level");
            String startTimeStr = request.getParameter("start_time");
            String endTimeStr = request.getParameter("end_time");
            int quota = Integer.parseInt(request.getParameter("quota"));
            String coachName = request.getParameter("coach_name");
            
            System.out.println("=== CREATING COURSE ===");
            System.out.println("Title: " + title);
            System.out.println("Level: " + level);
            System.out.println("Coach: " + coachName);
            System.out.println("Quota: " + quota);
            System.out.println("Start: " + startTimeStr);
            System.out.println("End: " + endTimeStr);
            
            // Parse datetime
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            LocalDateTime startTime = LocalDateTime.parse(startTimeStr, formatter);
            LocalDateTime endTime = LocalDateTime.parse(endTimeStr, formatter);
            
            // Validate end time after start time
            if (endTime.isBefore(startTime)) {
                response.sendRedirect("create-course.jsp?error=End time must be after start time");
                return;
            }
            
            // Create course object
            Course course = new Course(title, description, level, startTime, endTime, quota, coachName);
            
            // Save to database
            if (courseDAO.create(course)) {
                System.out.println("Course created successfully!");
                response.sendRedirect("admin-courses?success=Course created successfully");
            } else {
                System.out.println("Failed to create course");
                response.sendRedirect("create-course.jsp?error=Failed to create course");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("create-course.jsp?error=Error: " + e.getMessage());
        }
    }
    
    private void updateCourse(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        try {
            int courseId = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String level = request.getParameter("level");
            String startTimeStr = request.getParameter("start_time");
            String endTimeStr = request.getParameter("end_time");
            int quota = Integer.parseInt(request.getParameter("quota"));
            String coachName = request.getParameter("coach_name");
            
            System.out.println("=== UPDATING COURSE ===");
            System.out.println("Course ID: " + courseId);
            System.out.println("Title: " + title);
            
            // Parse datetime
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            LocalDateTime startTime = LocalDateTime.parse(startTimeStr, formatter);
            LocalDateTime endTime = LocalDateTime.parse(endTimeStr, formatter);
            
            // Validate end time after start time
            if (endTime.isBefore(startTime)) {
                response.sendRedirect("edit-course.jsp?error=End time must be after start time&id=" + courseId);
                return;
            }
            
            // Create updated course object
            Course updatedCourse = new Course(title, description, level, startTime, endTime, quota, coachName);
            updatedCourse.setId(courseId);
            
            if (courseDAO.update(updatedCourse)) {
                System.out.println("✅ Course updated successfully!");
                response.sendRedirect("admin-courses?success=Course updated successfully");
            } else {
                System.out.println("❌ Failed to update course");
                response.sendRedirect("edit-course.jsp?error=Failed to update course&id=" + courseId);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("edit-course.jsp?error=Error: " + e.getMessage());
        }
    }
    
    private void deleteCourse(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        try {
            int courseId = Integer.parseInt(request.getParameter("id"));
            
            System.out.println("=== DELETING COURSE ===");
            System.out.println("Course ID: " + courseId);
            
            if (courseDAO.delete(courseId)) {
                System.out.println("✅ Course deleted successfully!");
                response.sendRedirect("admin-courses?success=Course deleted successfully");
            } else {
                response.sendRedirect("admin-courses?error=Failed to delete course");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin-courses?error=Error: " + e.getMessage());
        }
    }
}