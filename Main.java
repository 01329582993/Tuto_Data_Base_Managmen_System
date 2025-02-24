import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public  class JDBCTest {
    public static void main(String[] args) {
        // Database connection details
        String url = "jdbc:oracle:thin:@localhost:1521:xe"; // Update if needed
        String username = "your_username"; // Change to your actual username
        String password = "your_password"; // Change to your actual password

        // JDBC connection test
        try {
            // Load Oracle JDBC Driver
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // Establish connection
            Connection con = DriverManager.getConnection(url, username, password);

            // Success message
            System.out.println("✅ Connected to the database successfully!");

            // Close connection
            con.close();
        } catch (ClassNotFoundException e) {
            System.out.println("❌ JDBC Driver not found! Check your classpath.");
        } catch (SQLException e) {
            System.out.println("❌ Connection failed! Check database details.");
            e.printStackTrace();
        }
    }
}
