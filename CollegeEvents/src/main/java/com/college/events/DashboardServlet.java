package com.college.events;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Feature 3 – Dashboard
 * Fetches summary statistics and forwards to dashboard.jsp.
 * Public page – no login required to view.
 */
public class DashboardServlet extends HttpServlet {

    private final EventDAO dao = new EventDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int total    = dao.getTotalCount();
        int upcoming = dao.getUpcomingCount();

        req.setAttribute("totalEvents",   total);
        req.setAttribute("upcomingCount", upcoming);
        req.setAttribute("pastCount",     total - upcoming);
        req.setAttribute("categoryMap",   dao.getCountByCategory());

        req.getRequestDispatcher("dashboard.jsp").forward(req, res);
    }
}
