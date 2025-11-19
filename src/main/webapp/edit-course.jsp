<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Course - Admin</title>
    <style>
        body { font-family: Arial; margin: 0; padding: 20px; background: #f0f8ff; }
        header { background: #ADD8E6; padding: 20px; text-align: center; color: white; margin-bottom: 30px; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: bold; color: #333; }
        input, select, textarea { width: 100%; padding: 12px; border: 2px solid #ddd; border-radius: 6px; font-size: 14px; }
        textarea { height: 100px; resize: vertical; }
        .btn { padding: 12px 25px; border: none; border-radius: 6px; cursor: pointer; font-size: 16px; text-decoration: none; display: inline-block; }
        .submit-btn { background: #ffc107; color: black; }
        .submit-btn:hover { background: #e0a800; }
        .cancel-btn { background: #6c757d; color: white; margin-left: 10px; }
        .cancel-btn:hover { background: #545b62; }
        .form-actions { text-align: center; margin-top: 30px; }
        .error { background: #ffebee; color: #c62828; padding: 15px; border-radius: 6px; margin-bottom: 20px; }
        .success { background: #e8f5e8; color: #2e7d32; padding: 15px; border-radius: 6px; margin-bottom: 20px; }
    </style>
</head>
<body>
    <header>
        <h1>♟️ Edit Course</h1>
        <nav>
            <a href="admin-courses" style="color: white; margin: 0 15px;">Back to Courses</a>
            <a href="admin-dashboard.jsp" style="color: white; margin: 0 15px;">Dashboard</a>
        </nav>
    </header>

    <div class="container">
        <%
            String error = request.getParameter("error");
            if (error != null) {
        %>
            <div class="error">
                <strong>Error:</strong> <%= error %>
            </div>
        <%
            }
            
            String success = request.getParameter("success");
            if (success != null) {
        %>
            <div class="success">
                <strong>Success:</strong> <%= success %>
            </div>
        <%
            }
        %>

        <c:if test="${not empty course}">
            <form action="courses" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="${course.id}">
                
                <div class="form-group">
                    <label for="title">Course Title:</label>
                    <input type="text" id="title" name="title" required value="${course.title}">
                </div>

                <div class="form-group">
                    <label for="description">Description:</label>
                    <textarea id="description" name="description" required>${course.description}</textarea>
                </div>

                <div class="form-group">
                    <label for="level">Difficulty Level:</label>
                    <select id="level" name="level" required>
                        <option value="Beginner" ${course.level == 'Beginner' ? 'selected' : ''}>Beginner</option>
                        <option value="Intermediate" ${course.level == 'Intermediate' ? 'selected' : ''}>Intermediate</option>
                        <option value="Advanced" ${course.level == 'Advanced' ? 'selected' : ''}>Advanced</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="coach_name">Coach Name:</label>
                    <input type="text" id="coach_name" name="coach_name" required value="${course.coachName}">
                </div>

                <div class="form-group">
                    <label for="quota">Student Quota:</label>
                    <input type="number" id="quota" name="quota" required min="1" max="50" value="${course.quota}">
                </div>

                <div class="form-group">
                    <label for="start_time">Start Date & Time:</label>
                    <%
                        // Format datetime for HTML input
                        com.chesscourse.model.Course courseObj = (com.chesscourse.model.Course) request.getAttribute("course");
                        String startTimeValue = "";
                        String endTimeValue = "";
                        if (courseObj != null) {
                            startTimeValue = courseObj.getStartTime().toString().replace(" ", "T");
                            endTimeValue = courseObj.getEndTime().toString().replace(" ", "T");
                        }
                    %>
                    <input type="datetime-local" id="start_time" name="start_time" required value="<%= startTimeValue %>">
                </div>

                <div class="form-group">
                    <label for="end_time">End Date & Time:</label>
                    <input type="datetime-local" id="end_time" name="end_time" required value="<%= endTimeValue %>">
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn submit-btn">Update Course</button>
                    <a href="admin-courses" class="btn cancel-btn">Cancel</a>
                </div>
            </form>
        </c:if>

        <c:if test="${empty course}">
            <div class="error">
                <strong>Error:</strong> Course not found or invalid course ID.
            </div>
            <div class="form-actions">
                <a href="admin-courses" class="btn cancel-btn">Back to Courses</a>
            </div>
        </c:if>
    </div>
</body>
</html>