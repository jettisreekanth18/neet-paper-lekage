DESCRIBE papers;

CREATE TABLE papers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    paper_id VARCHAR(50) UNIQUE NOT NULL,
    paper_name VARCHAR(100) NOT NULL,
    year INT NOT NULL,
    status VARCHAR(20) DEFAULT 'Secure'
);