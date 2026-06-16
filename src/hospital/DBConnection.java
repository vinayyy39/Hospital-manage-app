package hospital;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

	public static Connection getConnection() {
	    try {
	        Class.forName("com.mysql.cj.jdbc.Driver");

	        return DriverManager.getConnection(
	            Cridentials.mysqlurl,
	            Cridentials.user,
	            Cridentials.rootPassword
	        );

	    } catch (Exception e) {
	        e.printStackTrace();
	        return null;
	    }
	}
 
