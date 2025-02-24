import java.sql.*;

class jdbc_practice {
    public static void main(String args[]) {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
-- 2(a)
            Connection con = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:xe", "DBMS", "dbms");

            Statement stmt = con.createStatement();

        --(b)  
            System.out.println("Counting accounts...");
            String query1 = "SELECT COUNT(*) FROM ACCOUNT";
            ResultSet rs1 = stmt.executeQuery(query1);
            if (rs1.next()) {
                System.out.println("Total accounts: " + rs1.getInt(1));
            }
            rs1.close();

    --(c)
            System.out.println("Finding high transaction accounts...");
            String query2 = "SELECT A_ID FROM TRANSACTIONS WHERE DTM >= ADD_MONTHS(SYSDATE, -1) " +
                            "GROUP BY A_ID HAVING SUM(AMOUNT) >= 10000";
            ResultSet rs2 = stmt.executeQuery(query2);
            while (rs2.next()) {
                System.out.println("A_ID: " + rs2.getInt("A_ID"));
            }
            rs2.close();

    --(d)
            System.out.println("Finding the date with most transactions...");
            String avgQuery = "SELECT AVG(AMOUNT) FROM TRANSACTIONS";
            ResultSet avgRs = stmt.executeQuery(avgQuery);
            avgRs.next();
            double avgAmount = avgRs.getDouble(1);
            avgRs.close();

            String query3 = "SELECT DTM, COUNT(*) AS count FROM TRANSACTIONS WHERE AMOUNT > " + avgAmount +
                            " GROUP BY DTM ORDER BY count DESC FETCH FIRST 1 ROWS ONLY";
            ResultSet rs3 = stmt.executeQuery(query3);
            if (rs3.next()) {
                System.out.println("Date with most high transactions: " + rs3.getDate("DTM"));
            }
            rs3.close();

        --3
            System.out.println("Inserting transactions...");
            String insertQuery = "INSERT INTO TRANSACTIONS (T_ID, DTM, A_ID, AMOUNT, TYPE) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pstmt = con.prepareStatement(insertQuery);
            pstmt.setInt(1, 101);
            pstmt.setDate(2, Date.valueOf("2025-02-01"));
            pstmt.setInt(3, 1);
            pstmt.setDouble(4, 5000);
            pstmt.setInt(5, 0);
            pstmt.addBatch();
            
            pstmt.setInt(1, 102);
            pstmt.setDate(2, Date.valueOf("2025-02-02"));
            pstmt.setInt(3, 2);
            pstmt.setDouble(4, 7000);
            pstmt.setInt(5, 1);
            pstmt.addBatch();
            
            pstmt.executeBatch();
            System.out.println("Inserted two transactions.");
            pstmt.close();

    --5
            System.out.println("Deleting tables...");
            stmt.executeUpdate("DROP TABLE TRANSACTIONS");
            stmt.executeUpdate("DROP TABLE ACCOUNT");
            con.commit();
            System.out.println("Tables deleted successfully.");




            con.close();

        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
