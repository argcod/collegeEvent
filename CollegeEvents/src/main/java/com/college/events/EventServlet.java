package com.college.events;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Central controller for all event operations.
 *
 * Feature 1 – Authentication:  add/edit/delete actions are protected;
 *             unauthenticated requests are redirected to /login.
 * Feature 2 – Search/Filter:   list action reads keyword + category
 *             params and delegates to EventDAO.searchEvents().
 */
public class EventServlet extends HttpServlet {

    private final EventDAO dao = new EventDAO();

    /** Returns true when the request carries a valid admin session. */
    private boolean isLoggedIn(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        return session != null && session.getAttribute("loggedInUser") != null;
    }

    // =====================================================================
    //  GET
    // =====================================================================
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {

            // --- Show Add-Event form (login required) ---
            case "new":
                if (!isLoggedIn(req)) {
                    res.sendRedirect(req.getContextPath() + "/login?msg=unauthorized");
                    return;
                }
                req.getRequestDispatcher("event-form.jsp").forward(req, res);
                break;

            // --- Show Edit-Event form (login required) ---
            case "edit":
                if (!isLoggedIn(req)) {
                    res.sendRedirect(req.getContextPath() + "/login?msg=unauthorized");
                    return;
                }
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("event", dao.getEventById(id));
                req.getRequestDispatcher("event-form.jsp").forward(req, res);
                break;

            // --- Delete event (login required) ---
            case "delete":
                if (!isLoggedIn(req)) {
                    res.sendRedirect(req.getContextPath() + "/login?msg=unauthorized");
                    return;
                }
                dao.deleteEvent(Integer.parseInt(req.getParameter("id")));
                res.sendRedirect(req.getContextPath() + "/events?msg=deleted");
                break;

            // --- List events  (public – no login required to browse) ---
            default:
                String keyword  = req.getParameter("keyword");
                String category = req.getParameter("category");
                // searchEvents() returns all events when both params are null/empty
                req.setAttribute("events",   dao.searchEvents(keyword, category));
                req.setAttribute("keyword",  keyword  != null ? keyword  : "");
                req.setAttribute("category", category != null ? category : "");
                req.getRequestDispatcher("index.jsp").forward(req, res);
        }
    }

    // =====================================================================
    //  POST  (add / update – login required)
    // =====================================================================
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        if (!isLoggedIn(req)) {
            res.sendRedirect(req.getContextPath() + "/login?msg=unauthorized");
            return;
        }

        req.setCharacterEncoding("UTF-8");

        Event event = new Event();
        String idParam = req.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            event.setId(Integer.parseInt(idParam));
        }
        event.setTitle(req.getParameter("title"));
        event.setDescription(req.getParameter("description"));
        event.setDate(req.getParameter("date"));
        event.setVenue(req.getParameter("venue"));
        event.setCategory(req.getParameter("category"));

        if (event.getId() == 0) {
            dao.addEvent(event);
            res.sendRedirect(req.getContextPath() + "/events?msg=added");
        } else {
            dao.updateEvent(event);
            res.sendRedirect(req.getContextPath() + "/events?msg=updated");
        }
    }
}
