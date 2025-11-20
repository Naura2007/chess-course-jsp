<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Enrollments - Chess Course</title>
    <style>
        body { font-family: Arial; margin: 0; padding: 20px; background: #f0f8ff; }
        header { background: #ADD8E6; padding: 20px; text-align: center; color: white; margin-bottom: 30px; }
        .container { max-width: 1000px; margin: 0 auto; }
        .enrollments-grid { display: grid; gap: 20px; }
        .enrollment-card { background: white; padding: 25px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); border-left: 4px solid #28a745; }
        .enrollment-title { color: #2c3e50; margin-top: 0; font-size: 1.3em; }
        .enrollment-meta { color: #666; font-size: 0.9em; margin-bottom: 15px; }
        .enrollment-date { background: #e8f5e8; padding: 5px 10px; border-radius: 4px; display: inline-block; }
        .cancel-btn { background: #dc3545; color: white; padding: 8px 15px; border: none; border-radius: 4px; cursor: pointer; }
        .cancel-btn:hover { background: #c82333; }
        .no-enrollments { text-align: center; padding: 40px; background: white; border-radius: 8px; }
        .success { background: #e8f5e8; color: #2e7d32; padding: 15px; border-radius: 6px; margin-bottom: 20px; }
        .error { background: #ffebee; color: #c62828; padding: 15px; border-radius: 6px; margin-bottom: 20px; }
        .nav-links { text-align: center; margin: 20px 0; }
        .nav-links a { color: #ADD8E6; text-decoration: none; margin: 0 15px; font-weight: bold; }
        .nav-links a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <header>
        <h1>⫘ My Course Enrollments</h1>
        <div class="nav-links">
            <a href="user-dashboard.jsp">Dashboard</a>
            <a href="courses">Browse Courses</a>
            <a href="news">News</a>
            <a href="login">Logout</a>
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

        <c:choose>
            <c:when test="${empty enrollments}">
                <div class="no-enrollments">
                    <h3>No enrollments yet</h3>
                    <p>You haven't enrolled in any courses yet.</p>
                    <a href="courses" style="background: #ADD8E6; color: white; padding: 10px 20px; text-decoration: none; border-radius: 4px; display: inline-block; margin-top: 15px;">
                        Browse Available Courses
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="enrollments-grid">
                    <c:forEach var="enrollment" items="${enrollments}">
                        <div class="enrollment-card">
                            <h2 class="enrollment-title">${enrollment.courseTitle}</h2>
                            <div class="enrollment-meta">
                                <strong>Coach:</strong> ${enrollment.coachName}
                            </div>
                            <div class="enrollment-date">
                                <strong>Enrolled on:</strong> ${enrollment.enrolledAt.toLocalDate()} at ${enrollment.enrolledAt.toLocalTime()}
                            </div>
                            
                            <div style="margin-top: 20px;">
                                <form action="enroll" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="cancel">
                                    <input type="hidden" name="courseId" value="${enrollment.courseId}">
                                    <button type="submit" class="cancel-btn" 
                                            onclick="return confirm('Are you sure you want to cancel this enrollment?')">
                                        Cancel Enrollment
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