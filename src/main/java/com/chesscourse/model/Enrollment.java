package com.chesscourse.model;

import java.time.LocalDateTime;

public class Enrollment {
    private int id;
    private int userId;
    private int courseId;
    private LocalDateTime enrolledAt;
    
    // Additional fields for display
    private String courseTitle;
    private String coachName;
    
    // Constructors
    public Enrollment() {}
    
    public Enrollment(int userId, int courseId) {
        this.userId = userId;
        this.courseId = courseId;
    }
    
    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public int getCourseId() { return courseId; }
    public void setCourseId(int courseId) { this.courseId = courseId; }
    
    public LocalDateTime getEnrolledAt() { return enrolledAt; }
    public void setEnrolledAt(LocalDateTime enrolledAt) { this.enrolledAt = enrolledAt; }
    
    // Additional getters & setters
    public String getCourseTitle() { return courseTitle; }
    public void setCourseTitle(String courseTitle) { this.courseTitle = courseTitle; }
    
    public String getCoachName() { return coachName; }
    public void setCoachName(String coachName) { this.coachName = coachName; }
}