<%@ page import="java.sql.*" %>
<%
String name = request.getParameter("name");
String specialization = request.getParameter("specialization");
String phoneStr = request.getParameter("phone");
String email = request.getParameter("email");
String pwd = request.getParameter("pwd");
boolean success = false;
String errorMsg = null;
try {
    long phone = Long.parseLong(phoneStr);
    Class.forName("com.mysql.jdbc.Driver");

    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/adv430",
            "root",
            "398654");
    String sql = "INSERT INTO doctor(name, specialization, phone, email, pwd) VALUES(?,?,?,?,?)";
    PreparedStatement ps = con.prepareStatement(sql);
    ps.setString(1, name);
    ps.setString(2, specialization);
    ps.setLong(3, phone);
    ps.setString(4, email);
    ps.setString(5, pwd);
    int i = ps.executeUpdate();
    if(i > 0){
        success = true;
    }
    ps.close();
    con.close();
} catch(Exception e){
    errorMsg = e.getMessage();
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>MediCore HMS - Doctor Registration</title> 
<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'DM Sans',sans-serif;
}
body{
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background:linear-gradient(135deg,#0F766E,#115E59);
} 
.card{
    background:white;
    width:420px;
    padding:40px;
    border-radius:18px;
    text-align:center;
    box-shadow:0 20px 60px rgba(0,0,0,0.3);
}
.icon{
    width:70px;
    height:70px;
    margin:0 auto 15px;
    border-radius:50%;
    display:flex;
    justify-content:center;
    align-items:center;
    font-size:30px;
    color:white;4
}
.success .icon{
    background:#0F766E;
}
.error .icon{
    background:#ef4444;
}
h1{
    margin-bottom:10px;
}
.success h1{
    color:#0F766E;
}
.error h1{
    color:#ef4444;
}
p{
    color:#666;
    margin-bottom:20px;
    font-size:14px;
}
a{
    display:inline-block;
    padding:10px 18px;
    background:#0F766E;
    color:white;
    text-decoration:none;
    border-radius:8px;
    margin:5px;
}
a:hover{
    background:#115E59;
}
</style>
</head>
<body>
<% if(success){ %>
<div class="card success">
    <div class="icon"></div>
    <h1>Success</h1>
    <p>Doctor Registered Successfully in MediCore HMS</p>
    <a href="DoctorRegister.jsp">Add Another</a>
    <a href="doctor.html">Login</a>
</div>
<% } else { %>
<div class="card error">
    <div class="icon"></div>
    <h1>Failed</h1>
    <p><%= (errorMsg != null ? errorMsg : "Registration Failed") %></p>
    <a href="DoctorRegister.jsp">Try Again</a>
</div>
<% } %>
</body>
</html>