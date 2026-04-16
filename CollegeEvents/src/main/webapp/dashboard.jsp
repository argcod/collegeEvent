<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard | College Event Manager</title>
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
  .container { max-width: 1100px; margin: 32px auto; padding: 0 24px; }

  .page-header { margin-bottom: 28px; }
  .page-header h1 { font-size: 1.7rem; color: #1a365d; font-weight: 700; }
  .page-header p  { font-size: 0.95rem; color: #718096; margin-top: 4px; }

  /* ===== STAT CARDS (top row) ===== */
  .stats-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 20px;
    margin-bottom: 36px;
  }

  .stat-card {
    background: white;
    border-radius: 14px;
    padding: 28px 24px;
    box-shadow: 0 2px 12px rgba(0,0,0,0.07);
    text-align: center;
    border-top: 4px solid transparent;
    transition: transform 0.22s, box-shadow 0.22s;
    animation: fadeInUp 0.4s ease both;
  }
  .stat-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 10px 28px rgba(0,0,0,0.12);
  }
  .stat-card:nth-child(1) { border-top-color: #2b6cb0; animation-delay: 0.05s; }
  .stat-card:nth-child(2) { border-top-color: #38a169; animation-delay: 0.12s; }
  .stat-card:nth-child(3) { border-top-color: #dd6b20; animation-delay: 0.18s; }

  .stat-icon  { font-size: 2.4rem; margin-bottom: 12px; }
  .stat-value { font-size: 3rem;   font-weight: 800; line-height: 1; color: #1a365d; }
  .stat-label { font-size: 0.88rem; color: #718096; margin-top: 8px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.4px; }

  @keyframes fadeInUp {
    from { opacity: 0; transform: translateY(20px); }
    to   { opacity: 1; transform: translateY(0);    }
  }

  /* ===== CATEGORY SECTION ===== */
  .section-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 16px;
  }
  .section-header h2 { font-size: 1.1rem; color: #2d3748; font-weight: 700; }
  .section-header a  { font-size: 0.85rem; color: #2b6cb0; text-decoration: none; font-weight: 600; }
  .section-header a:hover { text-decoration: underline; }

  .category-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(195px, 1fr));
    gap: 16px;
    margin-bottom: 36px;
  }

  .cat-card {
    background: white;
    border-radius: 10px;
    padding: 20px 22px;
    display: flex;
    align-items: center;
    gap: 14px;
    box-shadow: 0 1px 6px rgba(0,0,0,0.07);
    transition: transform 0.2s, box-shadow 0.2s;
    animation: fadeInUp 0.4s ease both;
  }
  .cat-card:hover { transform: translateY(-3px); box-shadow: 0 6px 18px rgba(0,0,0,0.1); }

  .cat-icon { font-size: 1.8rem; flex-shrink: 0; }

  .cat-info span {
    display: block;
    font-size: 0.78rem;
    color: #718096;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.4px;
  }
  .cat-count { font-size: 1.7rem; font-weight: 800; color: #1a365d; line-height: 1.1; }

  /* ===== QUICK ACTIONS ===== */
  .quick-actions {
    display: flex;
    gap: 14px;
    flex-wrap: wrap;
  }
  .btn {
    display: inline-block;
    padding: 11px 26px;
    border-radius: 8px;
    font-size: 0.9rem;
    font-weight: 600;
    text-decoration: none;
    transition: all 0.2s;
    cursor: pointer;
    border: none;
  }
  .btn-primary { background: #2b6cb0; color: white; }
  .btn-primary:hover { background: #2c5282; transform: translateY(-1px); box-shadow: 0 4px 14px rgba(43,108,176,0.35); }
  .btn-secondary { background: white; color: #2b6cb0; border: 2px solid #2b6cb0; }
  .btn-secondary:hover { background: #ebf4ff; }

  /* ===== EMPTY CATEGORY ===== */
  .no-events { text-align: center; padding: 40px; color: #a0aec0; font-size: 0.95rem; }
</style>
</head>
<body>

<jsp:include page="navbar.jsp"/>

<div class="container">

  <div class="page-header">
    <h1>📊 Event Dashboard</h1>
    <p>Real-time overview of all campus events</p>
  </div>

  <%-- ===== STAT CARDS ===== --%>
  <div class="stats-grid">

    <div class="stat-card">
      <div class="stat-icon">📋</div>
      <div class="stat-value">${totalEvents}</div>
      <div class="stat-label">Total Events</div>
    </div>

    <div class="stat-card">
      <div class="stat-icon">🚀</div>
      <div class="stat-value">${upcomingCount}</div>
      <div class="stat-label">Upcoming Events</div>
    </div>

    <div class="stat-card">
      <div class="stat-icon">📁</div>
      <div class="stat-value">${pastCount}</div>
      <div class="stat-label">Past Events</div>
    </div>

  </div>

  <%-- ===== EVENTS BY CATEGORY ===== --%>
  <div class="section-header">
    <h2>Events by Category</h2>
    <a href="${pageContext.request.contextPath}/events">View all events →</a>
  </div>

  <c:choose>
    <c:when test="${empty categoryMap}">
      <div class="no-events">No events in the database yet.</div>
    </c:when>
    <c:otherwise>
      <div class="category-grid">
        <c:forEach var="entry" items="${categoryMap}">

          <%-- Pick icon based on category name --%>
          <c:choose>
            <c:when test="${entry.key == 'Cultural'}">
              <c:set var="catIcon" value="🎭"/>
              <c:set var="catDelay" value="0.08s"/>
            </c:when>
            <c:when test="${entry.key == 'Technical'}">
              <c:set var="catIcon" value="💻"/>
              <c:set var="catDelay" value="0.14s"/>
            </c:when>
            <c:when test="${entry.key == 'Sports'}">
              <c:set var="catIcon" value="⚽"/>
              <c:set var="catDelay" value="0.20s"/>
            </c:when>
            <c:when test="${entry.key == 'Academic'}">
              <c:set var="catIcon" value="📚"/>
              <c:set var="catDelay" value="0.26s"/>
            </c:when>
            <c:otherwise>
              <c:set var="catIcon" value="📌"/>
              <c:set var="catDelay" value="0.32s"/>
            </c:otherwise>
          </c:choose>

          <div class="cat-card" style="animation-delay:${catDelay}">
            <div class="cat-icon">${catIcon}</div>
            <div class="cat-info">
              <span>${entry.key}</span>
              <div class="cat-count">${entry.value}</div>
            </div>
          </div>

        </c:forEach>
      </div>
    </c:otherwise>
  </c:choose>

  <%-- ===== QUICK ACTIONS ===== --%>
  <div class="section-header">
    <h2>Quick Actions</h2>
  </div>
  <div class="quick-actions">
    <a href="${pageContext.request.contextPath}/events" class="btn btn-secondary">🏠 View All Events</a>
    <c:if test="${not empty sessionScope.loggedInUser}">
      <a href="${pageContext.request.contextPath}/events?action=new" class="btn btn-primary">➕ Add New Event</a>
    </c:if>
    <c:if test="${empty sessionScope.loggedInUser}">
      <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">🔐 Login to Add Events</a>
    </c:if>
  </div>

</div>
</body>
</html>
