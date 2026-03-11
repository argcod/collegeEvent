# 🎓 College Event Manager – JSP CRUD Mini Project

A simple, clean web application to **Create, Read, Update, and Delete** college events using **JSP + Servlet + MySQL**.

---

## 📁 Project Structure

```
CollegeEvents/
├── src/main/
│   ├── java/com/college/events/
│   │   ├── Event.java          ← Model (POJO)
│   │   ├── DBConnection.java   ← Database utility
│   │   ├── EventDAO.java       ← CRUD database logic
│   │   └── EventServlet.java   ← Controller (HTTP handler)
│   └── webapp/
│       ├── index.jsp           ← View all events
│       ├── event-form.jsp      ← Add / Edit form
│       └── WEB-INF/
│           └── web.xml         ← Deployment descriptor
├── database.sql                ← DB setup script
└── pom.xml                     ← Maven build file
```

---

## ⚙️ Tech Stack

| Layer      | Technology            |
|------------|-----------------------|
| Frontend   | JSP + JSTL + HTML/CSS |
| Controller | Java Servlet          |
| Backend    | Java (DAO pattern)    |
| Database   | MySQL                 |
| Build      | Maven                 |
| Server     | Apache Tomcat 9/10    |

---

## 🚀 Setup & Run

### 1. Setup the Database
```sql
-- Run in MySQL Workbench or terminal:
source database.sql
```

### 2. Configure DB credentials
Edit `src/main/java/com/college/events/DBConnection.java`:
```java
private static final String URL      = "jdbc:mysql://localhost:3306/college_events";
private static final String USER     = "root";       // ← your MySQL user
private static final String PASSWORD = "root";       // ← your MySQL password
```

### 3. Build with Maven
```bash
mvn clean package
```
This creates `target/CollegeEvents.war`.

### 4. Deploy to Tomcat
Copy `CollegeEvents.war` into your Tomcat's `webapps/` folder, then start Tomcat.

### 5. Open in browser
```
http://localhost:8080/CollegeEvents/events
```

---

## 📋 Features

| Feature      | URL                              | Method |
|--------------|----------------------------------|--------|
| View all     | `/events`                        | GET    |
| Add form     | `/events?action=new`             | GET    |
| Save new     | `/events`                        | POST   |
| Edit form    | `/events?action=edit&id={id}`    | GET    |
| Save edit    | `/events`                        | POST   |
| Delete event | `/events?action=delete&id={id}`  | GET    |

---

## 📌 Notes
- No frameworks used — pure Servlet + JSP pattern.
- JSTL handles dynamic rendering in JSP pages.
- The DAO pattern keeps DB logic separate from servlet logic.
