<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="db.jsp"%>

<%
	String patientEmail = (String) session.getAttribute("id");
	Integer patientId = (Integer) session.getAttribute("patient_id");
	String patientName = (String) session.getAttribute("patient_name");

	if (patientEmail == null || patientId == null) {
		response.sendRedirect("index.html"); 
		return;
	}

	String doctorParam = request.getParameter("doctor");
	String msg = "";
	String doctorName = "";
	if (doctorParam != null) {
		try {
			PreparedStatement psDoc = con.prepareStatement("SELECT name FROM doctor WHERE id = ?");
			psDoc.setInt(1, Integer.parseInt(doctorParam));
			ResultSet rsDoc = psDoc.executeQuery();
			if (rsDoc.next()) {
				doctorName = rsDoc.getString("name");
			}
			rsDoc.close();
			psDoc.close();
		} catch (Exception e) {
			doctorName = "Doctor ID: " + doctorParam;
		}
	}
	if (request.getParameter("submit") != null) {
		try {
			int doc_id = Integer.parseInt(request.getParameter("doctor_id"));
			String app_date = request.getParameter("date");
			String app_time = request.getParameter("time");

			PreparedStatement ps = con.prepareStatement(
					"INSERT INTO appointments(patient_id, doctor_id, appointment_date, appointment_time, status) "
							+ "VALUES(?, ?, ?, ?, ?)");

			ps.setInt(1, patientId);
			ps.setInt(2, doc_id);
			ps.setString(3, app_date);
			ps.setString(4, app_time);
			ps.setString(5, "Booked");

			int i = ps.executeUpdate();
			msg = (i > 0) ? "success" : "error";
			ps.close();
		} catch (Exception e) {
			msg = "error";
			e.printStackTrace();
		}
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Book Appointment - MediCore HMS</title>
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
	min-height: 100vh;
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

.nav-item {
	display: block;
	padding: 15px 22px;
	color: rgba(255, 255, 255, 0.82);
	text-decoration: none;
}

.nav-item:hover {
	background: rgba(255, 255, 255, 0.1);
	color: white;
}

.main {
	margin-left: 240px;
	padding: 40px;
	width: 100%;
}

.card {
	background: white;
	border-radius: 18px;
	padding: 35px;
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.06);
	max-width: 650px;
}
h1 {
	font-size: 36px;
	margin-bottom: 10px;
	color: #111827;
}

h3 {
	color: #22c55e;
	margin-bottom: 25px;
}

.success-message {
	background: #dcfce7;
	color: #166534;
	padding: 14px;
	border-radius: 10px;
	margin-bottom: 20px;
}

.error-message {
	background: #fee2e2;
	color: #991b1b;
	padding: 14px;
	border-radius: 10px;
	margin-bottom: 20px;
}

.form-group {
	margin-bottom: 22px;
}

label {
	display: block;
	margin-bottom: 8px;
	font-weight: 600;
	color: #374151;
}

input {
	width: 100%;
	height: 52px;
	border: 1px solid #d1d5db;
	border-radius: 10px;
	padding: 0 16px;
	font-size: 16px;
}

input:focus {
	outline: none;
	border-color: #22c55e;
	box-shadow: 0 0 0 4px rgba(34, 197, 94, 0.15);
}

.btn {
	background: #22c55e;
	color: white;
	border: none;
	padding: 14px 28px;
	border-radius: 10px;
	font-size: 16px;
	font-weight: 600;
	cursor: pointer;
	margin-right: 12px;
}

.btn:hover {
	background: #15803d;
}

.btn-secondary {
	background: #6b7280;
}
</style>
</head>
<body>

	<!-- Sidebar -->
	<aside class="sidebar">
		<div class="sidebar-logo">MediCore HMS</div>
		<div class="sidebar-user">
			<b><%=patientName != null ? patientName : patientEmail%></b><br>
			<small>Appointment Panel</small>
		</div>
		<a href="PatientHome.jsp" class="nav-item">Dashboard</a> <a
			href="ViewAppoint.jsp" class="nav-item">My Appointments</a> <a
			href="doctor.html" class="nav-item">Doctors</a> <a href="index.html"
			class="nav-item">Logout</a>
	</aside>

	<!-- Main Content -->
	<main class="main">
	<h1>Book Appointment</h1>

	<div class="card">
		<h3>Schedule New Appointment</h3>

		<%
			if ("success".equals(msg)) {
		%>
		<div class="success-message">✅ Appointment Booked Successfully!</div>
		<%
			} else if ("error".equals(msg)) {
		%>
		<div class="error-message">❌ Booking Failed! Please try again.</div>
		<%
			}
		%>

		<form method="post">
			<div class="form-group">
				<label>Patient ID</label> <input type="number" name="patient_id"
					value="<%=patientId%>" readonly>
			</div>

			<div class="form-group">
				<label>Doctor</label> <input type="text"
					value="<%=doctorName.isEmpty() ? "Doctor ID: " + doctorParam : doctorName%>"
					readonly> <input type="hidden" name="doctor_id"
					value="<%=doctorParam != null ? doctorParam : ""%>">
			</div>

			<div class="form-group">
				<label>Appointment Date</label> <input type="date" name="date"
					required>
			</div>

			<div class="form-group">
				<label>Appointment Time</label> <input type="time" name="time"
					required>
			</div>

			<button type="submit" name="submit" class="btn">Book
				Appointment</button>
		</form>

		<div style="margin-top: 30px;">
			<a href="ViewAppoint.jsp" class="btn">View Appointments</a> <a
				href="PatientHome.jsp" class="btn btn-secondary">Back to
				Dashboard</a>
		</div>
	</div>
	</main>

</body>
</html>