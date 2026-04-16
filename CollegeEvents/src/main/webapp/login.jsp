<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Login | College Event Manager</title>
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }

  body {
    font-family: 'Segoe UI', Tahoma, sans-serif;
    min-height: 100vh;
    background: linear-gradient(135deg, #0f2044 0%, #1a365d 50%, #2b6cb0 100%);
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .login-wrapper {
    width: 100%;
    max-width: 420px;
    padding: 20px;
    animation: fadeInUp 0.5s ease both;
  }

  @keyframes fadeInUp {
    from { opacity: 0; transform: translateY(28px); }
    to   { opacity: 1; transform: translateY(0);    }
  }

  /* ---- Brand above card ---- */
  .login-brand {
    text-align: center;
    color: white;
    margin-bottom: 28px;
  }
  .login-brand .logo  { font-size: 3.2rem; }
  .login-brand h1     { font-size: 1.45rem; font-weight: 700; margin-top: 8px; }
  .login-brand p      { font-size: 0.85rem; opacity: 0.65; margin-top: 4px; }

  /* ---- Card ---- */
  .card {
    background: white;
    border-radius: 16px;
    padding: 36px 40px;
    box-shadow: 0 24px 64px rgba(0,0,0,0.35);
  }

  .card h2 {
    font-size: 1.05rem;
    color: #1a365d;
    font-weight: 600;
    text-align: center;
    margin-bottom: 26px;
  }

  /* ---- Alerts ---- */
  .alert-error {
    background: #fff5f5;
    color: #c53030;
    border: 1px solid #fed7d7;
    border-left: 4px solid #e53e3e;
    border-radius: 8px;
    padding: 10px 14px;
    margin-bottom: 20px;
    font-size: 0.875rem;
    font-weight: 500;
  }

  /* ---- Form fields ---- */
  .form-group { margin-bottom: 18px; }

  .form-group label {
    display: block;
    font-size: 0.78rem;
    font-weight: 700;
    color: #4a5568;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    margin-bottom: 6px;
  }

  .form-group input {
    width: 100%;
    padding: 11px 14px;
    border: 1.5px solid #e2e8f0;
    border-radius: 8px;
    font-size: 0.95rem;
    font-family: inherit;
    color: #2d3748;
    background: #f7fafc;
    transition: border-color 0.2s, box-shadow 0.2s;
    outline: none;
  }

  .form-group input:focus {
    border-color: #2b6cb0;
    background: white;
    box-shadow: 0 0 0 3px rgba(43,108,176,0.15);
  }

  /* ---- Submit button ---- */
  .btn-login {
    width: 100%;
    padding: 13px;
    background: linear-gradient(135deg, #1a365d, #2b6cb0);
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 1rem;
    font-weight: 600;
    cursor: pointer;
    font-family: inherit;
    letter-spacing: 0.3px;
    transition: all 0.2s;
    margin-top: 6px;
  }

  .btn-login:hover {
    background: linear-gradient(135deg, #2b6cb0, #1a365d);
    box-shadow: 0 6px 20px rgba(43,108,176,0.4);
    transform: translateY(-1px);
  }

  .btn-login:active { transform: translateY(0); }

  /* ---- Hint ---- */
  .hint {
    text-align: center;
    margin-top: 20px;
    font-size: 0.8rem;
    color: #a0aec0;
  }

  .hint code {
    background: #f7fafc;
    padding: 2px 7px;
    border-radius: 4px;
    color: #4a5568;
    font-size: 0.82rem;
    border: 1px solid #e2e8f0;
  }

  .back-link {
    display: block;
    text-align: center;
    margin-top: 16px;
    font-size: 0.85rem;
    color: rgba(255,255,255,0.6);
    text-decoration: none;
    transition: color 0.2s;
  }
  .back-link:hover { color: white; }
</style>
</head>
<body>

<div class="login-wrapper">

  <%-- Brand header --%>
  <div class="login-brand">
    <div class="logo">🎓</div>
    <h1>College Event Manager</h1>
    <p>Admin Portal &mdash; Secure Access</p>
  </div>

  <%-- Login card --%>
  <div class="card">
    <h2>🔐 Sign In to Continue</h2>

    <%-- Error message from failed login --%>
    <c:if test="${not empty error}">
      <div class="alert-error">⚠️ ${error}</div>
    </c:if>

    <%-- Redirected here because of unauthorized action --%>
    <c:if test="${param.msg == 'unauthorized'}">
      <div class="alert-error">🔒 Please log in to perform that action.</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post">
      <div class="form-group">
        <label for="username">Username</label>
        <input type="text"
               id="username"
               name="username"
               placeholder="Enter admin username"
               value="${not empty param.username ? param.username : ''}"
               required autofocus>
      </div>

      <div class="form-group">
        <label for="password">Password</label>
        <input type="password"
               id="password"
               name="password"
               placeholder="Enter password"
               required>
      </div>

      <button type="submit" class="btn-login">🔓 Login</button>
    </form>

    <p class="hint">
      Default credentials: &nbsp;<code>admin</code> / <code>admin123</code>
    </p>
  </div>

  <a href="${pageContext.request.contextPath}/events" class="back-link">← Back to Events (view only)</a>

</div>

</body>
</html>
