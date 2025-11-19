package com.chesscourse.dao;

import com.chesscourse.model.Enrollment;
import com.chesscourse.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EnrollmentDAO {
    
    // Enroll user to course
    public boolean enroll(Enrollment enrollment) {
        String sql = "INSERT INTO enrollments (user_id, course_id) VALUES (?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, enrollment.getUserId());
            stmt.setInt(2, enrollment.getCourseId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Cancel enrollment
    public boolean cancelEnrollment(int userId, int courseId) {
        String sql = "DELETE FROM enrollments WHERE user_id = ? AND course_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, courseId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Check if user is already enrolled in a course
    public boolean isUserEnrolled(int userId, int courseId) {
        String sql = "SELECT COUNT(*) FROM enrollments WHERE user_id = ? AND course_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, courseId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Get all enrollments for a user
    public List<Enrollment> getEnrollmentsByUserId(int userId) {
        List<Enrollment> enrollments = new ArrayList<>();
        String sql = "SELECT e.*, c.title as course_title, c.coach_name " +
                     "FROM enrollments e " +
                     "JOIN courses c ON e.course_id = c.id " +
                     "WHERE e.user_id = ? " +
                     "ORDER BY e.enrolled_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Enrollment enrollment = new Enrollment();
                enrollment.setId(rs.getInt("id"));
                enrollment.setUserId(rs.getInt("user_id"));
                enrollment.setCourseId(rs.getInt("course_id"));
                enrollment.setEnrolledAt(rs.getTimestamp("enrolled_at").toLocalDateTime());
                
                // Set additional course info for display
                enrollment.setCourseTitle(rs.getString("course_title"));
                enrollment.setCoachName(rs.getString("coach_name"));
                
                enrollments.add(enrollment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return enrollments;
    }
    
    // Get enrollment count for a course
    public int getEnrollmentCount(int courseId) {
        String sql = "SELECT COUNT(*) FROM enrollments WHERE course_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, courseId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}