<%@page errorPage="error.jsp" %>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%

Connection con = hospital.DBConnection.getConnection();

Statement st = null;
if (con != null) {
    st = con.createStatement();
} else {
    throw new Exception("DATABASE CONNECTION FAILED: You must configure a Cloud Database! Please set DB_URL, DB_USER, and DB_PASSWORD environment variables in your Render dashboard.");
}
%>