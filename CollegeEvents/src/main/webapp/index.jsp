<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt"  prefix="fmt" %>
<%-- Safeguard: if someone hits index.jsp directly (not via EventServlet),
     redirect them through the servlet so the events list is populated. --%>
<%
    if (request.getAttribute("events") == null) {
        response.sendRedirect(request.getContextPath() + "/events");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>College Event Manager</title>
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }

  body {
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background: #f0f4f8;
    color: #2d3748;
    min-height: 100vh;
  }

  /* ===== NAVBAR ===== */
  .navbar {
    background: linear-gradient(135deg, #1a365d 0%, #2b6cb0 100%);
    padding: 0 40px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    box-shadow: 0 2px 10px rgba(0,0,0,0.25);
    height: 64px;
    position: sticky;
    top: 0;
    z-index: 100;
  }
  .nav-brand a {
    color: white;
    text-decoration: none;
    font-size: 1.4rem;
    font-weight: 700;
    letter-spacing: 0.3px;
  }
  .nav-links {
    display: flex;
    list-style: none;
    gap: 4px;
    align-items: center;
    margin: 0;
    padding: 0;
  }
  .nav-links li a {
    color: rgba(255,255,255,0.85);
    text-decoration: none;
    padding: 8px 14px;
    border-radius: 6px;
    font-size: 0.9rem;
    font-weight: 500;
    transition: all 0.2s;
    display: block;
  }
  .nav-links li a:hover { color: white; background: rgba(255,255,255,0.18); }
  .nav-user-info { color: rgba(255,255,255,0.7); font-size: 0.85rem; padding: 0 8px; }
  .nav-logout { background: rgba(255,255,255,0.1) !important; border: 1px solid rgba(255,255,255,0.25) !important; }
  .nav-logout:hover { background: rgba(220,38,38,0.55) !important; color: white !important; }

  /* ===== LAYOUT ===== */
  .container { max-width: 1100px; margin: 28px auto; padding: 0 24px; }

  /* ===== ALERTS ===== */
  .alert {
    padding: 12px 20px;
    border-radius: 8px;
    margin-bottom: 18px;
    font-size: 0.9rem;
    font-weight: 500;
  }
  .alert-success { background: #c6f6d5; color: #276749; border-left: 4px solid #38a169; }

  /* ===== SEARCH BAR ===== */
  .search-section {
    background: white;
    border-radius: 10px;
    padding: 16px 22px;
    box-shadow: 0 1px 6px rgba(0,0,0,0.07);
    margin-bottom: 20px;
  }
  .search-form {
    display: flex;
    gap: 10px;
    align-items: center;
    flex-wrap: wrap;
  }
  .search-input {
    flex: 1;
    min-width: 200px;
    padding: 10px 14px;
    border: 1.5px solid #cbd5e0;
    border-radius: 7px;
    font-size: 0.95rem;
    font-family: inherit;
    color: #2d3748;
    background: #f7fafc;
    outline: none;
    transition: border-color 0.2s, box-shadow 0.2s;
  }
  .search-input:focus {
    border-color: #2b6cb0;
    box-shadow: 0 0 0 3px rgba(43,108,176,0.12);
    background: white;
  }
  .cat-select {
    padding: 10px 14px;
    border: 1.5px solid #cbd5e0;
    border-radius: 7px;
    font-size: 0.95rem;
    font-family: inherit;
    color: #2d3748;
    background: #f7fafc;
    outline: none;
    cursor: pointer;
    min-width: 165px;
    transition: border-color 0.2s;
  }
  .cat-select:focus { border-color: #2b6cb0; }
  .btn-search {
    padding: 10px 22px;
    background: #2b6cb0;
    color: white;
    border: none;
    border-radius: 7px;
    font-size: 0.9rem;
    font-weight: 600;
    cursor: pointer;
    font-family: inherit;
    transition: background 0.2s;
  }
  .btn-search:hover { background: #2c5282; }
  .btn-clear {
    padding: 10px 18px;
    background: #e2e8f0;
    color: #4a5568;
    border: none;
    border-radius: 7px;
    font-size: 0.9rem;
    font-weight: 600;
    cursor: pointer;
    font-family: inherit;
    text-decoration: none;
    display: inline-block;
    transition: background 0.2s;
  }
  .btn-clear:hover { background: #cbd5e0; }

  /* ===== TOP BAR ===== */
  .top-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 16px;
  }
  .top-bar h2 { font-size: 1.1rem; color: #4a5568; font-weight: 600; }

  /* ===== BUTTONS ===== */
  .btn {
    display: inline-block;
    padding: 10px 22px;
    border-radius: 7px;
    font-size: 0.9rem;
    font-weight: 600;
    cursor: pointer;
    text-decoration: none;
    border: none;
    transition: all 0.2s;
  }
  .btn-primary { background: #2b6cb0; color: white; }
  .btn-primary:hover { background: #2c5282; }
  .btn-edit   { background: #ecc94b; color: #744210; font-size: 0.8rem; padding: 6px 13px; }
  .btn-edit:hover { background: #d69e2e; }
  .btn-delete { background: #fc8181; color: #742a2a; font-size: 0.8rem; padding: 6px 13px; }
  .btn-delete:hover { background: #f56565; }

  /* ===== TABLE ===== */
  table {
    width: 100%;
    background: white;
    border-radius: 10px;
    box-shadow: 0 1px 8px rgba(0,0,0,0.08);
    border-collapse: collapse;
    overflow: hidden;
  }
  thead { background: #2b6cb0; color: white; }
  th {
    padding: 14px 16px;
    text-align: left;
    font-size: 0.8rem;
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }
  td { padding: 13px 16px; font-size: 0.9rem; border-bottom: 1px solid #e2e8f0; }
  tr:last-child td { border-bottom: none; }
  tr:hover td { background: #ebf4ff; transition: background 0.15s; }

  /* ===== CATEGORY BADGES ===== */
  .badge {
    display: inline-block;
    padding: 3px 10px;
    border-radius: 12px;
    font-size: 0.75rem;
    font-weight: 600;
  }
  .badge-cultural   { background: #feebc8; color: #c05621; }
  .badge-technical  { background: #bee3f8; color: #2b6cb0; }
  .badge-sports     { background: #c6f6d5; color: #276749; }
  .badge-academic   { background: #e9d8fd; color: #553c9a; }
  .badge-other      { background: #e2e8f0; color: #4a5568; }

  .actions { display: flex; gap: 8px; }

  /* ===== EMPTY STATE ===== */
  .empty {
    text-align: center;
    padding: 60px 20px;
    color: #a0aec0;
    font-size: 0.95rem;
  }
  .empty .empty-icon { font-size: 3rem; display: block; margin-bottom: 12px; }
  .empty a { color: #2b6cb0; text-decoration: none; font-weight: 600; }
  .empty a:hover { text-decoration: underline; }
</style>
</head>
<body>

<jsp:include page="navbar.jsp"/>

<div class="container">

  <%-- Flash messages --%>
  <c:if test="${param.msg == 'added'}">
    <div class="alert alert-success">✅ Event added successfully!</div>
  </c:if>
  <c:if test="${param.msg == 'updated'}">
    <div class="alert alert-success">✅ Event updated successfully!</div>
  </c:if>
  <c:if test="${param.msg == 'deleted'}">
    <div class="alert alert-success">🗑️ Event deleted successfully!</div>
  </c:if>

  <%-- ===== SEARCH & FILTER BAR ===== --%>
  <div class="search-section">
    <form class="search-form"
          action="${pageContext.request.contextPath}/events" method="get">
      <input type="text"
             class="search-input"
             name="keyword"
             id="search-keyword"
             value="${keyword}"
             placeholder="🔍  Search events by title...">

      <select class="cat-select" name="category" id="search-category">
        <option value="">All Categories</option>
        <option value="Cultural"  ${category == 'Cultural'  ? 'selected' : ''}>🎭 Cultural</option>
        <option value="Technical" ${category == 'Technical' ? 'selected' : ''}>💻 Technical</option>
        <option value="Sports"    ${category == 'Sports'    ? 'selected' : ''}>⚽ Sports</option>
        <option value="Academic"  ${category == 'Academic'  ? 'selected' : ''}>📚 Academic</option>
        <option value="Other"     ${category == 'Other'     ? 'selected' : ''}>📌 Other</option>
      </select>

      <button type="submit" class="btn-search" id="btn-search-submit">🔍 Search</button>
      <a href="${pageContext.request.contextPath}/events" class="btn-clear" id="btn-search-clear">✖ Clear</a>
    </form>
  </div>

  <%-- ===== TOP BAR ===== --%>
  <div class="top-bar">
    <h2>
      <c:choose>
        <c:when test="${not empty keyword or not empty category}">
          Search Results &nbsp;<span style="color:#a0aec0;font-weight:400;">(${events.size()} found)</span>
        </c:when>
        <c:otherwise>
          All Events &nbsp;<span style="color:#a0aec0;font-weight:400;">(${events.size()})</span>
        </c:otherwise>
      </c:choose>
    </h2>
    <c:if test="${not empty sessionScope.loggedInUser}">
      <a href="${pageContext.request.contextPath}/events?action=new"
         class="btn btn-primary" id="btn-add-event">➕ Add New Event</a>
    </c:if>
  </div>

  <%-- ===== EVENTS TABLE ===== --%>
  <c:choose>
    <c:when test="${empty events}">
      <div class="empty">
        <span class="empty-icon">📅</span>
        No events found.
        <c:choose>
          <c:when test="${not empty keyword or not empty category}">
            Try a different search or <a href="${pageContext.request.contextPath}/events">view all events</a>.
          </c:when>
          <c:otherwise>
            <c:if test="${not empty sessionScope.loggedInUser}">
              <a href="${pageContext.request.contextPath}/events?action=new">Add the first event</a>.
            </c:if>
            <c:if test="${empty sessionScope.loggedInUser}">
              <a href="${pageContext.request.contextPath}/login">Login</a> to add events.
            </c:if>
          </c:otherwise>
        </c:choose>
      </div>
    </c:when>
    <c:otherwise>
      <table>
        <thead>
          <tr>
            <th>#</th>
            <th>Title</th>
            <th>Date</th>
            <th>Venue</th>
            <th>Category</th>
            <c:if test="${not empty sessionScope.loggedInUser}">
              <th>Actions</th>
            </c:if>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="e" items="${events}" varStatus="s">
            <tr>
              <td>${s.count}</td>
              <td>
                <strong>${e.title}</strong><br>
                <small style="color:#718096">${e.description}</small>
              </td>
              <td>${e.date}</td>
              <td>${e.venue}</td>
              <td>
                <span class="badge badge-${e.category.toLowerCase()}">${e.category}</span>
              </td>
              <c:if test="${not empty sessionScope.loggedInUser}">
                <td>
                  <div class="actions">
                    <a href="${pageContext.request.contextPath}/events?action=edit&id=${e.id}"
                       class="btn btn-edit" id="btn-edit-${e.id}">✏️ Edit</a>
                    <a href="${pageContext.request.contextPath}/events?action=delete&id=${e.id}"
                       class="btn btn-delete"
                       id="btn-delete-${e.id}"
                       onclick="return confirm('Are you sure you want to delete this event?')">🗑️ Delete</a>
                  </div>
                </td>
              </c:if>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </c:otherwise>
  </c:choose>

</div>
</body>
</html>
