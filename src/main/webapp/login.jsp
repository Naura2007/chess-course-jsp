<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Chess Course</title>
    <style>
        body { font-family: Arial; background: #f0f8ff; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .login-container { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); width: 300px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; color: #333; }
        input[type="email"], input[type="password"] { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
        button { background: #ADD8E6; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; width: 100%; }
        button:hover { background: #9bc4d4; }
        .error { background: #ffebee; color: #c62828; padding: 10px; border-radius: 4px; margin-bottom: 15px; }
    </style>
</head>
<body>
    <div class="hero-logo">
        <img src="images/logo.png" alt="Chess Course Logo">
    </div>

    <div class="login-container">
        <h2>Login</h2>
        
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        
        <form action="login" method="post">
            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="email" required>
            </div>
            
            <div class="form-group">
                <label>Password:</label>
                <input type="password" name="password" required>
            </div>
            
            <button type="submit">Login</button>
        </form>
        
        <p style="text-align: center; margin-top: 15px;">
            Don't have an account? <a href="register.jsp">Register here</a>
        </p>
    </div>
</body>
</html>