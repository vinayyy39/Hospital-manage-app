package hospital;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        // Load the MySQL Driver
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            Class.forName("com.mysql.jdbc.Driver");
        }
        
        String dbUrl = System.getenv("DB_URL");
        String dbUser = System.getenv("DB_USER");
        String dbPassword = System.getenv("DB_PASSWORD");
        
        // Render or other platforms might set MYSQLURL or MYSQL_URL
        if (dbUrl == null || dbUrl.isEmpty()) {
            dbUrl = System.getenv("MYSQLURL");
        }
        if (dbUrl == null || dbUrl.isEmpty()) {
            dbUrl = System.getenv("MYSQL_URL");
        }
        
        // Fallback to Cridentials if env vars are empty
        if (dbUrl == null || dbUrl.isEmpty()) {
            dbUrl = Cridentials.mysqlurl;
            dbPassword = Cridentials.rootPassword;
            dbUser = "root"; // Railway default user is root
        }
        
        // If still empty, use local fallback
        if (dbUrl == null || dbUrl.isEmpty()) {
            dbUrl = "jdbc:mysql://localhost:3306/adv430";
            dbUser = "root";
            dbPassword = "398654";
        }
        
        // Parse mysql:// protocol format (like mysql://user:pass@host:port/database)
        if (dbUrl.startsWith("mysql://")) {
            try {
                String cleanUrl = dbUrl.substring(8);
                int atSign = cleanUrl.indexOf("@");
                if (atSign != -1) {
                    String credentials = cleanUrl.substring(0, atSign);
                    String hostDb = cleanUrl.substring(atSign + 1);
                    int colon = credentials.indexOf(":");
                    if (colon != -1) {
                        dbUser = credentials.substring(0, colon);
                        dbPassword = credentials.substring(colon + 1);
                    }
                    dbUrl = "jdbc:mysql://" + hostDb;
                } else {
                    dbUrl = "jdbc:mysql://" + cleanUrl;
                }
            } catch (Exception e) {
                // ignore and try to connect with raw URL
            }
        }
        
        // Ensure the URL is prefixed with jdbc:
        if (!dbUrl.startsWith("jdbc:")) {
            dbUrl = "jdbc:" + dbUrl;
        }
        
        if (dbUser != null && !dbUser.isEmpty()) {
            return DriverManager.getConnection(dbUrl, dbUser, dbPassword);
        } else {
            return DriverManager.getConnection(dbUrl);
        }
    }
}
