select * FROM users;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(30) NOT NULL,
    status VARCHAR(20) DEFAULT 'Active'
);

INSERT INTO users (username, password, role, status)
VALUES ('admin', 'admin123', 'Admin', 'Active');