-- ============================================
--  College Event Manager  –  Database Setup
-- ============================================

-- 1. Create database
CREATE DATABASE IF NOT EXISTS college_events;
USE college_events;

-- 2. Create events table
CREATE TABLE IF NOT EXISTS events (
    id          INT          AUTO_INCREMENT PRIMARY KEY,
    title       VARCHAR(150) NOT NULL,
    description TEXT,
    date        DATE         NOT NULL,
    venue       VARCHAR(100) NOT NULL,
    category    VARCHAR(50)  NOT NULL,
    created_at  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- 3. Sample data
INSERT INTO events (title, description, date, venue, category) VALUES
('Annual Tech Fest 2025',    'A 2-day hackathon and coding contest open to all CS students.',  '2025-03-15', 'Main Auditorium',   'Technical'),
('Classical Dance Night',    'Showcase of Bharatanatyam and folk dance by college students.',  '2025-03-22', 'Open Air Theatre',  'Cultural'),
('Inter-College Cricket Cup','Knockout cricket tournament among 8 colleges.',                  '2025-04-05', 'College Ground',    'Sports'),
('Research Paper Workshop',  'Learn how to write and present academic research papers.',       '2025-04-10', 'Seminar Hall B',    'Academic'),
('Freshers Welcome Night',   'Fun evening for first-year students with games and music.',      '2025-04-20', 'College Canteen',   'Cultural');
