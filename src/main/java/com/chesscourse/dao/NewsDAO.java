package com.chesscourse.dao;

import com.chesscourse.model.News;
import com.chesscourse.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NewsDAO {
    
    public List<News> findAll() {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT * FROM news ORDER BY published_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                News news = new News();
                news.setId(rs.getInt("id"));
                news.setTitle(rs.getString("title"));
                news.setContent(rs.getString("content"));
                news.setPublishedAt(rs.getTimestamp("published_at").toLocalDateTime());
                newsList.add(news);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return newsList;
    }
    
    public boolean create(News news) {
        String sql = "INSERT INTO news (title, content) VALUES (?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, news.getTitle());
            stmt.setString(2, news.getContent());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean delete(int id) {
        String sql = "DELETE FROM news WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
