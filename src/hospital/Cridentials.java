package hospital;

public class Cridentials {
    public static String mysqlurl = System.getenv("DB_URL") != null ? System.getenv("DB_URL") : "jdbc:mysql://localhost:3306/adv430";
    public static String user = System.getenv("DB_USER") != null ? System.getenv("DB_USER") : "root";
    public static String rootPassword = System.getenv("DB_PASSWORD") != null ? System.getenv("DB_PASSWORD") : "398654";
}