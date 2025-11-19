<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Course - Admin</title>
    <style>
        body { font-family: Arial; margin: 0; padding: 20px; background: #f0f8ff; }
        header { background: #ADD8E6; padding: 20px; text-align: center; color: white; margin-bottom: 30px; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: bold; color: #333; }
        input, select, textarea { width: 100%; padding: 12px; border: 2px solid #ddd; border-radius: 6px; font-size: 14px; }
        textarea { height: 100px; resize: vertical; }
        .btn { padding: 12px 25px; border: none; border-radius: 6px; cursor: pointer; font-size: 16px; text-decoration: none; display: inline-block; }
        .submit-btn { background: #28a745; color: white; }
        .submit-btn:hover { background: #218838; }
        .cancel-btn { background: #6c757d; color: white; margin-left: 10px; }
        .cancel-btn:hover { background: #545b62; }
        .form-actions { text-align: center; margin-top: 30px; }
    </style>
</head>
<body>
    <header>
        <h1>♟️ Create New Course</h1>
        <nav>
            <a href="admin-courses.jsp" style="color: white; margin: 0 15px;">Back to Courses</a>
            <a href="admin-dashboard.jsp" style="color: white; margin: 0 15px;">Dashboard</a>
        </nav>
    </header>

    <div class="container">
        <form action="courses?action=create" method="post">
            <input type="hidden" name="action" value="create">
            <div class="form-group">
                <label for="title">Course Title:</label>
                <input type="text" id="title" name="title" required placeholder="e.g., Beginner Chess Fundamentals">
            </div>

            <div class="form-group">
                <label for="description">Description:</label>
                <textarea id="description" name="description" required placeholder="Describe the course content, objectives, and what students will learn"></textarea>
            </div>

            <div class="form-group">
                <label for="level">Difficulty Level:</label>
                <select id="level" name="level" required>
                    <option value="">Select Level</option>
                    <option value="Beginner">Beginner</option>
                    <option value="Intermediate">Intermediate</option>
                    <option value="Advanced">Advanced</option>
                </select>
            </div>

            <div class="form-group">
                <label for="coach_name">Coach Name:</label>
                <input type="text" id="coach_name" name="coach_name" required placeholder="e.g., Grandmaster John Smith">
            </div>

            <div class="form-group">
                <label for="quota">Student Quota:</label>
                <input type="number" id="quota" name="quota" required min="1" max="50" placeholder="Maximum number of students">
            </div>

            <div class="form-group">
                <label for="start_time">Start Date & Time:</label>
                <input type="datetime-local" id="start_time" name="start_time" required>
            </div>

            <div class="form-group">
                <label for="end_time">End Date & Time:</label>
                <input type="datetime-local" id="end_time" name="end_time" required>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn submit-btn">Create Course</button>
                <a href="admin-courses.jsp" class="btn cancel-btn">Cancel</a>
            </div>
        </form>
    </div>

    <script>
        // Set min datetime to current time
        const now = new Date();
        const timezoneOffset = now.getTimezoneOffset() * 60000;
        const localISOTime = new Date(now - timezoneOffset).toISOString().slice(0, 16);
        
        document.getElementById('start_time').min = localISOTime;
        document.getElementById('end_time').min = localISOTime;
    </script>
</body>
</html>