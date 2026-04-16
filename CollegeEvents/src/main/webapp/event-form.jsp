<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%-- Protect direct access: only logged-in admins can see the form --%>
<%
    jakarta.servlet.http.HttpSession sess = request.getSession(false);
    if (sess == null || sess.getAttribute("loggedInUser") == null) {
        response.sendRedirect(request.getContextPath() + "/login?msg=unauthorized");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${empty event ? 'Add Event' : 'Edit Event'} | College Event Manager</title>
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

  /* ===== FORM LAYOUT ===== */
  .container {
    max-width: 640px;
    margin: 40px auto;
    padding: 0 20px;
  }

  .card {
    background: white;
    border-radius: 14px;
    box-shadow: 0 2px 16px rgba(0,0,0,0.1);
    padding: 38px 42px;
  }

  .card h2 {
    font-size: 1.25rem;
    margin-bottom: 28px;
    color: #1a365d;
    border-bottom: 2px solid #ebf4ff;
    padding-bottom: 14px;
  }

  .form-group { margin-bottom: 20px; }

  label {
    display: block;
    font-size: 0.78rem;
    font-weight: 700;
    color: #4a5568;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    margin-bottom: 6px;
  }

  input[type="text"],
  input[type="date"],
  textarea,
  select {
    width: 100%;
    padding: 11px 14px;
    border: 1.5px solid #cbd5e0;
    border-radius: 8px;
    font-size: 0.95rem;
    font-family: inherit;
    color: #2d3748;
    background: #f7fafc;
    transition: border-color 0.2s, box-shadow 0.2s;
    outline: none;
  }

  input:focus, textarea:focus, select:focus {
    border-color: #2b6cb0;
    box-shadow: 0 0 0 3px rgba(43,108,176,0.15);
    background: white;
  }

  textarea { resize: vertical; min-height: 90px; }

  .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }

  /* ===== BUTTONS ===== */
  .btn-group {
    display: flex;
    gap: 12px;
    margin-top: 28px;
  }
  .btn {
    flex: 1;
    padding: 13px;
    border-radius: 8px;
    font-size: 0.95rem;
    font-weight: 600;
    cursor: pointer;
    text-decoration: none;
    border: none;
    text-align: center;
    transition: all 0.2s;
    font-family: inherit;
    display: block;
  }
  .btn-primary { background: linear-gradient(135deg, #1a365d, #2b6cb0); color: white; }
  .btn-primary:hover {
    background: linear-gradient(135deg, #2b6cb0, #1a365d);
    box-shadow: 0 5px 16px rgba(43,108,176,0.35);
    transform: translateY(-1px);
  }
  .btn-secondary { background: #e2e8f0; color: #4a5568; }
  .btn-secondary:hover { background: #cbd5e0; }
</style>
</head>
<body>

<jsp:include page="navbar.jsp"/>

<div class="container">
  <div class="card">
    <h2>${empty event ? '➕ Add New Event' : '✏️ Edit Event'}</h2>

    <form action="${pageContext.request.contextPath}/events" method="post" id="event-form">

      <%-- Hidden ID for edit mode --%>
      <c:if test="${not empty event}">
        <input type="hidden" name="id" value="${event.id}">
      </c:if>

      <div class="form-group">
        <label for="title">Event Title *</label>
        <input type="text"
               id="title"
               name="title"
               placeholder="e.g. Annual Tech Fest"
               value="${event.title}"
               required>
      </div>

      <div class="form-group">
        <label for="description">Description</label>
        <textarea id="description"
                  name="description"
                  placeholder="Brief description of the event...">${event.description}</textarea>
      </div>

      <div class="form-row">
        <div class="form-group">
          <label for="date">Date *</label>
          <input type="date"
                 id="date"
                 name="date"
                 value="${event.date}"
                 required>
        </div>
        <div class="form-group">
          <label for="venue">Venue *</label>
          <input type="text"
                 id="venue"
                 name="venue"
                 placeholder="e.g. Auditorium A"
                 value="${event.venue}"
                 required>
        </div>
      </div>

      <div class="form-group">
        <label for="category">Category *</label>
        <select id="category" name="category" required>
          <option value="">-- Select Category --</option>
          <c:set var="cats" value="Cultural,Technical,Sports,Academic,Other"/>
          <c:forTokens var="cat" items="${cats}" delims=",">
            <option value="${cat}"
              <c:if test="${event.category == cat}">selected</c:if>
            >${cat}</option>
          </c:forTokens>
        </select>
      </div>

      <div class="btn-group">
        <button type="submit" class="btn btn-primary" id="btn-submit">
          ${empty event ? '✅ Add Event' : '💾 Save Changes'}
        </button>
        <a href="${pageContext.request.contextPath}/events" class="btn btn-secondary" id="btn-cancel">✖ Cancel</a>
      </div>

    </form>
  </div>
</div>

</body>
</html>
