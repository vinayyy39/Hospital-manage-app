<%@ page import="java.sql.*"%>


<%
	try {
		String id = request.getParameter("id");
		if (id != null && !id.isEmpty()) {

			int ig = Integer.parseInt(id);
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/adv430","root","398654");
			String sql = "DELETE FROM patient WHERE id=?";
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setInt(1, ig);

			int i = ps.executeUpdate();

			if (i > 0) 
			{
				out.println("<h3>" + i + " patient deleted successfully</h3>");
			} else 
			{
				out.println("<h3>No patient found with this ID</h3>");
			}
			ps.close();
			con.close();
		}else 
		{
			out.println("<h3>Invalid ID</h3>");
		}
	} catch (Exception e) {
		out.println("<h3>Error: " + e.getMessage() + "</h3>");
	}
%>

<br>
<a href="Show.jsp">Go Back</a>


