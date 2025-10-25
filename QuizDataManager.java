import java.sql.*;
import java.util.*;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class QuizDataManager {
    private static String DB_URL;
    private static String DB_USER;
    private static String DB_PASSWORD;

    static {
        loadDatabaseConfig();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found: " + e.getMessage());
        }
    }

    private static void loadDatabaseConfig() {
        Properties props = new Properties();
        try (FileInputStream fis = new FileInputStream("config.properties")) {
            props.load(fis);
            DB_URL = props.getProperty("db.url");
            DB_USER = props.getProperty("db.username");
            DB_PASSWORD = props.getProperty("db.password");
        } catch (IOException e) {
            System.err.println("Error loading database configuration: " + e.getMessage());
            // Fallback to default values for development
            DB_URL = "jdbc:mysql://localhost:3306/quiz_app";
            DB_USER = "root";
            DB_PASSWORD = "";
        }
    }

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found: " + e.getMessage());
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    public static List<Question> loadQuestions(int quizId) {
        List<Question> questions = new ArrayList<>();
        String sql = "SELECT question_text, option_a, option_b, option_c, option_d, correct_answer FROM questions WHERE quiz_id = ? ORDER BY RAND()";

        try (Connection conn = getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, quizId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String questionText = rs.getString("question_text");
                String[] options = {
                    rs.getString("option_a"),
                    rs.getString("option_b"),
                    rs.getString("option_c"),
                    rs.getString("option_d")
                };
                int correctAnswer = rs.getInt("correct_answer");
                if (correctAnswer < 0 || correctAnswer >= options.length) {
                    correctAnswer = 0; 
                }
                questions.add(new Question(questionText, options, correctAnswer));
            }
        } catch (SQLException e) {
            System.err.println("Error loading questions: " + e.getMessage());
        }
        return questions;
    }

    public static User authenticateUser(String username, String password) {
        String sql = "SELECT id, username FROM users WHERE username = ? AND password = ?";
        try (Connection conn = getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new User(rs.getInt("id"), rs.getString("username"), password);
            }
        } catch (SQLException e) {
            System.err.println("Error authenticating user: " + e.getMessage());
        }
        return null;
    }

    public static void saveQuizResult(int userId, int quizId, int score, int totalQuestions, int timeTaken) {
        String sql = "INSERT INTO quiz_results (user_id, quiz_id, score, total_questions, time_taken) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, quizId);
            stmt.setInt(3, score);
            stmt.setInt(4, totalQuestions);
            stmt.setInt(5, timeTaken);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error saving quiz result: " + e.getMessage());
        }
    }

    public static List<String> getQuizReports() {
        List<String> reports = new ArrayList<>();
        String sql = "SELECT u.username, q.title, qr.score, qr.total_questions, qr.time_taken, qr.completed_at " +
                "FROM quiz_results qr " +
                "JOIN users u ON qr.user_id = u.id " +
                "JOIN quizzes q ON qr.quiz_id = q.id " +
                "ORDER BY qr.completed_at DESC";

        try (Connection conn = getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                String report = String.format("User: %s, Quiz: %s, Score: %d/%d, Time: %d sec, Date: %s",
                        rs.getString("username"),
                        rs.getString("title"),
                        rs.getInt("score"),
                        rs.getInt("total_questions"),
                        rs.getInt("time_taken"),
                        rs.getTimestamp("completed_at"));
                reports.add(report);
            }
        } catch (SQLException e) {
            System.err.println("Error generating reports: " + e.getMessage());
        }
        return reports;
    }

    // For backward compatibility, load from quiz 1
    public static List<Question> loadQuestions() {
        return loadQuestions(1);
    }
}
