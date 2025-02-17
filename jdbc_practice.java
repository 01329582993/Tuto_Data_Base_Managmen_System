import java.sql.*;

class jdbc_practice {
    public static void main(String args[]) {

                // Database connection details
                String url = "jdbc:oracle:thin:@localhost:1521:xe"; // Modify if needed
                String username = "220041158"; // Replace with your Oracle DB username
                String password = "Limllo625"; // Replace with your Oracle DB password

                // JDBC objects
                Connection con = null;
                PreparedStatement pstmt = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    // Step 1: Load the Oracle JDBC driver
                    Class.forName("oracle.jdbc.driver.OracleDriver");

                    // Step 2: Establish database connection
                    con = DriverManager.getConnection(url, username, password);
                    System.out.println("Connected to the database.");

                    String query = "SELECT TRANSACTION_ID, ACCOUNT_ID, AMOUNT, TYPE FROM TRANSACTIONS";  // No DTM
                    stmt = con.createStatement();
                    rs = stmt.executeQuery(query);

                    System.out.println("\nTransactions Data:");
                    while (rs.next()) {
                        int transactionId = rs.getInt("TRANSACTION_ID");  // Correct column name
                        int accountId = rs.getInt("ACCOUNT_ID");
                        double amount = rs.getDouble("AMOUNT");
                        int type = rs.getInt("TYPE");

                        System.out.printf("Transaction ID: %d, Account ID: %d, Amount: %.2f, Type: %d\n",
                                transactionId, accountId, amount, type);
                    }


                    // Step 4: Count account types
                    String countQuery = "SELECT A_ID, SUM(AMOUNT) AS total_transactions FROM TRANSACTIONS GROUP BY A_ID";
                    rs = stmt.executeQuery(countQuery);

                    int totalAccounts = 0, CIP = 0, VIP = 0, OP = 0, NotCategorized = 0;
                    while (rs.next()) {
                        totalAccounts++;
                        int accountId = rs.getInt("A_ID");
                        double totalTransactions = rs.getDouble("total_transactions");

                        // Fetch current account balance
                        String balanceQuery = "SELECT SUM(CASE WHEN TYPE = 0 THEN AMOUNT ELSE -AMOUNT END) AS balance " +
                                "FROM TRANSACTIONS WHERE A_ID = ?";
                        pstmt = con.prepareStatement(balanceQuery);
                        pstmt.setInt(1, accountId);
                        ResultSet balanceRs = pstmt.executeQuery();

                        double balance = 0;
                        if (balanceRs.next()) {
                            balance = balanceRs.getDouble("balance");
                        }
                        balanceRs.close();

                        // Categorizing accounts
                        if (balance > 1000000 && totalTransactions > 5000000) {
                            CIP++;
                        } else if (balance > 500000 && balance < 900000 && totalTransactions > 2500000 && totalTransactions < 4500000) {
                            VIP++;
                        } else if (balance < 100000 && totalTransactions < 1000000) {
                            OP++;
                        } else {
                            NotCategorized++;
                        }
                    }

                    // Print account type counts
                    System.out.println("\nAccount Type Counts:");
                    System.out.printf("Total Accounts: %d\nCIP: %d\nVIP: %d\nOP: %d\nNot Categorized: %d\n",
                            totalAccounts, CIP, VIP, OP, NotCategorized);

                    // Step 5: Insert two records using a single PreparedStatement
                    String insertQuery = "INSERT INTO TRANSACTIONS (A_ID, T_ID, DTM, AMOUNT, TYPE) VALUES (?, ?, ?, ?, ?)";
                    pstmt = con.prepareStatement(insertQuery);

                    // First record
                    pstmt.setInt(1, 105);
                    pstmt.setInt(2, 201);
                    pstmt.setDate(3, Date.valueOf("2025-02-17"));
                    pstmt.setDouble(4, 10000);
                    pstmt.setInt(5, 0);
                    pstmt.addBatch();

                    // Second record
                    pstmt.setInt(1, 106);
                    pstmt.setInt(2, 202);
                    pstmt.setDate(3, Date.valueOf("2025-02-17"));
                    pstmt.setDouble(4, 5000);
                    pstmt.setInt(5, 1);
                    pstmt.addBatch();

                    // Execute batch insert
                    pstmt.executeBatch();
                    System.out.println("\nInserted two records into TRANSACTIONS table.");

                    // Step 6: Print metadata (columns & data types)
                    DatabaseMetaData metaData = con.getMetaData();

                    // Print column details for ACCOUNT table
                    System.out.println("\nACCOUNT Table Metadata:");
                    rs = metaData.getColumns(null, null, "ACCOUNT", null);
                    while (rs.next()) {
                        System.out.printf("Column: %s, Type: %s\n", rs.getString("COLUMN_NAME"), rs.getString("TYPE_NAME"));
                    }

                    // Print column details for TRANSACTIONS table
                    System.out.println("\nTRANSACTIONS Table Metadata:");
                    rs = metaData.getColumns(null, null, "TRANSACTIONS", null);
                    while (rs.next()) {
                        System.out.printf("Column: %s, Type: %s\n", rs.getString("COLUMN_NAME"), rs.getString("TYPE_NAME"));
                    }

                    // Close all resources
                    rs.close();
                    stmt.close();
                    pstmt.close();
                    con.close();
                    System.out.println("\nDatabase connection closed.");

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
