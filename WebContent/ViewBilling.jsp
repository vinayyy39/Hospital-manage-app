<%@ page import="java.sql.*"%>
<%@ include file="db.jsp"%> 
<html>
<head>   
<title>Bill Receipt</title>
</head>                                 
<body onload="window.print()">
	<center>
		<h2>Hospital Management System</h2>
		<h3>Bill Receipt</h3>
	</center>
	<hr>
	<%
		String idStr = request.getParameter("bill_id");
		if (idStr != null) {
			int id = Integer.parseInt(idStr);
			try {
				PreparedStatement ps = con.prepareStatement("SELECT * FROM billing WHERE id=?");
				ps.setInt(1, id);
				ResultSet rs = ps.executeQuery();
				if (rs.next()) {
	%>  
	<p> 
		<b>Bill ID:</b> 
		<%=rs.getInt("id")%>
	</p>
	<p> 
		<b>Patient ID:</b>
		<%=rs.getInt("patient_id")%></p>
	<p> 
		<b>Doctor ID:</b>
		<%=rs.getInt("doctor_id")%></p>
	<hr> 
	<table width="100%" border="1" cellpadding="10">
		<tr>
			<th>Service</th>
			<th>Amount </th>
		</tr>
		<tr>
			<td>Consultation Fee</td>
			<td>₹<%=rs.getDouble("consultation_fee")%></td>
		</tr>
		<tr>
			<td>Medicine Charges</td>
			<td>₹<%=rs.getDouble("medicine_fee")%></td>
		</tr>
		<tr>
			<td><b>Total Amount</b></td>
			<td><b>₹<%=rs.getDouble("total_amount")%></b></td>
		</tr>
	</table>
	<br>
	<p>
		<b>Payment Status:</b>
		<%=rs.getString("payment_status")%></p>
	<br>
	<br>
	<p>
		<b>Authorized Signature</b>
	</p>
	<%
		} else {
					out.println("<h3>No Record Found!</h3>");
				}
			} catch (Exception e) {
				out.println("Error: " + e);
			}
		} else {
			out.println("<h3>Invalid Access! No ID Found.</h3>");
		}
	%>
</body>
</html>