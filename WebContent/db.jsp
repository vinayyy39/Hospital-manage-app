<%@page errorPage="error.jsp" %>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital",
        "root",
        "398654");
Statement st=con.createStatement();
%>