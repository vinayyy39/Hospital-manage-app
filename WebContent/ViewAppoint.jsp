<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="db.jsp"%>
<%
    String userId = (String) session.getAttribute("id");
    if(userId == null) {
        response.sendRedirect("doctor.html");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head> 
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Appointments - Hospital Management</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 40px 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .header {
            background: white;
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            animation: fadeInDown 0.6s ease-out;
        }

        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }       
            .header h2 {
            color: #333;
            font-size: 28px;
            margin-bottom: 10px;
        }

        .header p {
            color: #666;
            font-size: 14px;
        }

        .table-container {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            overflow-x: auto;
            animation: fadeInUp 0.6s ease-out 0.2s both;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        thead th {
            color: white;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
        }

        thead th:first-child {
            border-top-left-radius: 10px;
        }

        thead th:last-child {
            border-top-right-radius: 10px;
        }

        tbody tr {
            border-bottom: 1px solid #f0f0f0;
            transition: all 0.3s ease;
        }

        tbody tr:hover {
            background: #f8f9ff;
            transform: scale(1.01);
        }

        tbody td {
            padding: 15px;
            color: #333;
            font-size: 14px;
        }

        .status-badge {
            display: inline-block;
            padding: 5px 15px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-booked {
            background: #d4edda;
            color: #155724;
        }

        .status-completed {
            background: #cce5ff;
            color: #004085;
        }

        .status-cancelled {
            background: #f8d7da;
            color: #721c24;
        }

        .action-links {
            display: flex;
            gap: 15px;
            margin-top: 30px;
            flex-wrap: wrap;
        }

        .link-btn {
            padding: 12px 30px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s ease;
            display: inline-block;
        }

        .link-btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .link-btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .link-btn-secondary {
            background: #f1f1f1;
            color: #333;
        }

        .link-btn-secondary:hover {
            background: #e0e0e0;
            transform: translateY(-2px);
        }

        .link-btn-logout {
            background: #ff4757;
            color: white;
        }

        .link-btn-logout:hover {
            background: #ff3838;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 71, 87, 0.3);
        }

        .no-data {
            text-align: center;
            padding: 40px;
            color: #666;
            font-size: 16px;
        }

        .id-badge {
            display: inline-block;
            padding: 4px 10px;
            background: #e3f2fd;
            color: #1976d2;
            border-radius: 8px;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>📋 All Appointments</h2>
            <p>Complete list of scheduled appointments</p>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Patient ID</th>
                        <th>Doctor ID</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    try {
                        PreparedStatement ps = con.prepareStatement("SELECT * FROM appointments ORDER BY appointment_date DESC, appointment_time DESC");
                        ResultSet rs = ps.executeQuery();
                        boolean hasData = false;

                        while(rs.next()) {
                            hasData = true;
                            String status = rs.getString("status");
                            String statusClass = "status-booked";
                            
                            if(status != null) {
                                if(status.equalsIgnoreCase("Completed")) {
                                    statusClass = "status-completed";
                                } else if(status.equalsIgnoreCase("Cancelled")) {
                                    statusClass = "status-cancelled";
                                }
                            }
                    %>
                    <tr>
                        <td><span class="id-badge">#<%= rs.getInt("id") %></span></td>
                        <td><strong>P-<%= rs.getInt("patient_id") %></strong></td>
                        <td><strong>D-<%= rs.getInt("doctor_id") %></strong></td>
                        <td><%= rs.getString("appointment_date") %></td>
                        <td><%= rs.getString("appointment_time") %></td>
                        <td><span class="status-badge <%= statusClass %>"><%= status %></span></td>
                    </tr>
                    <%
                        }
                        
                        if(!hasData) {
                    %>
                    <tr>
                        <td colspan="6" class="no-data">
                            No appointments found. Book a new appointment to get started.
                        </td>
                    </tr>
                    <%
                        }
                
                        rs.close();
                        ps.close();
                    } catch(Exception e) {
                        out.println("<tr><td colspan='6' class='no-data'>Error: " + e.getMessage() + "</td></tr>");
                    }
                    %>
                </tbody>
            </table>
            <div class="action-links">
                <a href="AddAppoint.jsp" class="link-btn link-btn-primary">➕ Add New Appointment</a>
                <a href="DoctorHome.jsp" class="link-btn link-btn-secondary">🏠 Dashboard</a>
                <a href="index.html" class="link-btn link-btn-logout">🚪 Logout</a>
            </div>
        </div>
    </div>
</body>
</html>