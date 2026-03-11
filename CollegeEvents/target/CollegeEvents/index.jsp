<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt"  prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>College Event Manager</title>
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }

  body {
    font-family: 'Segoe UI', sans-serif;
    background: #f0f4f8;
    color: #2d3748;
    min-height: 100vh;
  }

  header {
    background: linear-gradient(135deg, #1a365d 0%, #2b6cb0 100%);
    color: white;
    padding: 20px 40px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    box-shadow: 0 2px 8px rgba(0,0,0,0.2);
  }

  header h1 { font-size: 1.6rem; letter-spacing: 0.5px; }
  header span { font-size: 0.9rem; opacity: 0.8; }

  .container { max-width: 1100px; margin: 30px auto; padding: 0 20px; }

  .top-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
  }

  .top-bar h2 { font-size: 1.2rem; color: #4a5568; }

  .btn {
    display: inline-block;
    padding: 10px 22px;
    border-radius: 6px;
    font-size: 0.9rem;
    font-weight: 600;
    cursor: pointer;
    text-decoration: none;
    border: none;
    transition: all 0.2s;
  }

  .btn-primary { background: #2b6cb0; color: white; }
  .btn-primary:hover { background: #2c5282; }
  .btn-edit { background: #ecc94b; color: #744210; font-size: 0.8rem; padding: 6px 14px; }
  .btn-edit:hover { background: #d69e2e; }
  .btn-delete { background: #fc8181; color: #742a2a; font-size: 0.8rem; padding: 6px 14px; }
  .btn-delete:hover { background: #f56565; }

  .alert {
    padding: 12px 20px;
    border-radius: 6px;
    margin-bottom: 20px;
    font-size: 0.9rem;
    font-weight: 500;
  }
  .alert-success { background: #c6f6d5; color: #276749; border-left: 4px solid #38a169; }

  table {
    width: 100%;
    background: white;
    border-radius: 10px;
    box-shadow: 0 1px 6px rgba(0,0,0,0.08);
    border-collapse: collapse;
    overflow: hidden;
  }

  thead { background: #2b6cb0; color: white; }
  th { padding: 14px 16px; text-align: left; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 0.5px; }
  td { padding: 13px 16px; font-size: 0.9rem; border-bottom: 1px solid #e2e8f0; }
  tr:last-child td { border-bottom: none; }
  tr:hover td { background: #ebf4ff; }

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

  .empty {
    text-align: center;
    padding: 60px 20px;
    color: #a0aec0;
    font-size: 1rem;
  }
  .empty span { font-size: 2.5rem; display: block; margin-bottom: 10px; }
</style>
</head>
<body>

<header>
  <h1>🎓 College Event Manager</h1>
  <span>Manage all campus events in one place</span>
</header>

<div class="container">

  <c:if test="${param.msg == 'added'}">
    <div class="alert alert-success">✅ Event added successfully!</div>
  </c:if>
  <c:if test="${param.msg == 'updated'}">
    <div class="alert alert-success">✅ Event updated successfully!</div>
  </c:if>
  <c:if test="${param.msg == 'deleted'}">
    <div class="alert alert-success">🗑️ Event deleted successfully!</div>
  </c:if>

  <div class="top-bar">
    <h2>All Events (${events.size()})</h2>
    <a href="events?action=new" class="btn btn-primary">+ Add New Event</a>
  </div>

  <c:choose>
    <c:when test="${empty events}">
      <div class="empty">
        <span>📅</span>
        No events found. Click "Add New Event" to get started.
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
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="e" items="${events}" varStatus="s">
            <tr>
              <td>${s.count}</td>
              <td><strong>${e.title}</strong><br>
                  <small style="color:#718096">${e.description}</small></td>
              <td>${e.date}</td>
              <td>${e.venue}</td>
              <td>
                <span class="badge badge-${e.category.toLowerCase()}">${e.category}</span>
              </td>
              <td>
                <div class="actions">
                  <a href="events?action=edit&id=${e.id}" class="btn btn-edit">✏️ Edit</a>
                  <a href="events?action=delete&id=${e.id}"
                     class="btn btn-delete"
                     onclick="return confirm('Delete this event?')">🗑️ Delete</a>
                </div>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </c:otherwise>
  </c:choose>

</div>
</body>
</html>
