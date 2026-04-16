-- ============================================================
--  College Event Manager  –  Database Setup (with new features)
-- ============================================================

-- 1. Create database
CREATE DATABASE IF NOT EXISTS college_events;
USE college_events;

-- 2. Events table (unchanged)
CREATE TABLE IF NOT EXISTS events (
    id          INT          AUTO_INCREMENT PRIMARY KEY,
    title       VARCHAR(150) NOT NULL,
    description TEXT,
    date        DATE         NOT NULL,
    venue       VARCHAR(100) NOT NULL,
    category    VARCHAR(50)  NOT NULL,
    created_at  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================================
--  FEATURE 1 – Authentication
--  users table stores admin credentials (plain-text for demo)
-- ==========================================================
CREATE TABLE IF NOT EXISTS users (
    id       INT          AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50)  NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    name     VARCHAR(100) NOT NULL
);

-- Default admin account   username: admin   password: admin123
INSERT IGNORE INTO users (username, password, name)
VALUES ('admin', 'admin123', 'Administrator');

-- 3. Sample event data (run only on a fresh database)
INSERT INTO events (title, description, date, venue, category) VALUES
('Annual Tech Fest 2025',     'A 2-day hackathon and coding contest open to all CS students.',  '2026-06-15', 'Main Auditorium',  'Technical'),
('Classical Dance Night',     'Showcase of Bharatanatyam and folk dance by college students.',  '2026-06-22', 'Open Air Theatre', 'Cultural'),
('Inter-College Cricket Cup', 'Knockout cricket tournament among 8 colleges.',                  '2026-07-05', 'College Ground',   'Sports'),
('Research Paper Workshop',   'Learn how to write and present academic research papers.',       '2026-07-10', 'Seminar Hall B',   'Academic'),
('Freshers Welcome Night',    'Fun evening for first-year students with games and music.',      '2026-07-20', 'College Canteen',  'Cultural'),
('AI & Future Symposium',     'Industry experts discuss the future of Artificial Intelligence.','2026-08-01', 'Conference Hall',  'Technical'),
('Annual Sports Day',         'Inter-department athletics and field events competition.',       '2025-12-10', 'Sports Complex',   'Sports'),
('Science Exhibition 2025',   'Students present their research and innovation projects.',       '2025-11-05', 'Lab Block C',      'Academic');
