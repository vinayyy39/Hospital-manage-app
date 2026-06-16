<%@ page import="java.sql.*" %>

<%
String id = request.getParameter("id");
String name = request.getParameter("name");
String age = request.getParameter("age");
String gender = request.getParameter("gender");
String ph = request.getParameter("phone").trim();
long phone = Long.parseLong(ph);
String address = request.getParameter("address");
String doctor_id = request.getParameter("doctor_id");
String email = request.getParameter("email");
String pwd = request.getParameter("password");

try
{
	Connection con = hospital.DBConnection.getConnection();

    PreparedStatement ps = con.prepareStatement(
        "insert into patient values(?,?,?,?,?,?,?,?,?)"
    );

    ps.setInt(1, Integer.parseInt(id));
    ps.setString(2, name);
    ps.setInt(3, Integer.parseInt(age));
    ps.setString(4, gender);
    ps.setLong(5, phone);
    ps.setString(6, address);
    ps.setInt(7, Integer.parseInt(doctor_id));
    ps.setString(8, email);
    ps.setString(9, pwd);

    int x = ps.executeUpdate();

    if(x > 0)
    {
        out.println("<script>");
        out.println("alert('Patient Registration Successful');");
        out.println("window.location='admin.html';");
        out.println("</script>");
    }
    else
    {
        out.println("<script>");
        out.println("alert('Registration Failed');");
        out.println("window.location='Register.jsp';");
        out.println("</script>");
    }

    con.close();
}
catch(Exception e)
{
    out.println(e);
}
%>