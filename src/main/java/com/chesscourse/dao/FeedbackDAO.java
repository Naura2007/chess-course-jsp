package com.chesscourse.dao;

import com.chesscourse.model.Feedback;
import com.chesscourse.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDAO {
    
    // Create new feedback
    public boolean create(Feedback feedback) {
        String sql = "INSERT INTO feedbacks (user_id, course_id, message) VALUES (?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, feedback.getUserId());
            stmt.setInt(2, feedback.getCourseId());
            stmt.setString(3, feedback.getMessage());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Delete feedback
    public boolean delete(int feedbackId) {
        String sql = "DELETE FROM feedbacks WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, feedbackId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Get feedback by user ID
    public List<Feedback> getFeedbackByUserId(int userId) {
        List<Feedback> feedbackList = new ArrayList<>();
        String sql = "SELECT f.*, c.title as course_title, u.name as user_name " +
                     "FROM feedbacks f " +
                     "JOIN courses c ON f.course_id = c.id " +
                     "JOIN users u ON f.user_id = u.id " +
                     "WHERE f.user_id = ? " +
                     "ORDER BY f.created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Feedback feedback = extractFeedbackFromResultSet(rs);
                feedbackList.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbackList;
    }
    
    // Get all feedback (for admin)
    public List<Feedback> getAllFeedback() {
        List<Feedback> feedbackList = new ArrayList<>();
        String sql = "SELECT f.*, c.title as course_title, u.name as user_name " +
                     "FROM feedbacks f " +
                     "JOIN courses c ON f.course_id = c.id " +
                     "JOIN users u ON f.user_id = u.id " +
                     "ORDER BY f.created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Feedback feedback = extractFeedbackFromResultSet(rs);
                feedbackList.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbackList;
    }
    
    // Helper method to extract Feedback from ResultSet
    private Feedback extractFeedbackFromResultSet(ResultSet rs) throws SQLException {
        Feedback feedback = new Feedback();
        feedback.setId(rs.getInt("id"));
        feedback.setUserId(rs.getInt("user_id"));
        feedback.setCourseId(rs.getInt("course_id"));
        feedback.setMessage(rs.getString("message"));
        feedback.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        
        // Set additional info for display
        feedback.setCourseTitle(rs.getString("course_title"));
        feedback.setUserName(rs.getString("user_name"));
        
        return feedback;
    }
}
