<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Feedback - Admin</title>
    <style>
        body { font-family: Arial; margin: 0; padding: 20px; background: #f0f8ff; }
        header { background: #ADD8E6; padding: 20px; text-align: center; color: white; margin-bottom: 30px; }
        .container { max-width: 1200px; margin: 0 auto; }
        .feedback-table { width: 100%; background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #f8f9fa; font-weight: bold; }
        .delete-btn { background: #dc3545; color: white; padding: 6px 12px; border: none; border-radius: 4px; cursor: pointer; font-size: 12px; }
        .success { background: #e8f5e8; color: #2e7d32; padding: 15px; border-radius: 6px; margin-bottom: 20px; }
        .error { background: #ffebee; color: #c62828; padding: 15px; border-radius: 6px; margin-bottom: 20px; }
        .no-feedback { text-align: center; padding: 40px; background: white; border-radius: 8px; }
        .feedback-message { background: #fff8e1; padding: 10px; border-radius: 4px; margin: 5px 0; }
        .user-info { color: #666; font-size: 0.9em; }
    </style>
</head>
<body>
    <header>
        <h1>⫘ Manage Feedback - Admin Panel</h1>
        <nav>
            <a href="admin-dashboard.jsp" style="color: white; margin: 0 15px;">Dashboard</a>
            <a href="admin-courses" style="color: white; margin: 0 15px;">Manage Courses</a>
            <a href="login" style="color: white; margin: 0 15px;">Logout</a>
        </nav>
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

        <c:choose>
            <c:when test="${empty feedbackList}">
                <div class="no-feedback">
                    <h3>No feedback available</h3>
                    <p>Users haven't submitted any feedback yet.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="feedback-table">
                    <table>
                        <thead>
                            <tr>
                                <th>User</th>
                                <th>Course</th>
                                <th>Feedback</th>
                                <th>Submitted</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="feedback" items="${feedbackList}">
                                <tr>
                                    <td>
                                        <strong>${feedback.userName}</strong>
                                        <div class="user-info">User ID: ${feedback.userId}</div>
                                    </td>
                                    <td>
                                        <strong>${feedback.courseTitle}</strong>
                                        <div class="user-info">Course ID: ${feedback.courseId}</div>
                                    </td>
                                    <td>
                                        <div class="feedback-message">
                                            "${feedback.message}"
                                        </div>
                                    </td>
                                    <td>
                                        ${feedback.createdAt.toLocalDate()}
                                        <br>
                                        <small>${feedback.createdAt.toLocalTime()}</small>
                                    </td>
                                    <td>
                                        <form action="admin-feedback" method="post" style="display: inline;">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="${feedback.id}">
                                            <button type="submit" class="delete-btn" 
                                                    onclick="return confirm('Are you sure you want to delete this feedback?')">
                                                Delete
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>