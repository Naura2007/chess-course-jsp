<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chess Course - Home</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background: #f0f8ff; }
        header { background: #ADD8E6; padding: 20px; text-align: center; color: white; }
        nav { margin: 15px 0; }
        nav a { margin: 0 15px; text-decoration: none; color: #2c3e50; font-weight: bold; }
        nav a:hover { color: #1a5276; }
        .hero { text-align: center; margin: 50px 0; padding: 40px; }
        .hero h2 { color: #2c3e50; }
    </style>
</head>
<body>
    <header>
        <h1>♟️ Chess Course</h1>
        <nav>
            <a href="login.jsp">Login</a>
            <a href="register.jsp">Register</a>
            <a href="courses">View Courses</a>
        </nav>
    </header>
    
    <main>
        <section class="hero">
            <h2>Welcome to Chess Course</h2>
            <p>Learn chess from professional coaches. Improve your skills with our comprehensive courses.</p>
        </section>
    </main>
</body>
</html>