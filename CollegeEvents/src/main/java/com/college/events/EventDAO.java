package com.college.events;

import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class EventDAO {

    // =========================================================
    //  CREATE
    // =========================================================
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

    // =========================================================
    //  READ ALL  (kept for backward compatibility)
    // =========================================================
    public List<Event> getAllEvents() {
        List<Event> list = new ArrayList<>();
        String sql = "SELECT * FROM events ORDER BY date DESC";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // =========================================================
    //  READ ONE
    // =========================================================
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

    // =========================================================
    //  UPDATE
    // =========================================================
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

    // =========================================================
    //  DELETE
    // =========================================================
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

    // =========================================================
    //  FEATURE 2 – SEARCH + FILTER
    //  Searches by title keyword AND/OR filters by category.
    //  If both params are null/empty it returns ALL events
    //  (equivalent to getAllEvents), so EventServlet can always
    //  call this single method.
    // =========================================================
    public List<Event> searchEvents(String keyword, String category) {
        List<Event> list = new ArrayList<>();

        boolean hasKeyword  = keyword  != null && !keyword.trim().isEmpty();
        boolean hasCategory = category != null && !category.trim().isEmpty();

        StringBuilder sql = new StringBuilder("SELECT * FROM events WHERE 1=1");
        if (hasKeyword)  sql.append(" AND title LIKE ?");
        if (hasCategory) sql.append(" AND category = ?");
        sql.append(" ORDER BY date DESC");

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {
            int idx = 1;
            if (hasKeyword)  ps.setString(idx++, "%" + keyword.trim() + "%");
            if (hasCategory) ps.setString(idx++, category.trim());
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // =========================================================
    //  FEATURE 3 – DASHBOARD STATS
    // =========================================================

    /** Returns the total number of events in the table. */
    public int getTotalCount() {
        String sql = "SELECT COUNT(*) FROM events";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /** Returns the number of events whose date >= today. */
    public int getUpcomingCount() {
        String sql = "SELECT COUNT(*) FROM events WHERE date >= CURDATE()";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /** Returns a map of category → event count, ordered alphabetically. */
    public Map<String, Integer> getCountByCategory() {
        Map<String, Integer> map = new LinkedHashMap<>();
        String sql = "SELECT category, COUNT(*) AS cnt FROM events GROUP BY category ORDER BY category";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                map.put(rs.getString("category"), rs.getInt("cnt"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return map;
    }

    // =========================================================
    //  HELPER
    // =========================================================
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
