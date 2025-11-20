<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage News - Admin</title>
    <style>
        body { font-family: Arial; margin: 0; padding: 20px; background: #f0f8ff; }
        header { background: #ADD8E6; padding: 20px; text-align: center; color: white; margin-bottom: 30px; }
        .container { max-width: 1000px; margin: 0 auto; }
        .admin-actions { margin-bottom: 20px; }
        .create-btn { background: #28a745; color: white; padding: 12px 20px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; display: inline-block; }
        .create-btn:hover { background: #218838; }
        .news-table { width: 100%; background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #f8f9fa; font-weight: bold; }
        .delete-btn { background: #dc3545; color: white; padding: 6px 12px; border: none; border-radius: 4px; cursor: pointer; font-size: 12px; }
        .success { background: #e8f5e8; color: #2e7d32; padding: 15px; border-radius: 6px; margin-bottom: 20px; }
        .error { background: #ffebee; color: #c62828; padding: 15px; border-radius: 6px; margin-bottom: 20px; }
        .no-news { text-align: center; padding: 40px; background: white; border-radius: 8px; }
    </style>
</head>
<body>
    <header>
        <h1>⫘ Manage News - Admin Panel</h1>
        <nav>
            <a href="admin-dashboard.jsp" style="color: white; margin: 0 15px;">Dashboard</a>
            <a href="news" style="color: white; margin: 0 15px;">View Public News</a>
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
            <a href="create-news.jsp" class="create-btn">+ Create New News</a>
        </div>

        <c:choose>
            <c:when test="${empty newsList}">
                <div class="no-news">
                    <h3>No news available</h3>
                    <p>Create your first news post to share updates with users!</p>
                    <a href="create-news.jsp" class="create-btn">Create First News</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="news-table">
                    <table>
                        <thead>
                            <tr>
                                <th>Title</th>
                                <th>Content</th>
                                <th>Published Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="news" items="${newsList}">
                                <tr>
                                    <td><strong>${news.title}</strong></td>
                                    <td>${news.content}</td>
                                    <td>
                                        ${news.publishedAt.toLocalDate()}
                                        <br>
                                        <small>${news.publishedAt.toLocalTime()}</small>
                                    </td>
                                    <td>
                                        <form action="news" method="post" style="display: inline;">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="${news.id}">
                                            <button type="submit" class="delete-btn" onclick="return confirm('Are you sure you want to delete this news?')">Delete</button>
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