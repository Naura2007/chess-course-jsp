<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Available Courses - Chess Course</title>
    <style>
        body { font-family: Arial; margin: 0; padding: 20px; background: #f0f8ff; }
        header { background: #ADD8E6; padding: 20px; text-align: center; color: white; margin-bottom: 30px; }
        .container { max-width: 1200px; margin: 0 auto; }
        .courses-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; }
        .course-card { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .course-card h3 { color: #2c3e50; margin-top: 0; }
        .course-level { display: inline-block; padding: 4px 12px; border-radius: 20px; font-size: 12px; font-weight: bold; }
        .level-beginner { background: #e8f5e8; color: #2e7d32; }
        .level-intermediate { background: #e3f2fd; color: #1565c0; }
        .level-advanced { background: #fce4ec; color: #c2185b; }
        .course-meta { color: #666; font-size: 14px; margin: 10px 0; }
        .enroll-btn { 
            background: #ADD8E6; 
            color: white; 
            padding: 10px 15px; 
            border: none; 
            border-radius: 4px; 
            cursor: pointer; 
            width: 100%; 
            font-size: 14px;
            font-weight: bold;
        }
        .enroll-btn:hover:not(:disabled) { background: #9bc4d4; }
        .enroll-btn:disabled { 
            background: #6c757d; 
            cursor: not-allowed; 
        }
        .success { background: #e8f5e8; color: #2e7d32; padding: 15px; border-radius: 6px; margin-bottom: 20px; }
        .error { background: #ffebee; color: #c62828; padding: 15px; border-radius: 6px; margin-bottom: 20px; }
        .nav-links { text-align: center; margin: 20px 0; }
        .nav-links a { color: #ADD8E6; text-decoration: none; margin: 0 15px; font-weight: bold; }
        .nav-links a:hover { text-decoration: underline; }
        .quota-info { font-size: 12px; color: #666; margin-top: 5px; }
        .enrollment-status { text-align: center; margin-top: 10px; }
    </style>
</head>
<body>
    <header>
        <h1>⫘ Available Chess Courses</h1>
        <div class="nav-links">
            <a href="index.jsp">Home</a>
            <c:choose>
                <c:when test="${not empty user && user.role == 'admin'}">
                    <a href="admin-dashboard.jsp">Dashboard</a>
                    <a href="admin-courses">Manage Courses</a>
                </c:when>
                <c:when test="${not empty user}">
                    <a href="user-dashboard.jsp">Dashboard</a>
                    <a href="my-enrollments">My Enrollments</a>
                </c:when>
                <c:otherwise>
                    <a href="login.jsp">Login</a>
                    <a href="register.jsp">Register</a>
                </c:otherwise>
            </c:choose>
            <a href="news">News</a>
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

        <c:if test="${empty courses}">
            <div style="text-align: center; padding: 40px;">
                <h3>No courses available yet</h3>
                <p>Check back later for new chess courses!</p>
                <c:if test="${not empty user && user.role == 'admin'}">
                    <a href="create-course.jsp" style="background: #ADD8E6; color: white; padding: 10px 20px; text-decoration: none; border-radius: 4px; display: inline-block; margin-top: 15px;">
                        Create First Course
                    </a>
                </c:if>
            </div>
        </c:if>

        <div class="courses-grid">
            <c:forEach var="course" items="${courses}">
                <div class="course-card">
                    <h3>${course.title}</h3>
                    
                    <div>
                        <span class="course-level level-${course.level.toLowerCase()}">
                            ${course.level}
                        </span>
                    </div>
                    
                    <div class="course-meta">
                        <p><strong>Coach:</strong> ${course.coachName}</p>
                        <p><strong>Quota:</strong> ${course.quota} students</p>
                        <p><strong>Schedule:</strong> 
                            ${course.startTime.toLocalDate()} 
                            ${course.startTime.toLocalTime()}
                        </p>
                        <p><strong>Duration:</strong> 
                            ${course.startTime.toLocalTime()} - ${course.endTime.toLocalTime()}
                        </p>
                    </div>
                    
                    <p>${course.description}</p>
                    
                    <jsp:useBean id="enrollmentDAO" class="com.chesscourse.dao.EnrollmentDAO"/>
                    
                    <c:choose>
                        <%-- ADMIN VIEW --%>
                        <c:when test="${not empty user && user.role == 'admin'}">
                            <div style="display: flex; gap: 10px; margin-top: 15px;">
                                <a href="courses?action=edit&id=${course.id}" 
                                   style="flex: 1; background: #ffc107; color: black; padding: 8px; text-align: center; text-decoration: none; border-radius: 4px;">
                                    Edit
                                </a>
                                <button onclick="confirmDelete(${course.id})" 
                                        style="flex: 1; background: #dc3545; color: white; padding: 8px; border: none; border-radius: 4px; cursor: pointer;">
                                    Delete
                                </button>
                            </div>
                            <div class="quota-info">
                                <c:set var="enrollmentCount" value="${enrollmentDAO.getEnrollmentCount(course.id)}"/>
                                Enrollments: ${enrollmentCount}/${course.quota}
                            </div>
                        </c:when>
                        
                        <%-- USER VIEW - LOGGED IN --%>
                        <c:when test="${not empty user}">
                            <c:set var="isEnrolled" value="${enrollmentDAO.isUserEnrolled(user.id, course.id)}"/>
                            <c:set var="enrollmentCount" value="${enrollmentDAO.getEnrollmentCount(course.id)}"/>
                            
                            <c:choose>
                                <c:when test="${isEnrolled}">
                                    <button class="enroll-btn" disabled>
                                        ✓ Already Enrolled
                                    </button>
                                    <div class="enrollment-status">
                                        <a href="my-enrollments" style="color: #ADD8E6; text-decoration: none; font-size: 0.9em;">
                                            View in My Enrollments
                                        </a>
                                    </div>
                                </c:when>
                                <c:when test="${enrollmentCount >= course.quota}">
                                    <button class="enroll-btn" disabled>
                                        Course Full
                                    </button>
                                    <div class="quota-info">
                                        All ${course.quota} spots are filled
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <form action="enroll" method="post">
                                        <input type="hidden" name="action" value="enroll">
                                        <input type="hidden" name="courseId" value="${course.id}">
                                        <button type="submit" class="enroll-btn">
                                            Enroll Now
                                        </button>
                                    </form>
                                    <div class="quota-info">
                                        ${course.quota - enrollmentCount} spots remaining
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        
                        <%-- GUEST VIEW --%>
                        <c:otherwise>
                            <a href="login.jsp" class="enroll-btn" style="text-decoration: none; display: block; text-align: center;">
                                Login to Enroll
                            </a>
                            <div class="quota-info">
                                ${course.quota} spots available
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:forEach>
        </div>
    </div>

    <script>
        function confirmDelete(courseId) {
            if (confirm('Are you sure you want to delete this course?')) {
                alert('Delete feature coming soon! Course ID: ' + courseId);
            }
        }
    </script>
</body>
</html>