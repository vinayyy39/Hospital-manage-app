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
        
        // Clean and parse the input URL to extract credentials and form a valid JDBC URL
        String hostAndDb = dbUrl;
        
        // Remove prefixes
        if (hostAndDb.startsWith("jdbc:mysql://")) {
            hostAndDb = hostAndDb.substring(13);
        } else if (hostAndDb.startsWith("mysql://")) {
            hostAndDb = hostAndDb.substring(8);
        } else if (hostAndDb.startsWith("jdbc:mysql:")) {
            hostAndDb = hostAndDb.substring(11);
        } else if (hostAndDb.startsWith("jdbc:")) {
            hostAndDb = hostAndDb.substring(5);
        }
        
        // Remove leading slashes if any (like from jdbc:// or mysql://)
        while (hostAndDb.startsWith("/")) {
            hostAndDb = hostAndDb.substring(1);
        }
        
        // Split credentials if present (user:pass@host:port/db)
        int atSign = hostAndDb.indexOf("@");
        if (atSign != -1) {
            String credentials = hostAndDb.substring(0, atSign);
            hostAndDb = hostAndDb.substring(atSign + 1);
            
            int colon = credentials.indexOf(":");
            if (colon != -1) {
                dbUser = credentials.substring(0, colon);
                dbPassword = credentials.substring(colon + 1);
            } else {
                dbUser = credentials;
            }
        }
        
        // Construct clean JDBC URL
        dbUrl = "jdbc:mysql://" + hostAndDb;
        
        // Auto-append parameters to prevent SSL and public key retrieval handshake failures
        if (!dbUrl.contains("useSSL=")) {
            dbUrl += (dbUrl.contains("?") ? "&" : "?") + "useSSL=false";
        }
        if (!dbUrl.contains("allowPublicKeyRetrieval=")) {
            dbUrl += (dbUrl.contains("?") ? "&" : "?") + "allowPublicKeyRetrieval=true";
        }
        
        if (dbUser != null && !dbUser.isEmpty()) {
            return DriverManager.getConnection(dbUrl, dbUser, dbPassword);
        } else {
            return DriverManager.getConnection(dbUrl);
        }
    }
}
