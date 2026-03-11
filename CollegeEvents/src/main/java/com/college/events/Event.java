package com.college.events;

public class Event {
    private int id;
    private String title;
    private String description;
    private String date;
    private String venue;
    private String category;

    public Event() {}

    public Event(int id, String title, String description, String date, String venue, String category) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.date = date;
        this.venue = venue;
        this.category = category;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }

    public String getVenue() { return venue; }
    public void setVenue(String venue) { this.venue = venue; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
}
