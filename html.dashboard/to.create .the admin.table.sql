-- =========================================
-- NEET SECURITY PROJECT DATABASE
-- =========================================

-- Create database
CREATE DATABASE IF NOT EXISTS neet_security;

-- Select database
USE neet_security;


-- =========================================
-- USERS TABLE
-- =========================================

DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(30) NOT NULL,
    status VARCHAR(20) DEFAULT 'Active'
);

-- Admin user
-- Password: siri@1234
INSERT INTO users (username, password, role, status)
VALUES (
    'admin',
    'scrypt:32768:8:1$VCsbn4vWWVt539Pt$8b45ab806268885fbf88ff9c2ba0aadfe21765024bdc45b6f9400b8c20187d79a9ba4f30b54d0d279de0469e7480c7e33f1409c30d85b267aebb163cef3fc1df',
    'Admin',
    'Active'
);


-- =========================================
-- PAPERS TABLE
-- =========================================

DROP TABLE IF EXISTS papers;

CREATE TABLE papers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    paper_id VARCHAR(50) UNIQUE NOT NULL,
    paper_name VARCHAR(100) NOT NULL,
    year INT NOT NULL,
    status VARCHAR(20) DEFAULT 'Secure'
);


-- =========================================
-- SAMPLE PAPER
-- =========================================

INSERT INTO papers (paper_id, paper_name, year, status)
VALUES (
    'NEET2025',
    'NEET Question Paper',
    2025,
    'Secure'
);


-- =========================================
-- CHECK DATA
-- =========================================

SELECT * FROM users;

SELECT * FROM papers;