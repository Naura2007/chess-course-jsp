<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Feedback - Chess Course</title>
    <style>
        body { font-family: Arial; margin: 0; padding: 20px; background: #f0f8ff; }
        header { background: #ADD8E6; padding: 20px; text-align: center; color: white; margin-bottom: 30px; }
        .container { max-width: 1000px; margin: 0 auto; }
        .feedback-grid { display: grid; gap: 20px; }
        .feedback-card { background: white; padding: 25px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); border-left: 4px solid #FFA000; }
        .feedback-course { color: #2c3e50; margin-top: 0; font-size: 1.3em; }
        .feedback-meta { color: #666; font-size: 0.9em; margin-bottom: 15px; }
        .feedback-message { background: #fff8e1; padding: 15px; border-radius: 6px; margin: 15px 0; line-height: 1.6; }
        .feedback-date { background: #e8f5e8; padding: 5px 10px; border-radius: 4px; display: inline-block; font-size: 0.9em; }
        .delete-btn { background: #dc3545; color: white; padding: 8px 15px; border: none; border-radius: 4px; cursor: pointer; }
        .delete-btn:hover { background: #c82333; }
        .give-feedback-btn { background: #28a745; color: white; padding: 12px 20px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; display: inline-block; margin-bottom: 20px; }
        .give-feedback-btn:hover { background: #218838; }
        .no-feedback { text-align: center; padding: 40px; background: white; border-radius: 8px; }
        .success { background: #e8f5e8; color: #2e7d32; padding: 15px; border-radius: 6px; margin-bottom: 20px; }
        .error { background: #ffebee; color: #c62828; padding: 15px; border-radius: 6px; margin-bottom: 20px; }
        .nav-links { text-align: center; margin: 20px 0; }
        .nav-links a { color: #ADD8E6; text-decoration: none; margin: 0 15px; font-weight: bold; }
        .nav-links a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <header>
        <h1>♟️ My Feedback</h1>
        <div class="nav-links">
            <a href="user-dashboard.jsp">Dashboard</a>
            <a href="courses">Browse Courses</a>
            <a href="my-enrollments">My Enrollments</a>
            <a href="give-feedback.jsp">Give Feedback</a>
        </div>
    </header>

    <div class="container">
        <%
            String success = request.getParameter("success");
            if (success != null) {
        %>
            <div class="success">
                <strong>Success:</strong> <%= success %>
            </div>
        <%
            }
            
            String error = request.getParameter("error"); 
            if (error != null) {
        %>
            <div class="error">
                <strong>Error:</strong> <%= error %>
            </div>
        <%
            }
        %>

        <a href="give-feedback.jsp" class="give-feedback-btn">+ Give New Feedback</a>

        <c:choose>
            <c:when test="${empty feedbackList}">
                <div class="no-feedback">
                    <h3>No feedback yet</h3>
                    <p>You haven't submitted any feedback yet.</p>
                    <a href="give-feedback.jsp" class="give-feedback-btn">Give Your First Feedback</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="feedback-grid">
                    <c:forEach var="feedback" items="${feedbackList}">
                        <div class="feedback-card">
                            <h2 class="feedback-course">${feedback.courseTitle}</h2>
                            <div class="feedback-meta">
                                <strong>Submitted on:</strong> 
                                <span class="feedback-date">
                                    ${feedback.createdAt.toLocalDate()} at ${feedback.createdAt.toLocalTime()}
                                </span>
                            </div>
                            
                            <div class="feedback-message">
                                "${feedback.message}"
                            </div>
                            
                            <div style="margin-top: 15px;">
                                <form action="my-feedback" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="${feedback.id}">
                                    <button type="submit" class="delete-btn" 
                                            onclick="return confirm('Are you sure you want to delete this feedback?')">
                                        Delete Feedback
                                    </button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>