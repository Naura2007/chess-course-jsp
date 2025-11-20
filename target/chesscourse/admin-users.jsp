<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Users - Admin</title>
    <style>
        body { font-family: Arial; margin: 0; padding: 20px; background: #f0f8ff; }
        header { background: #ADD8E6; padding: 20px; text-align: center; color: white; margin-bottom: 30px; }
        .container { max-width: 1200px; margin: 0 auto; }
        .users-table { width: 100%; background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #f8f9fa; font-weight: bold; }
        .delete-btn { background: #dc3545; color: white; padding: 6px 12px; border: none; border-radius: 4px; cursor: pointer; font-size: 12px; }
        .success { background: #e8f5e8; color: #2e7d32; padding: 15px; border-radius: 6px; margin-bottom: 20px; }
        .error { background: #ffebee; color: #c62828; padding: 15px; border-radius: 6px; margin-bottom: 20px; }
        .no-users { text-align: center; padding: 40px; background: white; border-radius: 8px; }
        .role-badge { padding: 4px 8px; border-radius: 12px; font-size: 11px; font-weight: bold; }
        .role-admin { background: #ffebee; color: #c62828; }
        .role-user { background: #e8f5e8; color: #2e7d32; }
        .current-user { background: #fff8e1; }
    </style>
</head>
<body>
    <header>
        <h1>⫘ Manage Users - Admin Panel</h1>
        <nav>
            <a href="admin-dashboard.jsp" style="color: white; margin: 0 15px;">Dashboard</a>
            <a href="admin-courses" style="color: white; margin: 0 15px;">Manage Courses</a>
            <a href="admin-feedback" style="color: white; margin: 0 15px;">Manage Feedback</a>
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

        <c:choose>
            <c:when test="${empty users}">
                <div class="no-users">
                    <h3>No users found</h3>
                    <p>There are no registered users in the system.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="users-table">
                    <table>
                        <thead>
                            <tr>
                                <th>User ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Registered</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr class="${user.id == sessionScope.user.id ? 'current-user' : ''}">
                                    <td>${user.id}</td>
                                    <td>
                                        <strong>${user.name}</strong>
                                        <c:if test="${user.id == sessionScope.user.id}">
                                            <br><small>(You)</small>
                                        </c:if>
                                    </td>
                                    <td>${user.email}</td>
                                    <td>
                                        <span class="role-badge role-${user.role}">
                                            ${user.role}
                                        </span>
                                    </td>
                                    <td>
                                        ${user.createdAt.toLocalDate()}
                                        <br>
                                        <small>${user.createdAt.toLocalTime()}</small>
                                    </td>
                                    <td>
                                        <c:if test="${user.id != sessionScope.user.id}">
                                            <form action="admin-users" method="post" style="display: inline;">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id" value="${user.id}">
                                                <button type="submit" class="delete-btn" 
                                                        onclick="return confirm('Are you sure you want to delete user: ${user.name}? This action cannot be undone.')">
                                                    Delete
                                                </button>
                                            </form>
                                        </c:if>
                                        <c:if test="${user.id == sessionScope.user.id}">
                                            <small style="color: #666;">Current user</small>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <div style="margin-top: 20px; text-align: center; color: #666;">
                    <strong>Total Users:</strong> ${users.size()} 
                    | <strong>Admins:</strong> 
                    <c:set var="adminCount" value="0"/>
                    <c:forEach var="user" items="${users}">
                        <c:if test="${user.role == 'admin'}">
                            <c:set var="adminCount" value="${adminCount + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${adminCount}
                    | <strong>Regular Users:</strong> ${users.size() - adminCount}
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>