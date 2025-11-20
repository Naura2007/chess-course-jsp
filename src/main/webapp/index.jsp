<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ChessCourse - Home</title>
    <link rel="stylesheet" href="css/style.css"> 
</head>
<body>
    <nav class="navbar">
        <div class="nav-container">
            <div class="nav-logo">
                ChessCourse
            </div>
            <ul class="nav-links">
                <li><a href="index.jsp">Home</a></li>
                <li><a href="news.jsp">News</a></li>
                <li><a href="login.jsp">Login</a></li>
            </ul>
        </div>
    </nav>

    <div class="hero-section">
        <video class="hero-video" autoplay muted loop>
            <source src="videos/background.mp4" type="video/mp4">
            Your browser does not support the video tag.
        </video>
        
        <div class="hero-overlay"></div>

        <div class="hero-content">
            <div class="hero-logo">
                <img src="images/logo.png" alt="Chess Course Logo">
            </div>

            <h1 class="hero-title">Born as a Pawn, Rise as a Queen</h1>
            
            <p class="hero-subtitle">
                Still learning chess the old-fashioned way? Here you can learn chess integrated with the world of technology.
            </p>

            <div class="hero-buttons">
                <a href="login.jsp" class="btn btn-primary">Get Started</a>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 ChessCourse Academy</p>
    </footer>
</body>
</html>