<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Courses - Admin</title>
    <style>
        body { font-family: Arial; margin: 0; padding: 20px; background: #f0f8ff; }
        header { background: #ADD8E6; padding: 20px; text-align: center; color: white; margin-bottom: 30px; }
        .container { max-width: 1200px; margin: 0 auto; }
        .admin-actions { margin-bottom: 20px; }
        .create-btn { background: #28a745; color: white; padding: 12px 20px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; display: inline-block; }
        .create-btn:hover { background: #218838; }
        .courses-table { width: 100%; background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #f8f9fa; font-weight: bold; }
        .action-btn { padding: 6px 12px; border: none; border-radius: 4px; cursor: pointer; margin-right: 5px; text-decoration: none; display: inline-block; font-size: 12px; }
        .edit-btn { background: #ffc107; color: black; }
        .delete-btn { background: #dc3545; color: white; }
        .level-badge { padding: 4px 12px; border-radius: 20px; font-size: 12px; font-weight: bold; }
        .beginner { background: #e8f5e8; color: #2e7d32; }
        .intermediate { background: #e3f2fd; color: #1565c0; }
        .advanced { background: #fce4ec; color: #c2185b; }
        .success { background: #e8f5e8; color: #2e7d32; padding: 15px; border-radius: 6px; margin-bottom: 20px; }
        .error { background: #ffebee; color: #c62828; padding: 15px; border-radius: 6px; margin-bottom: 20px; }
        .no-courses { text-align: center; padding: 40px; background: white; border-radius: 8px; }
    </style>
</head>
<body>
    <header>
        <h1>⫘ Manage Courses - Admin Panel</h1>
        <nav>
            <a href="admin-dashboard.jsp" style="color: white; margin: 0 15px;">Dashboard</a>
            <a href="courses" style="color: white; margin: 0 15px;">View Courses</a>
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

        <div class="admin-actions">
            <a href="create-course.jsp" class="create-btn">+ Create New Course</a>
        </div>

        <c:choose>
            <c:when test="${empty courses}">
                <div class="no-courses">
                    <h3>No courses available</h3>
                    <p>Create your first chess course to get started!</p>
                    <a href="create-course.jsp" class="create-btn">Create First Course</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="courses-table">
                    <table>
                        <thead>
                            <tr>
                                <th>Title</th>
                                <th>Level</th>
                                <th>Coach</th>
                                <th>Quota</th>
                                <th>Schedule</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="course" items="${courses}">
                                <tr>
                                    <td>
                                        <strong>${course.title}</strong>
                                        <br><small>${course.description}</small>
                                    </td>
                                    <td>
                                        <span class="level-badge ${course.level.toLowerCase()}">
                                            ${course.level}
                                        </span>
                                    </td>
                                    <td>${course.coachName}</td>
                                    <td>${course.quota} students</td>
                                    <td>
                                        ${course.startTime.toLocalDate()}
                                        <br>
                                        <small>${course.startTime.toLocalTime()} - ${course.endTime.toLocalTime()}</small>
                                    </td>
                                    <td>
                                        <small style="color: #666;">ID: ${course.id}</small><br>
                                        
                                        <a href="courses?action=edit&id=${course.id}" class="action-btn edit-btn">
                                            Edit
                                        </a>
                                        <form action="courses" method="post" style="display: inline;">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="${course.id}">
                                            <button type="submit" class="action-btn delete-btn" 
                                                    onclick="return confirm('Are you sure you want to delete this course? This action cannot be undone.')">
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