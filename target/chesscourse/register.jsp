<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Chess Course</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: Arial, sans-serif;
            background: #f0f8ff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        
        .register-container {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            width: 350px;
        }
        
        h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 20px;
            font-size: 24px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: bold;
        }
        
        input[type="text"], 
        input[type="email"], 
        input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        
        input[type="text"]:focus, 
        input[type="email"]:focus, 
        input[type="password"]:focus {
            border-color: #ADD8E6;
            outline: none;
        }
        
        button {
            background: #ADD8E6;
            color: white;
            padding: 12px 15px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            font-weight: bold;
            transition: background 0.3s;
        }
        
        button:hover {
            background: #9bc4d4;
        }
        
        .error {
            background: #ffebee;
            color: #c62828;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
            border-left: 4px solid #c62828;
        }
        
        .success {
            background: #e8f5e8;
            color: #2e7d32;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
            border-left: 4px solid #2e7d32;
        }
        
        .login-link {
            text-align: center;
            margin-top: 20px;
            color: #666;
        }
        
        .login-link a {
            color: #ADD8E6;
            text-decoration: none;
            font-weight: bold;
        }
        
        .login-link a:hover {
            text-decoration: underline;
        }
        
        .password-requirements {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="hero-logo">
        <img src="images/logo.png" alt="Chess Course Logo">
    </div>

    <div class="register-container">
        <h2>Create Account</h2>
        
        <%-- Display error message --%>
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        
        <%-- Display success message --%>
        <c:if test="${not empty success}">
            <div class="success">${success}</div>
        </c:if>
        
        <form action="register" method="post">
            <div class="form-group">
                <label for="name">Full Name:</label>
                <input type="text" id="name" name="name" required 
                       placeholder="Enter your full name">
            </div>
            
            <div class="form-group">
                <label for="email">Email Address:</label>
                <input type="email" id="email" name="email" required 
                       placeholder="Enter your email">
            </div>
            
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required 
                       placeholder="Create a password" minlength="6">
                <div class="password-requirements">
                    Must be at least 6 characters long
                </div>
            </div>
            
            <div class="form-group">
                <label for="confirmPassword">Confirm Password:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required 
                       placeholder="Confirm your password">
            </div>
            
            <button type="submit" onclick="return validatePassword()">Create Account</button>
        </form>
        
        <div class="login-link">
            Already have an account? <a href="login.jsp">Sign in here</a>
        </div>
    </div>

    <script>
        function validatePassword() {
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            
            if (password !== confirmPassword) {
                alert("Passwords do not match!");
                return false;
            }
            
            if (password.length < 6) {
                alert("Password must be at least 6 characters long!");
                return false;
            }
            
            return true;
        }
        
        // Real-time password confirmation check
        document.getElementById('confirmPassword').addEventListener('input', function() {
            var password = document.getElementById('password').value;
            var confirmPassword = this.value;
            
            if (confirmPassword && password !== confirmPassword) {
                this.style.borderColor = '#c62828';
            } else {
                this.style.borderColor = '#4caf50';
            }
        });
    </script>
</body>
</html>