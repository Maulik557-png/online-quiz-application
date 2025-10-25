-- Online Quiz Application Database Schema

CREATE DATABASE IF NOT EXISTS quiz_app;
    USE quiz_app;

-- Users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Quizzes table (for different quiz sets)
CREATE TABLE quizzes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Questions table
CREATE TABLE questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quiz_id INT NOT NULL,
    question_text TEXT NOT NULL,
    option_a TEXT NOT NULL,
    option_b TEXT NOT NULL,
    option_c TEXT NOT NULL,
    option_d TEXT NOT NULL,
    correct_answer INT NOT NULL, -- 0=A, 1=B, 2=C, 3=D
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE
);

-- Quiz results table
CREATE TABLE quiz_results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    quiz_id INT NOT NULL,
    score INT NOT NULL,
    total_questions INT NOT NULL,
    time_taken INT, -- in seconds
    completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE
);

-- Insert sample data
INSERT INTO users (username, password) VALUES ('admin', 'admin123'), ('user1', 'pass1');

INSERT INTO quizzes (title, description) VALUES ('General Knowledge', 'Basic general knowledge quiz');

INSERT INTO questions (quiz_id, question_text, option_a, option_b, option_c, option_d, correct_answer) VALUES
(1, 'What is the capital of France?', 'London', 'Berlin', 'Paris', 'Madrid', 2),
(1, 'Which programming language is known as the "write once, run anywhere" language?', 'Python', 'C++', 'Java', 'JavaScript', 2),
(1, 'What is 2 + 2?', '3', '4', '5', '6', 1),
(1, 'Which of these is not an OOP concept?', 'Inheritance', 'Polymorphism', 'Compilation', 'Encapsulation', 2),
(1, 'What does HTML stand for?', 'Hyper Text Markup Language', 'High Tech Modern Language', 'Hyper Transfer Markup Language', 'Home Tool Markup Language', 0);
