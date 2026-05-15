<%@ page import="java.sql.*"%>

<%
	String email = request.getParameter("id");
	String pwd = request.getParameter("pwd");

	boolean valid = false;
	String doctorName = "";

	try {
		// Load MySQL Driver
		Class.forName("com.mysql.jdbc.Driver");

		// Database Connection
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/adv430", "root", "398654");

		// SQL Query
		PreparedStatement ps = con.prepareStatement("SELECT * FROM doctor WHERE email=? AND pwd=?");

		ps.setString(1, email);
		ps.setString(2, pwd);

		ResultSet rs = ps.executeQuery();

		if (rs.next()) {
			valid = true;

			doctorName = rs.getString("name");

			// Create Session
			session.setAttribute("doctorEmail", email);
			session.setAttribute("doctorName", doctorName);

			response.sendRedirect("DoctorHome.jsp");
		} else {
			out.println("<h3 style='color:red;text-align:center;'>Invalid Email or Password</h3>");
		}

		con.close();
	} catch (Exception e) {
		out.println(e);
	}
%>