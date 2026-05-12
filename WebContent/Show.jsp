<%@ page import="java.sql.*"%>
<%@ include file="db.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Patient Records — MediCore HMS</title> 
<link
	href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600&family=DM+Sans:wght@300;400;500;600&display=swap"
	rel="stylesheet"> 
<style> 
:root {
	--teal: #0F6E56;
	--teal-light: #E1F5EE;
	--teal-mid: #1D9E75;
	--blue: #185FA5;
	--blue-light: #E6F1FB;
	--red: #A32D2D;
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
	min-height: 100vh;
	display: flex;
} 

.sidebar {
	width: var(--sidebar-w);
	background: #0a3d2d;
	min-height: 100vh;
	position: fixed;
	left: 0;
	top: 0;
	display: flex;
	flex-direction: column;
	z-index: 50;
}

.sidebar-logo {
	padding: 28px 24px 24px;
	border-bottom: 1px solid rgba(255, 255, 255, 0.08);
	display: flex;
	align-items: center;
	gap: 12px;
}
 
.logo-mark {
	width: 36px;
	height: 36px;
	background: rgba(255, 255, 255, 0.15);
	border-radius: 10px;
	display: flex;
	align-items: center;
	justify-content: center;
	border: 1px solid rgba(255, 255, 255, 0.2);
	flex-shrink: 0;
}

.sidebar-logo-text {
	font-family: 'Playfair Display', serif;
	font-size: 19px;
	font-weight: 600;
	color: white;
}

.sidebar-logo-text span 
{
	color: #5DCAA5;
}

.sidebar-nav {
	flex: 1;
	padding: 20px 12px;
}

.nav-section-label { 
	font-size: 10px;
	font-weight: 600;
	letter-spacing: 1.5px;
	text-transform: uppercase;
	color: rgba(255, 255, 255, 0.3);
	padding: 8px 12px;
	margin-bottom: 4px;
}

.nav-item {
	display: flex;
	align-items: center;
	gap: 12px;
	padding: 10px 12px;
	border-radius: 10px;
	text-decoration: none;
	font-size: 14px;
	color: rgba(255, 255, 255, 0.6);
	transition: all 0.2s;
	margin-bottom: 2px;
}

.nav-item:hover, .nav-item.active {
	background: rgba(255, 255, 255, 0.1);
	color: white;
}

.nav-item.active {
	background: rgba(93, 202, 165, 0.15);
	color: #5DCAA5;
} 

.nav-item svg 
{
	width: 18px;
	height: 18px;
	flex-shrink: 0;
}

.sidebar-bottom {
	padding: 16px 12px 24px;
	border-top: 1px solid rgba(255, 255, 255, 0.08);
}

.btn-logout {
	display: flex;
	align-items: center;
	gap: 10px;
	padding: 10px 12px;
	border-radius: 10px;
	text-decoration: none;
	font-size: 14px;
	color: rgba(255, 255, 255, 0.5);
	transition: all 0.2s;
	width: 100%;
}
.btn-logout:hover 
{
	background: rgba(226, 75, 74, 0.15);
	color: #F09595;
}
.btn-logout svg 
{
	width: 18px;
	height: 18px;
}
.main {
	margin-left: var(--sidebar-w);
	flex: 1;
	padding: 36px 40px;
}
.topbar {
	display: flex;
	align-items: flex-start;
	justify-content: space-between;
	margin-bottom: 28px;
}
.page-title {
	font-family: 'Playfair Display', serif;
	font-size: 26px;
	font-weight: 600;
	color: var(--text-dark);
	letter-spacing: -0.4px;
}
.page-sub {
	font-size: 14px;
	color: var(--text-muted);
	margin-top: 3px;
	font-weight: 300;
}

.btn-add {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	height: 42px;
	padding: 0 20px;
	background: var(--teal);
	color: white;
	border-radius: 10px;
	text-decoration: none;
	font-size: 14px;
	font-weight: 500;
	transition: all 0.2s;
}

.btn-add:hover {
	background: #085041;
	transform: translateY(-1px);
	box-shadow: 0 6px 18px rgba(15, 110, 86, 0.25);
}

.btn-add svg {
	width: 16px;
	height: 16px;
}

.summary-bar {
	display: flex;
	gap: 16px;
	margin-bottom: 24px;
}
 
.sum-card {
	background: var(--white);
	border: 1px solid var(--border);
	border-radius: 14px;
	padding: 16px 22px;
	display: flex;
	align-items: center;
	gap: 14px;
}

.sum-icon {
	width: 40px;
	height: 40px;
	border-radius: 10px;
	display: flex;
	align-items: center;
	justify-content: center;
}

.sum-icon svg {
	width: 18px;
	height: 18px;
}

.sum-label {
	font-size: 12px;
	color: var(--text-muted);
}

.sum-val 
{
	font-family: 'Playfair Display', serif;
	font-size: 22px;
	font-weight: 600;
	color: var(--text-dark);
}
.search-card {
	background: var(--white);
	border: 1px solid var(--border);
	border-radius: 16px;
	padding: 20px 24px;
	margin-bottom: 20px;
	display: flex;
	align-items: center;
	gap: 12px;
}
.search-label {
	font-size: 13px;
	font-weight: 500;
	color: var(--text-muted);
	white-space: nowrap;
}
.search-select {
	height: 40px;
	border: 1.5px solid var(--border);
	border-radius: 9px;
	padding: 0 12px;
	font-size: 14px;
	font-family: 'DM Sans', sans-serif;
	color: var(--text-dark);
	background: var(--bg);
	outline: none;
	appearance: none;
	cursor: pointer;
	padding-right: 28px;
	min-width: 130px;
	background-image:
		url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%2364748b' stroke-width='2'%3E%3Cpath d='M6 9l6 6 6-6'/%3E%3C/svg%3E");
	background-repeat: no-repeat;
	background-position: right 10px center;
}
.search-input-wrap {
	position: relative;
	flex: 1;
}
.search-icon {
	position: absolute;
	left: 12px;
	top: 50%;
	transform: translateY(-50%);
	color: #94a3b8;
}

.search-icon svg {
	width: 15px;
	height: 15px;
	display: block;
}

.search-input {
	width: 100%;
	height: 40px;
	border: 1.5px solid var(--border);
	border-radius: 9px;
	padding: 0 14px 0 36px;
	font-size: 14px;
	font-family: 'DM Sans', sans-serif;
	color: var(--text-dark);
	background: var(--bg);
	outline: none;
	transition: all 0.2s;
}

.search-input:focus {
	border-color: var(--teal);
	background: white;
	box-shadow: 0 0 0 3px rgba(15, 110, 86, 0.08);
}

.search-input::placeholder {
	color: #b0bec5;
}

.btn-search {
	height: 40px;
	padding: 0 20px;
	background: var(--teal);
	color: white;
	border: none;
	border-radius: 9px;
	font-size: 14px;
	font-weight: 500;
	font-family: 'DM Sans', sans-serif;
	cursor: pointer;
	transition: all 0.2s;
	white-space: nowrap;
}

.btn-search:hover {
	background: #085041;
}


.table-card {
	background: var(--white);
	border: 1px solid var(--border);
	border-radius: 16px;
	overflow: hidden;
}
 
.table-header {
	padding: 16px 24px;
	border-bottom: 1px solid var(--border);
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.table-title {
	font-size: 14px;
	font-weight: 600;
	color: var(--text-dark);
}

table {
	width: 100%;
	border-collapse: collapse;
}

thead th {
	padding: 12px 16px;
	font-size: 11px;
	font-weight: 600;
	letter-spacing: 0.8px;
	text-transform: uppercase;
	color: var(--text-muted);
	background: #f8fafc;
	text-align: left;
	border-bottom: 1px solid var(--border);
	white-space: nowrap;
}

tbody tr {
	border-bottom: 1px solid #f1f5f9;
	transition: background 0.15s;
}

tbody tr:last-child {
	border-bottom: none;
}

tbody tr:hover {
	background: #f8fffe;
}

td {
	padding: 14px 16px;
	font-size: 14px;
	color: var(--text-dark);
	vertical-align: middle;
}

.patient-name {
	font-weight: 500;
	display: flex;
	align-items: center;
	gap: 10px;
}

.avatar {
	width: 32px;
	height: 32px;
	border-radius: 8px;
	background: var(--teal-light);
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 12px;
	font-weight: 600;
	color: var(--teal);
	flex-shrink: 0;
}

.badge {
	display: inline-block;
	padding: 3px 10px;
	border-radius: 20px;
	font-size: 12px;
	font-weight: 500;
}

.badge-male {
	background: var(--blue-light);
	color: var(--blue);
}

.badge-female {
	background: #FBEAF0;
	color: #993556;
}

.badge-other {
	background: #EEEDFE;
	color: #534AB7;
}

.td-muted {
	color: var(--text-muted);
	font-size: 13px;
}

.btn-delete {
	display: inline-flex;
	align-items: center;
	gap: 5px;
	padding: 5px 12px;
	background: var(--red-light);
	color: var(--red);
	border-radius: 7px;
	text-decoration: none;
	font-size: 12px;
	font-weight: 500;
	transition: all 0.18s;
	border: 1px solid rgba(163, 45, 45, 0.15);
}

.btn-delete:hover {
	background: #F7C1C1;
}

.btn-delete svg {
	width: 13px;
	height: 13px;
}

.empty-row td {
	text-align: center;
	padding: 48px;
	color: var(--text-muted);
	font-size: 14px;
}

.error-message {
	background: #FFF4F4;
	border: 1px solid #FFD4D4;
	border-radius: 10px;
	padding: 16px 20px;
	margin-bottom: 20px;
	color: #A32D2D;
	font-size: 14px;
}
</style>
</head>
<body>
	<aside class="sidebar">
		<div class="sidebar-logo">
			<div class="logo-mark">
				<svg width="18" height="18" fill="none" viewBox="0 0 20 20">
        <path d="M10 2v16M2 10h16" stroke="white" stroke-width="2.5"
						stroke-linecap="round" />
      </svg>
			</div>
			<div class="sidebar-logo-text">
				Medi<span>Core</span>
			</div>
		</div>
		<nav class="sidebar-nav">
			<div class="nav-section-label">Patient Management</div>
			<a href="PatientHome.jsp" class="nav-item"> <svg fill="none"
					viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
        <rect x="3" y="3" width="7" height="7" rx="1" />
					<rect x="14" y="3" width="7" height="7" rx="1" />
        <rect x="3" y="14" width="7" height="7" rx="1" />
					<rect x="14" y="14" width="7" height="7" rx="1" />
      </svg> Dashboard
			</a> <a href="addpat.html" class="nav-item"> <svg fill="none"
					viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
        <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2" />
					<circle cx="9" cy="7" r="4" />
        <path d="M23 11h-6M20 8v6" />
      </svg> Add Patient
			</a> <a href="Show.jsp" class="nav-item active"> <svg fill="none"
					viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
        <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2" />
					<circle cx="9" cy="7" r="4" />
      </svg> All Patients
			</a> <a href="delpat.html" class="nav-item"> <svg fill="none"
					viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
        <polyline points="3 6 5 6 21 6" />
					<path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6" />
      </svg> Delete Patient
			</a>
		</nav>
		<div class="sidebar-bottom">
			<a href="index.html" class="btn-logout"> <svg fill="none"
					viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
        <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4" />
        <polyline points="16 17 21 12 16 7" />
					<line x1="21" y1="12" x2="9" y2="12" />
      </svg> Sign Out
			</a>
		</div>
	</aside>

	<main class="main">
	<div class="topbar">
		<div>
			<div class="page-title">Patient Records</div>
			<div class="page-sub">Browse and manage all registered patients</div>
		</div>
		<a href="addpat.html" class="btn-add"> <svg fill="none"
				viewBox="0 0 24 24" stroke="white" stroke-width="2.2">
        <path d="M12 5v14M5 12h14" />
      </svg> Add Patient
		</a>
	</div>
	<%
		int total = 0;
		Connection conn = null;
		PreparedStatement ps1 = null;
		ResultSet rs1 = null;
		try {
			conn = con;
			ps1 = conn.prepareStatement("SELECT COUNT(*) FROM patient");
			rs1 = ps1.executeQuery();
			if (rs1.next()) {
				total = rs1.getInt(1);
			}
		} catch (Exception e) {
			out.println("<div class='error-message'>Error loading patient count: " + e.getMessage() + "</div>");
		} finally {
			if (rs1 != null) try { rs1.close(); } catch (SQLException e) {}
			if (ps1 != null) try { ps1.close(); } catch (SQLException e) {}
		}
	%>
	<div class="summary-bar">
		<div class="sum-card">
			<div class="sum-icon" style="background: #E1F5EE;">
				<svg fill="none" viewBox="0 0 24 24" stroke="#0F6E56"
					stroke-width="1.8">
          <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2" />
					<circle cx="9" cy="7" r="4" />
        </svg>
			</div>
			<div>
				<div class="sum-label">Total Patients</div>
				<div class="sum-val"><%=total%></div>
			</div>
		</div>
	</div>
	<div class="search-card">
		<span class="search-label">Search by</span>
		<form method="get" action="Show.jsp" style="display: contents;">
			<select name="type" class="search-select">
				<option value="name" <%= "name".equals(request.getParameter("type")) ? "selected" : "" %>>Patient Name</option>
				<option value="id" <%= "id".equals(request.getParameter("type")) ? "selected" : "" %>>Patient ID</option>
			</select>
			<div class="search-input-wrap">
				<div class="search-icon">
					<svg fill="none" viewBox="0 0 15 15" stroke="currentColor"
						stroke-width="1.5">
            <circle cx="6.5" cy="6.5" r="5" />
						<path d="m10.5 10.5 3 3" />
          </svg>
				</div>
				<input type="text" name="search" class="search-input"
					placeholder="Search patients..." value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
			</div>
			<button type="submit" class="btn-search">Search</button>
		</form>
	</div>
	<div class="table-card">
		<div class="table-header">
			<div class="table-title">All Registered Patients</div>
		</div>
		<table>
			<thead>
				<tr>
					<th>ID</th>
					<th>Patient</th>
					<th>Age</th>
					<th>Gender</th>
					<th>Phone</th>
					<th>Address</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				<%
					PreparedStatement ps = null;
					ResultSet rs = null;
					try {
						String search = request.getParameter("search");
						String type = request.getParameter("type");
						
						if (search != null && !search.trim().isEmpty()) {
							if ("id".equals(type)) {
								// Validate that search is a number for ID search
								try {
									int searchId = Integer.parseInt(search.trim());
									ps = con.prepareStatement("SELECT * FROM patient WHERE id = ?");
									ps.setInt(1, searchId);
								} catch (NumberFormatException e) 
								{
									out.println("<tr class='empty-row'><td colspan='7'>Please enter a valid patient ID (numbers only).</td></tr>");
									ps = null;
								}
							} else {
								ps = con.prepareStatement("SELECT * FROM patient WHERE name LIKE ?");
								ps.setString(1, "%" + search.trim() + "%");
							}
						} else 
						{
							ps = con.prepareStatement("SELECT * FROM patient ORDER BY id DESC");
						}
						
						if (ps != null) {
							rs = ps.executeQuery();
							boolean found = false;
							while (rs.next()) {
								found = true;
								String pName = rs.getString("name");
								String initial = pName != null && pName.length() > 0 ? String.valueOf(pName.charAt(0)).toUpperCase()
										: "?";
								String gender = rs.getString("gender");
								String badgeClass = "Male".equalsIgnoreCase(gender) ? "badge-male"
										: "Female".equalsIgnoreCase(gender) ? "badge-female" : "badge-other";
								
								// Handle phone number safely
								String phoneStr = "";
								try {
									long phoneNum = rs.getLong("phone");
									phoneStr = String.valueOf(phoneNum);
								} catch (Exception e) {
									phoneStr = "N/A";
								}
				%>
				<tr>
					<td class="td-muted">#<%=rs.getInt("id")%></td>
					<td>
						<div class="patient-name">
							<div class="avatar"><%=initial%></div>
							<%=pName != null ? pName : "N/A"%>
						</div>
					</td>
					<td><%=rs.getInt("age")%> yrs</td>
					<td><span class="badge <%=badgeClass%>"><%=gender != null ? gender : "N/A"%></span></td>
					<td class="td-muted"><%=phoneStr%></td>
					<td class="td-muted"
						style="max-width: 180px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"><%=rs.getString("address") != null ? rs.getString("address") : "N/A"%></td>
					<td><a href="DeletePatient.jsp?id=<%=rs.getInt("id")%>"
						class="btn-delete"
						onclick="return confirm('Remove this patient from the system?')">
							<svg fill="none" viewBox="0 0 24 24" stroke="currentColor"
								stroke-width="2">
                <polyline points="3 6 5 6 21 6" />
								<path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6" />
              </svg> Delete
					</a></td>
				</tr>
				<%
							}
							if (!found) {
				%>
				<tr class="empty-row">
					<td colspan="7">No patients found matching your search.</td>
				</tr>
				<%
							}
						}
					} catch (Exception e) {
						out.println("<tr><td colspan='7' style='padding:24px;color:#E24B4A;'>Database error: " + e.getMessage()
								+ "</td></tr>");
					} finally {
						if (rs != null) try { rs.close(); } catch (SQLException e) {}
						if (ps != null) try { ps.close(); } catch (SQLException e) {}
						if (con != null) try { con.close(); } catch (SQLException e) {}
					}
				%>
			</tbody>
		</table>
	</div>
	</main> 
</body>
</html>
