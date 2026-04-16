package com.college.events;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Feature 1 – Authentication System
 * Handles: GET  /login  → show login page (or process logout)
 *          POST /login  → validate credentials and create session
 */
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // --- Logout action ---
        if ("logout".equals(req.getParameter("action"))) {
            HttpSession session = req.getSession(false);
            if (session != null) session.invalidate();
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // --- Already logged in → redirect to events list ---
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("loggedInUser") != null) {
            res.sendRedirect(req.getContextPath() + "/events");
            return;
        }

        req.getRequestDispatcher("login.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        String name = userDAO.validateUser(username, password);

        if (name != null) {
            // Valid credentials → create session
            HttpSession session = req.getSession(true);
            session.setAttribute("loggedInUser", username);
            session.setAttribute("loggedInName", name);
            session.setMaxInactiveInterval(30 * 60); // 30 minutes
            res.sendRedirect(req.getContextPath() + "/events");
        } else {
            // Invalid credentials → back to login with error
            req.setAttribute("error", "Invalid username or password. Please try again.");
            req.getRequestDispatcher("login.jsp").forward(req, res);
        }
    }
}
