# Online Quiz Application

This is a Java Swing-based online quiz application that uses MySQL for data storage.

## Features

- User authentication (login system)
- Randomized questions per user
- Quiz timer (30 seconds per question)
- Scoring and result display with correct answers
- Result storage in database
- Quiz reports generation

## Setup Instructions

1. **Database Setup:**
   - Install MySQL server
   - Run the `db_schema.sql` script to create the database and tables
   - Update the database credentials in `QuizDataManager.java` (DB_PASSWORD)

2. **Dependencies:**
   - Download MySQL Connector/J JAR file (mysql-connector-java-8.0.33.jar is included)
   - Ensure it's in the classpath when compiling and running

3. **Compilation:**
   ```
   javac -cp "mysql-connector-java-8.0.33.jar" *.java
   ```

4. **Running the Application:**
   ```
   java -cp ".;mysql-connector-java-8.0.33.jar" QuizSystem
   ```

5. **Generating Reports:**
   ```
   java -cp ".;mysql-connector-java-8.0.33.jar" QuizReports
   ```

## Files

- `QuizSystem.java`: Main application GUI
- `QuizDataManager.java`: Database operations
- `User.java`: User model
- `Question.java`: Question model
- `QuizReports.java`: Report generator
- `db_schema.sql`: Database schema
- `mysql-connector-java-8.0.33.jar`: MySQL JDBC driver

## Screenshots

Screenshots of the login dialog, quiz interface, and results screen can be taken by running the application and capturing the windows manually.
