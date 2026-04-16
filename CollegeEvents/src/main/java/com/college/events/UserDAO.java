package com.college.events;

import java.sql.*;

/**
 * DAO for user authentication operations.
 */
public class UserDAO {

    /**
     * Validates username + password against the users table.
     *
     * @return the user's display name if credentials are valid, null otherwise.
     */
    public String validateUser(String username, String password) {
        String sql = "SELECT name FROM users WHERE username = ? AND password = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getString("name");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
