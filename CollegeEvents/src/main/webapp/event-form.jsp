<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${empty event ? 'Add Event' : 'Edit Event'} | College Event Manager</title>
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
  header h1 { font-size: 1.6rem; }

  .container {
    max-width: 620px;
    margin: 40px auto;
    padding: 0 20px;
  }

  .card {
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 12px rgba(0,0,0,0.1);
    padding: 36px 40px;
  }

  .card h2 {
    font-size: 1.3rem;
    margin-bottom: 28px;
    color: #2b6cb0;
    border-bottom: 2px solid #ebf4ff;
    padding-bottom: 12px;
  }

  .form-group {
    margin-bottom: 20px;
  }

  label {
    display: block;
    font-size: 0.85rem;
    font-weight: 600;
    color: #4a5568;
    margin-bottom: 6px;
    text-transform: uppercase;
    letter-spacing: 0.4px;
  }

  input[type="text"],
  input[type="date"],
  textarea,
  select {
    width: 100%;
    padding: 10px 14px;
    border: 1.5px solid #cbd5e0;
    border-radius: 7px;
    font-size: 0.95rem;
    font-family: inherit;
    color: #2d3748;
    background: #fafafa;
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

  .btn-group {
    display: flex;
    gap: 12px;
    margin-top: 28px;
  }

  .btn {
    flex: 1;
    padding: 12px;
    border-radius: 7px;
    font-size: 0.95rem;
    font-weight: 600;
    cursor: pointer;
    text-decoration: none;
    border: none;
    text-align: center;
    transition: all 0.2s;
  }

  .btn-primary { background: #2b6cb0; color: white; }
  .btn-primary:hover { background: #2c5282; }
  .btn-secondary { background: #e2e8f0; color: #4a5568; }
  .btn-secondary:hover { background: #cbd5e0; }
</style>
</head>
<body>

<header>
  <h1>🎓 College Event Manager</h1>
  <span>${empty event ? 'Add New Event' : 'Edit Event'}</span>
</header>

<div class="container">
  <div class="card">
    <h2>${empty event ? '➕ Add New Event' : '✏️ Edit Event'}</h2>

    <form action="events" method="post">

      <!-- hidden id for edit mode -->
      <c:if test="${not empty event}">
        <input type="hidden" name="id" value="${event.id}">
      </c:if>

      <div class="form-group">
        <label>Event Title *</label>
        <input type="text" name="title" placeholder="e.g. Annual Tech Fest"
               value="${event.title}" required>
      </div>

      <div class="form-group">
        <label>Description</label>
        <textarea name="description" placeholder="Brief description of the event...">${event.description}</textarea>
      </div>

      <div class="form-row">
        <div class="form-group">
          <label>Date *</label>
          <input type="date" name="date" value="${event.date}" required>
        </div>
        <div class="form-group">
          <label>Venue *</label>
          <input type="text" name="venue" placeholder="e.g. Auditorium A"
                 value="${event.venue}" required>
        </div>
      </div>

      <div class="form-group">
        <label>Category *</label>
        <select name="category" required>
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
        <button type="submit" class="btn btn-primary">
          ${empty event ? '✅ Add Event' : '💾 Save Changes'}
        </button>
        <a href="events" class="btn btn-secondary">✖ Cancel</a>
      </div>

    </form>
  </div>
</div>
</body>
</html>
