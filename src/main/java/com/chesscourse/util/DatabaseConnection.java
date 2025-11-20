package com.chesscourse.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    // KONFIGURASI UNTUK XAMPP
    private static final String URL = "jdbc:mysql://localhost:3307/chess_course";
    private static final String USER = "root";      
    private static final String PASSWORD = "";      
    
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("MySQL Driver loaded successfully!");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL Driver not found", e);
        }
    }
    
    // Test connection
    public static void main(String[] args) {
        System.out.println("Testing XAMPP MySQL connection...");
        System.out.println("URL: " + URL);
        System.out.println("User: " + USER);
        
        try (Connection conn = getConnection()) {
            System.out.println("Database connected successfully!");
            
            // Test query
            var stmt = conn.createStatement();
            
            // Test query users
            var rs = stmt.executeQuery("SELECT COUNT(*) as user_count FROM users");
            if (rs.next()) {
                System.out.println("Total users: " + rs.getInt("user_count"));
            }

            // Test query courses  
            rs = stmt.executeQuery("SELECT COUNT(*) as course_count FROM courses");
            if (rs.next()) {
                System.out.println("Total courses: " + rs.getInt("course_count"));
            }
            
        } catch (SQLException e) {
            System.out.println("Database connection failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
        