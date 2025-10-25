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

INSERT INTO quizzes (title, description) VALUES ('Java Quiz', 'Advanced Java Questions');

INSERT INTO questions (quiz_id, question_text, option_a, option_b, option_c, option_d, correct_answer) VALUES
-- 1
(1, 'Which feature of Java allows programs to run on different platforms without modification?', 'Encapsulation', 'Polymorphism', 'JVM', 'Abstraction', 3),

-- 2
(1, 'Which of the following is NOT a valid state of a Java thread?', 'Runnable', 'Running', 'Blocked', 'Terminated', 2),

-- 3
(1, 'What is the main purpose of the Java Reflection API?', 'To handle exceptions', 'To inspect or modify classes, methods, and fields at runtime', 'To manage memory allocation', 'To secure the application', 2),

-- 4
(1, 'Which interface is used in Java for implementing lambda expressions?', 'Serializable', 'Runnable', 'FunctionalInterface', 'Cloneable', 3),

-- 5
(1, 'What is the purpose of the “volatile” keyword in Java?', 'To make a variable immutable', 'To prevent thread interference by ensuring visibility across threads', 'To allocate memory dynamically', 'To synchronize methods', 2),

-- 6
(1, 'Which Java feature provides the ability to dynamically load classes at runtime?', 'Reflection', 'Serialization', 'Dynamic Binding', 'ClassLoader', 4),

-- 7
(1, 'In Java Streams API, which method is used to transform elements of a stream?', 'filter()', 'map()', 'reduce()', 'collect()', 2),

-- 8
(1, 'Which collection class maintains insertion order and allows duplicate elements?', 'HashSet', 'TreeSet', 'ArrayList', 'HashMap', 3),

-- 9
(1, 'Which of the following exceptions is checked?', 'NullPointerException', 'IOException', 'ArrayIndexOutOfBoundsException', 'ArithmeticException', 2),

-- 10
(1, 'What is the purpose of the “transient” keyword in Java serialization?', 'To make variables thread-safe', 'To include the variable in serialization', 'To exclude the variable from serialization', 'To synchronize the variable', 3),

-- 11
(1, 'Which class in Java is used to create immutable objects?', 'StringBuilder', 'StringBuffer', 'String', 'CharArray', 3),

-- 12
(1, 'Which functional interface represents a function that accepts one argument and produces a result?', 'Consumer', 'Supplier', 'Predicate', 'Function', 4),

-- 13
(1, 'Which Java package contains classes for concurrent programming?', 'java.lang', 'java.util', 'java.util.concurrent', 'java.thread', 3),

-- 14
(1, 'Which Java keyword prevents a class from being inherited?', 'static', 'final', 'private', 'sealed', 2),

-- 15
(1, 'What is the advantage of using CompletableFuture over Future in Java?', 'It blocks the thread until completion', 'It allows non-blocking asynchronous computation chaining', 'It is used for synchronization', 'It is deprecated', 2),

-- 16
(1, 'Which annotation in Java marks a method that should be executed after dependency injection is done?', '@PreDestroy', '@PostConstruct', '@Autowired', '@Init', 2),

-- 17
(1, 'Which of the following statements about Java Streams is true?', 'Streams can be reused multiple times', 'Streams process data lazily', 'Streams store data', 'Streams are thread-safe by default', 2),

-- 18
(1, 'Which interface must be implemented to create a custom annotation in Java?', 'Annotation', 'Serializable', 'Cloneable', 'EventListener', 1),

-- 19
(1, 'Which of these classes allows reading and writing of objects in Java?', 'ObjectReader', 'ObjectInputStream and ObjectOutputStream', 'BufferedReader and BufferedWriter', 'Scanner', 2),

-- 20
(1, 'What is the key benefit of using the Java Module System (introduced in Java 9)?', 'Improved GUI support', 'Enhanced security and encapsulation between modules', 'Backward compatibility', 'Dynamic memory allocation', 2);

