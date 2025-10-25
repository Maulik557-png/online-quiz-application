import java.io.*;
import java.util.List;

public class QuizReports {
    public static void main(String[] args) {
        List<String> reports = QuizDataManager.getQuizReports();

        try (PrintWriter writer = new PrintWriter(new FileWriter("quiz_reports.txt"))) {
            writer.println("Quiz Reports");
            writer.println("============");
            writer.println();

            for (String report : reports) {
                writer.println(report);
                writer.println("----------------------------------------");
            }

            System.out.println("Quiz reports generated: quiz_reports.txt");
        } catch (IOException e) {
            System.err.println("Error generating reports: " + e.getMessage());
        }
    }
}
