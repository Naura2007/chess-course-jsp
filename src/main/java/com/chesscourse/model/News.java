package com.chesscourse.model;

import java.time.LocalDateTime;

public class News {
    private int id;
    private String title;
    private String content;
    private LocalDateTime publishedAt;
    
    public News() {}
    
    public News(String title, String content) {
        this.title = title;
        this.content = content;
    }
    
    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    
    public LocalDateTime getPublishedAt() { return publishedAt; }
    public void setPublishedAt(LocalDateTime publishedAt) { this.publishedAt = publishedAt; }
    
    @Override
    public String toString() {
        return "News{id=" + id + ", title='" + title + "'}";
    }
}