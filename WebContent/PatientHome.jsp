<%
	String id = (String) session.getAttribute("id");
	if (id == null) {
		response.sendRedirect("admin.html");
		return;
	}  
%>  
<!DOCTYPE html> 
<html lang="en">
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
<title>Dashboard MediCore HMS</title>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
<style> 
:root {
	--teal: #0F6E56;
	--teal-light: #E1F5EE;
	--blue: #185FA5;
	--blue-light: #E6F1FB;
	--red: #E24B4A;
	--red-light: #FCEBEB;                                                           
	--text-dark: #1a2332;
	--text-muted: #64748b;
	--border: #e2e8f0;
	--white: #ffffff;
	--bg: #f8fbff;
	--sidebar-w: 260px;
} 
* { 
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}
body {
	font-family: 'DM Sans', sans-serif;
	background: var(--bg);
	display: flex;
} 
.sidebar {
	width: var(--sidebar-w);
	background: #0a3d2d;
	min-height: 100vh;
	position: fixed;
	left: 0;
	top: 0;
	color: white;
} 
.sidebar-logo {
	padding: 25px;
	font-size: 20px;
	font-weight: bold;
}
.sidebar-user {
	padding: 15px;
	border-top: 1px solid rgba(255, 255, 255, 0.1);
}
.nav-item {
	display: block;
	padding: 12px 20px;
	color: rgba(255, 255, 255, 0.7);
	text-decoration: none;
}
.nav-item:hover {
	background: rgba(255, 255, 255, 0.1);
	color: white;
}
.main {
	margin-left: var(--sidebar-w);
	padding: 30px;
	width: 100%;
}
.topbar {
	display: flex;
	justify-content: space-between;
	margin-bottom: 30px;
}
.topbar-title {
	font-size: 26px;
	font-weight: 600;
}
.stats-grid {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 15px;
}
.stat-card {
	background: white;
	padding: 20px;
	border-radius: 10px;
	border: 1px solid var(--border);
}
.stat-val {
	font-size: 28px;
	font-weight: bold;
	margin-top: 10px;
} 
.actions-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 15px;
	margin-top: 30px;
} 
.action-card {
	background: white;
	padding: 20px;
	border-radius: 10px;
	border: 1px solid var(--border);
	text-decoration: none;
	color: black;
	transition: 0.3s;
}  
.action-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
}
.info-row {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 15px;
	margin-top: 30px;
}
.info-card {
	background: white;
	padding: 20px;
	border-radius: 10px;
	border: 1px solid var(--border);  
}
</style>
</head>
<body>
	<aside class="sidebar">
		<div class="sidebar-logo">MediCore</div>
		<div class="sidebar-user">
			<b><%=id%></b><br> <small>Admin</small>
		</div>
		<a href="PatientHome.jsp" class="nav-item">Dashboard</a>
		<a href="addpat.html" class="nav-item">Add Patient</a>
		<a href="Show.jsp" class="nav-item">All Patients</a>
		<a href="delpat.html" class="nav-item">Delete Patient</a>
		<a href="index.html" class="nav-item">Logout</a>
	</aside> 
	<main class="main">
		<div class="topbar">
			<div class="topbar-title">Welcome, <%=id%></div>
		</div>  
		<div class="actions-grid">
			<a href="addpat.html" class="action-card">Add Patient</a>
			<a href="Show.jsp" class="action-card">View Patients</a>
			<a href="delpat.html" class="action-card">Delete Patient</a>
		</div>
		<div class="info-row">
			<div class="info-card">
				<h3>System Info</h3>   
				<p>User: <%=id%></p>
				<p>Status: Online</p>
			</div> 
			<div class="info-card">
				<h3>Quick Links</h3>
				<p><a href="Show.jsp">Patient Records</a></p>
				<p><a href="addpat.html">Add Patient</a></p>
				<p><a href="doctor.html">Doctor Panel</a></p>
			</div>
		</div>
	</main> 
</body> 
</html>