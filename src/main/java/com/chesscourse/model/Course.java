package com.chesscourse.model;

import java.time.LocalDateTime;

public class Course {
    private int id;
    private String title;
    private String description;
    private String level;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private int quota;
    private String coachName;
    private LocalDateTime createdAt;
    
    public Course() {}
    
    public Course(String title, String description, String level, 
                  LocalDateTime startTime, LocalDateTime endTime, 
                  int quota, String coachName) {
        this.title = title;
        this.description = description;
        this.level = level;
        this.startTime = startTime;
        this.endTime = endTime;
        this.quota = quota;
        this.coachName = coachName;
    }
    
    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getLevel() { return level; }
    public void setLevel(String level) { this.level = level; }
    
    public LocalDateTime getStartTime() { return startTime; }
    public void setStartTime(LocalDateTime startTime) { this.startTime = startTime; }
    
    public LocalDateTime getEndTime() { return endTime; }
    public void setEndTime(LocalDateTime endTime) { this.endTime = endTime; }
    
    public int getQuota() { return quota; }
    public void setQuota(int quota) { this.quota = quota; }
    
    public String getCoachName() { return coachName; }
    public void setCoachName(String coachName) { this.coachName = coachName; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    @Override
    public String toString() {
        return "Course{id=" + id + ", title='" + title + "', level='" + level + "', coach='" + coachName + "'}";
    }
}