-- =========================================
-- NEET SECURITY SYSTEM - MYSQL DATABASE
-- =========================================

-- Create database
CREATE DATABASE IF NOT EXISTS neet_security;

-- Select database
USE neet_security;


-- =========================================
-- USERS TABLE
-- =========================================

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(30) NOT NULL,
    status VARCHAR(20) DEFAULT 'Active'
);


-- =========================================
-- ADMIN USER
-- Username: admin
-- Password: siri@1234
-- =========================================

INSERT INTO users (username, password, role, status)
SELECT
    'admin',
    'scrypt:32768:8:1$VCsbn4vWWVt539Pt$8b45ab806268885fbf88ff9c2ba0aadfe21765024bdc45b6f9400b8c20187d79a9ba4f30b54d0d279de0469e7480c7e33f1409c30d85b267aebb163cef3fc1df',
    'Admin',
    'Active'
WHERE NOT EXISTS (
    SELECT 1 FROM users WHERE username = 'admin'
);


-- =========================================
-- PAPERS TABLE
-- =========================================

CREATE TABLE IF NOT EXISTS papers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    paper_id VARCHAR(50) UNIQUE NOT NULL,
    paper_name VARCHAR(100) NOT NULL,
    year INT NOT NULL,
    status VARCHAR(20) DEFAULT 'Secure'
);


-- =========================================
-- ACCESS LOGS TABLE
-- =========================================

CREATE TABLE IF NOT EXISTS access_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    action VARCHAR(100) NOT NULL,
    paper_id VARCHAR(50) NULL,
    access_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- =========================================
-- FIX PAPER_ID FOR ACCESS LOGS
-- =========================================

ALTER TABLE access_logs
MODIFY paper_id VARCHAR(50) NULL;


-- =========================================
-- CHECK USERS
-- =========================================

SELECT * FROM users;


-- =========================================
-- CHECK PAPERS
-- =========================================

SELECT * FROM papers;


-- =========================================
-- CHECK ACCESS LOGS
-- =========================================

SELECT * FROM access_logs
ORDER BY access_time DESC;