package com.college.events;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventDAO {

    // CREATE
    public boolean addEvent(Event event) {
        String sql = "INSERT INTO events (title, description, date, venue, category) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, event.getTitle());
            ps.setString(2, event.getDescription());
            ps.setString(3, event.getDate());
            ps.setString(4, event.getVenue());
            ps.setString(5, event.getCategory());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // READ ALL
    public List<Event> getAllEvents() {
        List<Event> list = new ArrayList<>();
        String sql = "SELECT * FROM events ORDER BY date DESC";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // READ ONE
    public Event getEventById(int id) {
        String sql = "SELECT * FROM events WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // UPDATE
    public boolean updateEvent(Event event) {
        String sql = "UPDATE events SET title=?, description=?, date=?, venue=?, category=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, event.getTitle());
            ps.setString(2, event.getDescription());
            ps.setString(3, event.getDate());
            ps.setString(4, event.getVenue());
            ps.setString(5, event.getCategory());
            ps.setInt(6, event.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // DELETE
    public boolean deleteEvent(int id) {
        String sql = "DELETE FROM events WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Event mapRow(ResultSet rs) throws SQLException {
        return new Event(
            rs.getInt("id"),
            rs.getString("title"),
            rs.getString("description"),
            rs.getString("date"),
            rs.getString("venue"),
            rs.getString("category")
        );
    }
}
