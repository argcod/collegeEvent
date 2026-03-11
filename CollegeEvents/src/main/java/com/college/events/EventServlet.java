package com.college.events;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;


public class EventServlet extends HttpServlet {

    private final EventDAO dao = new EventDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "new":
                req.getRequestDispatcher("event-form.jsp").forward(req, res);
                break;

            case "edit":
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("event", dao.getEventById(id));
                req.getRequestDispatcher("event-form.jsp").forward(req, res);
                break;

            case "delete":
                dao.deleteEvent(Integer.parseInt(req.getParameter("id")));
                res.sendRedirect("events?action=list&msg=deleted");
                break;

            default: // list
                req.setAttribute("events", dao.getAllEvents());
                req.getRequestDispatcher("index.jsp").forward(req, res);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

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
            res.sendRedirect("events?action=list&msg=added");
        } else {
            dao.updateEvent(event);
            res.sendRedirect("events?action=list&msg=updated");
        }
    }
}
