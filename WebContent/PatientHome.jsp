<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="db.jsp"%>

<%
	String patientEmail = (String) session.getAttribute("id");
	if (patientEmail == null) {
		response.sendRedirect("index.html");
		return;
	}

	String name = "", gender = "", phoneNo = "", address = "", email = "";
	int age = 0;
	int patientIdFromDB = 0;

	try {
		String qr = "SELECT * FROM patient WHERE email = ?";
		PreparedStatement ps = con.prepareStatement(qr);
		ps.setString(1, patientEmail);
		ResultSet rs = ps.executeQuery();

		if (rs.next()) {
			patientIdFromDB = rs.getInt("id");
			name = rs.getString("name");
			gender = rs.getString("gender");
			age = rs.getInt("age");
			phoneNo = rs.getString("phone");
			address = rs.getString("address");
			email = rs.getString("email");

			// Store in session for other pages
			session.setAttribute("patient_id", patientIdFromDB);
			session.setAttribute("patient_name", name);
			session.setAttribute("patient_email", patientEmail);
		}
		rs.close();
		ps.close();
	} catch (Exception e) {
		out.println("<p style='color:red'>Error loading patient data: " + e.getMessage() + "</p>");
	}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Patient Dashboard - MediCore HMS</title>
<link
	href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'DM Sans', sans-serif;
	background: #f5f7fb;
	display: flex;
}

.sidebar {
	width: 240px;
	min-height: 100vh;
	background: #083b2f;
	color: white;
	position: fixed;
	left: 0;
	top: 0;
}

.sidebar-logo {
	padding: 28px 22px;
	font-size: 30px;
	font-weight: 700;
	border-bottom: 1px solid rgba(255, 255, 255, 0.08);
}

.sidebar-user {
	padding: 22px;
}

.sidebar-user b {
	font-size: 18px;
}

.sidebar-user small {
	color: rgba(255, 255, 255, 0.7);
}

.nav-item {
	display: block;
	padding: 15px 22px;
	color: rgba(255, 255, 255, 0.82);
	text-decoration: none;
	transition: 0.2s;
}

.nav-item:hover {
	background: rgba(255, 255, 255, 0.08);
	color: white;
}

.main {
	margin-left: 240px;
	width: 100%;
	padding: 35px;
}

.dashboard-card {
	background: white;
	border-radius: 18px;
	padding: 30px;
	margin-bottom: 28px;
	border: 1px solid #e2e8f0;
	box-shadow: 0 5px 18px rgba(0, 0, 0, 0.05);
}

.dashboard-card h3 {
	color: #22c55e;
	margin-bottom: 22px;
	font-size: 24px;
}

.patient-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 25px;
	margin-bottom: 18px;
}

.doctor-card {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 24px;
	border: 2px solid #22c55e;
	border-radius: 14px;
	margin-bottom: 22px;
	background: #f8fff9;
}

.doctor-left h4 {
	font-size: 22px;
	margin-bottom: 10px;
	color: #166534;
}

.doctor-left p {
	margin: 7px 0;
	color: #374151;
	font-size: 15px;
}

.book-btn {
	background: #22c55e;
	color: white;
	text-decoration: none;
	padding: 13px 24px;
	border-radius: 10px;
	font-weight: 600;
}

.book-btn:hover {
	background: #15803d;
}
</style>
</head>
<body>

	<!-- SIDEBAR -->
	<aside class="sidebar">
		<div class="sidebar-logo">MediCore HMS</div>
		<div class="sidebar-user">
			<b><%=name.isEmpty() ? patientEmail : name%></b><br> <small>Patient
				Panel</small>
		</div>
		<a href="PatientHome.jsp" class="nav-item">Dashboard</a> <a
			href="Show.jsp" class="nav-item">Patient Records</a> <a
			href="doctor.html" class="nav-item">Doctors</a> <a href="index.html"
			class="nav-item">Logout</a>
	</aside>

	<!-- MAIN CONTENT -->
	<main class="main">
	<div class="topbar-title">
		Welcome,
		<%=name%></div>

	<!-- Patient Information -->
	<div class="dashboard-card">
		<h3>Patient Information</h3>
		<div class="patient-grid">
			<div>
				<p>
					<b>ID:</b>
					<%=patientIdFromDB%></p>
				<p>
					<b>Name:</b>
					<%=name%></p>
				<p>
					<b>Age:</b>
					<%=age%></p>
			</div>
			<div>
				<p>
					<b>Gender:</b>
					<%=gender%></p>
				<p>
					<b>Phone:</b>
					<%=phoneNo%></p>
				<p>
					<b>Email:</b>
					<%=email%></p>
			</div>
		</div>
		<p>
			<b>Address:</b>
			<%=address%></p>
	</div>

	<!-- Available Doctors -->
	<div class="dashboard-card">
		<h3>Available Doctors</h3>
		<%
			try {
				String qr2 = "SELECT * FROM doctor";
				PreparedStatement ps2 = con.prepareStatement(qr2);
				ResultSet rs2 = ps2.executeQuery();

				while (rs2.next()) {
		%>
		<div class="doctor-card">
			<div class="doctor-left">
				<h4><%=rs2.getString("name")%></h4>
				<p>
					<b>Specialization:</b>
					<%=rs2.getString("specialization")%></p>
				<p>
					<b>Phone:</b>
					<%=rs2.getString("phone")%></p>
				<p>
					<b>Email:</b>
					<%=rs2.getString("email")%></p>
			</div>
			<div>
				<a href="AddAppoint.jsp?doctor=<%=rs2.getInt("id")%>"
					class="book-btn"> Book Appointment </a>
			</div>
		</div>
		<%
			}
				rs2.close();
				ps2.close();
			} catch (Exception e) {
				out.println("<p style='color:red'>Error loading doctors: " + e.getMessage() + "</p>");
			}
		%>
	</div>
	</main>
</body>
</html>