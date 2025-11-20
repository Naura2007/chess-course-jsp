<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Give Feedback - Chess Course</title>
    <style>
        body { font-family: Arial; margin: 0; padding: 20px; background: #f0f8ff; }
        header { background: #ADD8E6; padding: 20px; text-align: center; color: white; margin-bottom: 30px; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: bold; color: #333; }
        select, textarea { width: 100%; padding: 12px; border: 2px solid #ddd; border-radius: 6px; font-size: 14px; }
        textarea { height: 150px; resize: vertical; }
        .btn { padding: 12px 25px; border: none; border-radius: 6px; cursor: pointer; font-size: 16px; text-decoration: none; display: inline-block; }
        .submit-btn { background: #28a745; color: white; }
        .submit-btn:hover { background: #218838; }
        .cancel-btn { background: #6c757d; color: white; margin-left: 10px; }
        .cancel-btn:hover { background: #545b62; }
        .form-actions { text-align: center; margin-top: 30px; }
        .error { background: #ffebee; color: #c62828; padding: 15px; border-radius: 6px; margin-bottom: 20px; border-left: 4px solid #c62828; }
        .char-count { text-align: right; font-size: 12px; color: #666; margin-top: 5px; }
        .info-box { background: #e3f2fd; padding: 15px; border-radius: 6px; margin-bottom: 20px; border-left: 4px solid #2196f3; }
        .no-courses { text-align: center; padding: 40px; background: #f8f9fa; border-radius: 8px; }
    </style>
</head>
<body>
    <header>
        <h1>⫘ Give Feedback</h1>
        <nav>
            <a href="my-feedback" style="color: white; margin: 0 15px;">Back to My Feedback</a>
            <a href="user-dashboard.jsp" style="color: white; margin: 0 15px;">Dashboard</a>
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
        %>

        <div class="info-box">
            <strong>💡 Tips for good feedback:</strong>
            <ul style="margin: 10px 0; padding-left: 20px;">
                <li>Be specific about what you liked or didn't like</li>
                <li>Suggest improvements for the course</li>
                <li>Mention the coach's teaching style</li>
                <li>Keep it constructive and respectful</li>
            </ul>
        </div>

        <%
            // Get user's enrolled courses
            com.chesscourse.model.User user = (com.chesscourse.model.User) session.getAttribute("user");
            java.util.List<com.chesscourse.model.Enrollment> enrollments = null;
            
            if (user != null) {
                com.chesscourse.dao.EnrollmentDAO enrollmentDAO = new com.chesscourse.dao.EnrollmentDAO();
                enrollments = enrollmentDAO.getEnrollmentsByUserId(user.getId());
            }
        %>

        <% if (enrollments == null || enrollments.isEmpty()) { %>
            <div class="no-courses">
                <h3>No enrolled courses</h3>
                <p>You need to be enrolled in at least one course to give feedback.</p>
                <a href="courses" class="btn" style="background: #ADD8E6; color: white; text-decoration: none; padding: 10px 20px; border-radius: 4px; display: inline-block; margin-top: 15px;">
                    Browse Courses
                </a>
            </div>
        <% } else { %>
            <form action="my-feedback" method="post">
                <input type="hidden" name="action" value="create">
                
                <div class="form-group">
                    <label for="courseId">Select Course:</label>
                    <select id="courseId" name="courseId" required>
                        <option value="">Choose a course...</option>
                        <%
                            for (var enrollment : enrollments) {
                        %>
                            <option value="<%= enrollment.getCourseId() %>">
                                <%= enrollment.getCourseTitle() %> (Coach: <%= enrollment.getCoachName() %>)
                            </option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="message">Your Feedback:</label>
                    <textarea id="message" name="message" required 
                              placeholder="Share your thoughts about the course, coach, content, or suggestions for improvement..."
                              maxlength="1000"></textarea>
                    <div class="char-count" id="message-count">0/1000 characters</div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn submit-btn">Submit Feedback</button>
                    <a href="my-feedback" class="btn cancel-btn">Cancel</a>
                </div>
            </form>
        <% } %>
    </div>

    <script>
        document.getElementById('message').addEventListener('input', function() {
            const count = this.value.length;
            document.getElementById('message-count').textContent = count + '/1000 characters';
        });

        document.getElementById('message').addEventListener('input', function() {
            this.style.height = 'auto';
            this.style.height = (this.scrollHeight) + 'px';
        });

        document.querySelector('form')?.addEventListener('submit', function(e) {
            const courseId = document.getElementById('courseId').value;
            const message = document.getElementById('message').value.trim();
            
            if (!courseId) {
                alert('Please select a course');
                e.preventDefault();
                return;
            }
            
            if (message.length < 10) {
                alert('Feedback must be at least 10 characters long');
                e.preventDefault();
                return;
            }
            
            if (message.length > 1000) {
                alert('Feedback must be less than 1000 characters');
                e.preventDefault();
                return;
            }
        });
    </script>
</body>
</html>