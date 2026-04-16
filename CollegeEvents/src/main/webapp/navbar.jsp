<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%--
  navbar.jsp  –  shared navigation bar included via <jsp:include> in every page.
  Uses its own taglib declaration because jsp:include compiles it independently.
--%>
<nav class="navbar">
  <div class="nav-brand">
    <a href="${pageContext.request.contextPath}/events">🎓 College Event Manager</a>
  </div>
  <ul class="nav-links">
    <li><a href="${pageContext.request.contextPath}/events"    id="nav-home">🏠 Home</a></li>
    <li><a href="${pageContext.request.contextPath}/dashboard" id="nav-dashboard">📊 Dashboard</a></li>
    <c:choose>
      <c:when test="${not empty sessionScope.loggedInUser}">
        <li><a href="${pageContext.request.contextPath}/events?action=new" id="nav-add">➕ Add Event</a></li>
        <li class="nav-user-info">👤 ${sessionScope.loggedInName}</li>
        <li><a href="${pageContext.request.contextPath}/login?action=logout" class="nav-logout" id="nav-logout">🔓 Logout</a></li>
      </c:when>
      <c:otherwise>
        <li><a href="${pageContext.request.contextPath}/login" id="nav-login">🔐 Login</a></li>
      </c:otherwise>
    </c:choose>
  </ul>
</nav>
