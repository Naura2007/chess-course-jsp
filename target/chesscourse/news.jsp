<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>News - Chess Course</title>
    <style>
        body { font-family: Arial; margin: 0; padding: 20px; background: #f0f8ff; }
        header { background: #ADD8E6; padding: 20px; text-align: center; color: white; margin-bottom: 30px; }
        .container { max-width: 1000px; margin: 0 auto; }
        .news-grid { display: grid; gap: 20px; }
        .news-card { background: white; padding: 25px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); border-left: 4px solid #ADD8E6; }
        .news-title { color: #2c3e50; margin-top: 0; font-size: 1.4em; }
        .news-date { color: #666; font-size: 0.9em; margin-bottom: 15px; }
        .news-content { line-height: 1.6; color: #333; }
        .no-news { text-align: center; padding: 40px; background: white; border-radius: 8px; }
        .nav-links { text-align: center; margin: 20px 0; }
        .nav-links a { color: #ADD8E6; text-decoration: none; margin: 0 15px; font-weight: bold; }
        .nav-links a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <header>
        <h1>⫘ Chess Course News</h1>
        <div class="nav-links">
            <a href="index.jsp">Home</a>
            <a href="courses">View Courses</a>
            <a href="user-dashboard.jsp">Dashboard</a>
        </div>
    </header>

    <div class="container">
        <c:if test="${empty newsList}">
            <div class="no-news">
                <h3>No news available</h3>
                <p>Check back later for the latest updates about our chess courses!</p>
            </div>
        </c:if>

        <div class="news-grid">
            <c:forEach var="news" items="${newsList}">
                <div class="news-card">
                    <h2 class="news-title">${news.title}</h2>
                    <div class="news-date">
                        Published on: ${news.publishedAt.toLocalDate()} at ${news.publishedAt.toLocalTime()}
                    </div>
                    <div class="news-content">
                        ${news.content}
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>