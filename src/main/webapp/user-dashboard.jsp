<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard - Chess Course</title>
    <style>
        body { font-family: Arial; padding: 20px; background: #f0f8ff; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h1 { color: #2c3e50; text-align: center; }
        .menu { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; margin-top: 30px; }
        .menu a { display: block; padding: 20px; background: #ADD8E6; text-decoration: none; color: white; border-radius: 8px; text-align: center; font-weight: bold; transition: all 0.3s ease; }
        .menu a:hover { background: #9bc4d4; transform: translateY(-2px); box-shadow: 0 4px 8px rgba(0,0,0,0.2); }
        .welcome { text-align: center; margin-bottom: 30px; color: #666; padding: 20px; background: #f8f9fa; border-radius: 8px; }
        .user-info { background: #e8f5e8; padding: 15px; border-radius: 6px; margin-bottom: 20px; text-align: center; }
        .stats { display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 15px; margin: 20px 0; }
        .stat-card { background: #f8f9fa; padding: 15px; border-radius: 6px; text-align: center; border-left: 4px solid #ADD8E6; }
        .stat-number { font-size: 2em; font-weight: bold; color: #2c3e50; }
        .stat-label { color: #666; font-size: 0.9em; }
    </style>
</head>
<body>
    <div class="container">
        <h1>♟️ User Dashboard</h1>
        
        <div class="user-info">
            <%
                com.chesscourse.model.User user = (com.chesscourse.model.User) session.getAttribute("user");
                if (user != null) {
            %>
                <h3>Welcome back, <%= user.getName() %>! 👋</h3>
                <p>Email: <%= user.getEmail() %> | Member since: <%= user.getCreatedAt().toLocalDate() %></p>
            <%
                } else {
                    response.sendRedirect("login.jsp");
                    return;
                }
            %>
        </div>

        <div class="welcome">
            <p>Manage your chess learning journey. Browse courses, track your enrollments, and stay updated with news!</p>
        </div>

        <!-- Quick Stats -->
        <%
            // DECLARE VARIABLES OUTSIDE THE BLOCK
            int enrollmentCount = 0;
            int feedbackCount = 0;
            
            if (user != null) {
                com.chesscourse.dao.EnrollmentDAO enrollmentDAO = new com.chesscourse.dao.EnrollmentDAO();
                enrollmentCount = enrollmentDAO.getEnrollmentsByUserId(user.getId()).size();
                
                com.chesscourse.dao.FeedbackDAO feedbackDAO = new com.chesscourse.dao.FeedbackDAO();
                feedbackCount = feedbackDAO.getFeedbackByUserId(user.getId()).size();
            }
        %>
            <div class="stats">
                <div class="stat-card">
                    <div class="stat-number"><%= enrollmentCount %></div>
                    <div class="stat-label">Courses Enrolled</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">0</div>
                    <div class="stat-label">Completed</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number"><%= feedbackCount %></div>
                    <div class="stat-label">Feedback Given</div>
                </div>
            </div>
        
        <div class="menu">
            <a href="courses">
                <div>📚</div>
                Browse Courses
            </a>
            <a href="my-enrollments">
                <div>🎯</div>
                My Enrollments
            </a>
            <a href="my-feedback">
                <div>💬</div>
                My Feedback
            </a>
            <a href="news">
                <div>📰</div>
                News & Updates
            </a>
            <a href="login">
                <div>🚪</div>
                Logout
            </a>
        </div>

        <!-- Recent Activity Section -->
        <div style="margin-top: 40px; padding: 20px; background: #f8f9fa; border-radius: 8px;">
            <h3 style="color: #2c3e50; margin-top: 0;">Quick Actions</h3>
            <%
                // NOW VARIABLES ARE ACCESSIBLE HERE
                if (enrollmentCount > 0) {
            %>
                <p>🎯 You're enrolled in <strong><%= enrollmentCount %></strong> courses</p>
                <p><a href="my-enrollments" style="color: #ADD8E6; text-decoration: none; font-weight: bold;">→ View your enrollments</a></p>
            <%
                } else {
            %>
                <p>📚 You haven't enrolled in any courses yet</p>
                <p><a href="courses" style="color: #ADD8E6; text-decoration: none; font-weight: bold;">→ Browse available courses</a></p>
            <%
                }
                
                if (feedbackCount > 0) {
            %>
                <p>💬 You've given <strong><%= feedbackCount %></strong> feedback</p>
                <p><a href="my-feedback" style="color: #ADD8E6; text-decoration: none; font-weight: bold;">→ View your feedback</a></p>
            <%
                } else {
            %>
                <p>💬 You haven't given any feedback yet</p>
                <p><a href="give-feedback.jsp" style="color: #ADD8E6; text-decoration: none; font-weight: bold;">→ Give your first feedback</a></p>
            <%
                }
            %>
        </div>
    </div>
</body>
</html>