<%@ page import="java.sql.*"%>
<%@ include file="db.jsp"%>

<%
if(session.getAttribute("admin")==null){
    response.sendRedirect("login.jsp");
}
%>

<html>
<head>
<title>Dashboard</title>

<style>
body {
    font-family: Arial;
    background-color: #f4f6f8;
    text-align: center;
}

.card {
    display: inline-block;
    background: white;
    padding: 20px;
    margin: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    width: 200px;
}

a {
    text-decoration: none;
    display: block;
    margin: 10px;
    color: blue;
}
</style>

</head>
<body>

<h2>Welcome Admin</h2>

<%
int total = 0;

try {
    PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM patient");
    ResultSet rs = ps.executeQuery();

    if(rs.next()){
        total = rs.getInt(1);
    }

    rs.close();
    ps.close();
} catch(Exception e){
    out.println(e);
}
%>

<div class="card">
    <h3>Total Patients</h3>
    <h1><%=total%></h1>
</div>

<br>

<a href="Show.jsp">View Patients</a>
<a href="add.jsp"> Add Patient</a>
<a href="logout.jsp">🚪Logout</a>

</body>
</html>