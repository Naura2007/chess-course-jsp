<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create News - Admin</title>
    <style>
        body { font-family: Arial; margin: 0; padding: 20px; background: #f0f8ff; }
        header { background: #ADD8E6; padding: 20px; text-align: center; color: white; margin-bottom: 30px; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: bold; color: #333; }
        input, textarea { width: 100%; padding: 12px; border: 2px solid #ddd; border-radius: 6px; font-size: 14px; }
        textarea { height: 200px; resize: vertical; }
        .btn { padding: 12px 25px; border: none; border-radius: 6px; cursor: pointer; font-size: 16px; text-decoration: none; display: inline-block; }
        .submit-btn { background: #28a745; color: white; }
        .submit-btn:hover { background: #218838; }
        .cancel-btn { background: #6c757d; color: white; margin-left: 10px; }
        .cancel-btn:hover { background: #545b62; }
        .form-actions { text-align: center; margin-top: 30px; }
        .error { background: #ffebee; color: #c62828; padding: 15px; border-radius: 6px; margin-bottom: 20px; border-left: 4px solid #c62828; }
        .char-count { text-align: right; font-size: 12px; color: #666; margin-top: 5px; }
    </style>
</head>
<body>
    <header>
        <h1>⫘ Create News Post</h1>
        <nav>
            <a href="admin-news" style="color: white; margin: 0 15px;">Back to News</a>
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
        %>

        <form action="news" method="post">
            <input type="hidden" name="action" value="create">
            
            <div class="form-group">
                <label for="title">News Title:</label>
                <input type="text" id="title" name="title" required 
                       placeholder="e.g., New Chess Tournament Announcement"
                       maxlength="200">
                <div class="char-count" id="title-count">0/200 characters</div>
            </div>

            <div class="form-group">
                <label for="content">News Content:</label>
                <textarea id="content" name="content" required 
                          placeholder="Write the full news content here..."
                          maxlength="2000"></textarea>
                <div class="char-count" id="content-count">0/2000 characters</div>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn submit-btn">Publish News</button>
                <a href="admin-news" class="btn cancel-btn">Cancel</a>
            </div>
        </form>
    </div>

    <script>
        document.getElementById('title').addEventListener('input', function() {
            const count = this.value.length;
            document.getElementById('title-count').textContent = count + '/200 characters';
        });

        document.getElementById('content').addEventListener('input', function() {
            const count = this.value.length;
            document.getElementById('content-count').textContent = count + '/2000 characters';
        });

        document.getElementById('content').addEventListener('input', function() {
            this.style.height = 'auto';
            this.style.height = (this.scrollHeight) + 'px';
        });

        document.querySelector('form').addEventListener('submit', function(e) {
            const title = document.getElementById('title').value.trim();
            const content = document.getElementById('content').value.trim();
            
            if (title.length < 5) {
                alert('Title must be at least 5 characters long');
                e.preventDefault();
                return;
            }
            
            if (content.length < 10) {
                alert('Content must be at least 10 characters long');
                e.preventDefault();
                return;
            }
        });
    </script>
</body>
</html>