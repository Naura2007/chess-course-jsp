<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
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
        <h1>♟️ Admin Dashboard</h1>
        
        <div class="user-info">
            <%
                com.chesscourse.model.User user = (com.chesscourse.model.User) session.getAttribute("user");
                if (user != null) {
            %>
                <h3>Welcome back, <%= user.getName() %>! 👋</h3>
                <p>Email: <%= user.getEmail() %> | Role: <%= user.getRole() %> | Member since: <%= user.getCreatedAt().toLocalDate() %></p>
            <%
                } else {
                    response.sendRedirect("login.jsp");
                    return;
                }
            %>
        </div>

        <div class="welcome">
            <p>Welcome to Chess Course Admin Panel! Manage courses, users, and feedback from here.</p>
        </div>

        <!-- Quick Stats -->
        <%
            if (user != null) {
                com.chesscourse.dao.CourseDAO courseDAO = new com.chesscourse.dao.CourseDAO();
                int courseCount = courseDAO.findAll().size();
                
                com.chesscourse.dao.UserDAO userDAO = new com.chesscourse.dao.UserDAO();
                int userCount = userDAO.getAllUsers().size();
                
                com.chesscourse.dao.FeedbackDAO feedbackDAO = new com.chesscourse.dao.FeedbackDAO();
                int feedbackCount = feedbackDAO.getAllFeedback().size();
                
                com.chesscourse.dao.NewsDAO newsDAO = new com.chesscourse.dao.NewsDAO();
                int newsCount = newsDAO.findAll().size();
        %>
            <div class="stats">
                <div class="stat-card">
                    <div class="stat-number"><%= courseCount %></div>
                    <div class="stat-label">Total Courses</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number"><%= userCount %></div>
                    <div class="stat-label">Total Users</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number"><%= feedbackCount %></div>
                    <div class="stat-label">Total Feedback</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number"><%= newsCount %></div>
                    <div class="stat-label">Total News</div>
                </div>
            </div>
        <%
            }
        %>
        
        <div class="menu">
            <a href="admin-courses">
                <div>📚</div>
                Manage Courses
            </a>
            <a href="admin-news">
                <div>📢</div>
                Manage News
            </a>
            <a href="admin-users">
                <div>👥</div>
                Manage Users
            </a>
            <a href="admin-feedback">
                <div>💬</div>
                Manage Feedback
            </a>
            <a href="courses">
                <div>👀</div>
                View Courses
            </a>
            <a href="news">
                <div>📰</div>
                View News
            </a>
            <a href="login">
                <div>🚪</div>
                Logout
            </a>
        </div>
    </div>
</body>
</html>