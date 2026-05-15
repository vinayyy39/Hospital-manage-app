<%@page import="java.sql.*"%>


<%
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");

	try{
	Class.forName("com.mysql.jdbc.Driver");

	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/adv430", "root", "398654");

	String qr = "SELECT * FROM patient WHERE email=? AND pwd=?";

	PreparedStatement ps = con.prepareStatement(qr);

	ps.setString(1, id);
	ps.setString(2, pwd);

	ResultSet rs = ps.executeQuery();
	

	if (rs.next()) {
		session.setAttribute("id", id);
	
%>

<jsp:forward page="PatientHome.jsp"></jsp:forward>

<%
	} else {
		out.println("Invalid ID and Password");
	}

	con.close();
	}catch(Exception ex)
	{
		ex.printStackTrace();
	}
%>