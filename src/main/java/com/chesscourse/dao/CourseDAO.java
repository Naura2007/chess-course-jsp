package com.chesscourse.dao;

import com.chesscourse.model.Course;
import com.chesscourse.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CourseDAO {
    
    // Get all courses
    public List<Course> findAll() {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT * FROM courses ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                courses.add(extractCourseFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }
    
    // Find course by ID
    public Course findById(int id) {
        String sql = "SELECT * FROM courses WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                System.out.println(" Found course with ID: " + id);
                return extractCourseFromResultSet(rs);
            } else {
                System.out.println(" No course found with ID: " + id);
            }
        } catch (SQLException e) {
            System.out.println(" Error finding course by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    // Create new course
    public boolean create(Course course) {
        String sql = "INSERT INTO courses (title, description, level, start_time, end_time, quota, coach_name) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, course.getTitle());
            stmt.setString(2, course.getDescription());
            stmt.setString(3, course.getLevel());
            stmt.setTimestamp(4, Timestamp.valueOf(course.getStartTime()));
            stmt.setTimestamp(5, Timestamp.valueOf(course.getEndTime()));
            stmt.setInt(6, course.getQuota());
            stmt.setString(7, course.getCoachName());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Update existing course
    public boolean update(Course course) {
        String sql = "UPDATE courses SET title = ?, description = ?, level = ?, " +
                     "start_time = ?, end_time = ?, quota = ?, coach_name = ? " +
                     "WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, course.getTitle());
            stmt.setString(2, course.getDescription());
            stmt.setString(3, course.getLevel());
            stmt.setTimestamp(4, Timestamp.valueOf(course.getStartTime()));
            stmt.setTimestamp(5, Timestamp.valueOf(course.getEndTime()));
            stmt.setInt(6, course.getQuota());
            stmt.setString(7, course.getCoachName());
            stmt.setInt(8, course.getId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Delete course by ID
    public boolean delete(int courseId) {
        String sql = "DELETE FROM courses WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, courseId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Helper method to extract Course from ResultSet
    private Course extractCourseFromResultSet(ResultSet rs) throws SQLException {
        Course course = new Course();
        course.setId(rs.getInt("id"));
        course.setTitle(rs.getString("title"));
        course.setDescription(rs.getString("description"));
        course.setLevel(rs.getString("level"));
        course.setStartTime(rs.getTimestamp("start_time").toLocalDateTime());
        course.setEndTime(rs.getTimestamp("end_time").toLocalDateTime());
        course.setQuota(rs.getInt("quota"));
        course.setCoachName(rs.getString("coach_name"));
        course.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        return course;
    }
}