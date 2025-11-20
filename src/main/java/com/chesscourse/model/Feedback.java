package com.chesscourse.model;

import java.time.LocalDateTime;

public class Feedback {
    private int id;
    private int userId;
    private int courseId;
    private String message;
    private LocalDateTime createdAt;
    private String courseTitle;
    private String userName;
    
    public Feedback() {}
    
    public Feedback(int userId, int courseId, String message) {
        this.userId = userId;
        this.courseId = courseId;
        this.message = message;
    }
    
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public int getCourseId() { return courseId; }
    public void setCourseId(int courseId) { this.courseId = courseId; }
    
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    public String getCourseTitle() { return courseTitle; }
    public void setCourseTitle(String courseTitle) { this.courseTitle = courseTitle; }
    
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
}