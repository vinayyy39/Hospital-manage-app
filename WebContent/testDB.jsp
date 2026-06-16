<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head><title>DB Test</title></head>
<body>
    <h2>Environment Variables</h2>
    <p>DB_URL: <%= System.getenv("DB_URL") %></p>
    <p>DB_USER: <%= System.getenv("DB_USER") %></p>
    <p>DB_PASSWORD: <%= System.getenv("DB_PASSWORD") != null ? "****** (Set)" : "null" %></p>
    
    <h2>Connection Test</h2>
    <%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        out.println("<p>Driver Loaded Successfully!</p>");
        
        String url = hospital.Cridentials.mysqlurl;
        String user = hospital.Cridentials.user;
        String pass = hospital.Cridentials.rootPassword;
        
        out.println("<p>Attempting connection to: " + url + " with user: " + user + "</p>");
        
        Connection con = DriverManager.getConnection(url, user, pass);
        if(con != null) {
            out.println("<h3 style='color:green'>Connection Successful!</h3>");
            con.close();
        } else {
            out.println("<h3 style='color:red'>Connection returned null!</h3>");
        }
    } catch(Exception e) {
        out.println("<h3 style='color:red'>Exception: " + e.getMessage() + "</h3>");
        out.println("<pre>");
        e.printStackTrace(new java.io.PrintWriter(out));
        out.println("</pre>");
    }
    %>
</body>
</html>
