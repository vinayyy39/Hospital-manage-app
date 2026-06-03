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
    <title>Doctor List - Hospital Management</title> 
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
        .btn-book {
            display: inline-block;
            padding: 8px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-book:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }
        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
            flex-wrap: wrap;
        }
        .btn {
            padding: 12px 30px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s ease;
            display: inline-block;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .btn-secondary {
            background: #f1f1f1;
            color: #333;
        }
        .btn-secondary:hover {
            background: #e0e0e0;
            transform: translateY(-2px);
        }
        .btn-logout {
            background: #ff4757;
            color: white;
        }
        .btn-logout:hover {
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
        .badge {
            display: inline-block;
            padding: 4px 12px;
            background: #e8f5e9;
            color: #2e7d32;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2> Doctor List</h2>
            <p>All registered doctors in the hospital system</p>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Specialization</th>
                        <th>Phone</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    try {
                        PreparedStatement ps = con.prepareStatement("SELECT * FROM doctor");
                        ResultSet rs = ps.executeQuery();
                        boolean hasData = false;
                        
                        while(rs.next()) {
                            hasData = true;
                    %>
                    <tr>
                        <td><strong>#<%= rs.getInt("id") %></strong></td>
                        <td><%= rs.getString("name") %></td>
                        <td><span class="badge"><%= rs.getString("specialization") %></span></td>
                        <td><%= rs.getLong("phone") %></td>
                        <td>
                            <a href="AddAppoint.jsp?doctor_id=<%= rs.getInt("id") %>" class="btn-book">📅 Book Appointment</a>
                        </td>
                    </tr>
                    <%
                        }
                        if(!hasData) {
                    %>
                    <tr>
                        <td colspan="5" class="no-data">
                            No doctors registered yet. Add a new doctor to get started.
                        </td>
                    </tr>
                    <%
                        }
                        rs.close();
                        ps.close();
                    } catch(Exception e) {
                        out.println("<tr><td colspan='5' class='no-data'>Error: " + e.getMessage() + "</td></tr>");
                    }
                    %>
                </tbody>
            </table>
            <div class="action-buttons">
                <a href="ViewAppoint.jsp" class="btn btn-primary"> View Appointments</a>
                <a href="DoctorHome.jsp" class="btn btn-secondary"> Dashboard</a>
                <a href="index.html" class="btn btn-logout"> Logout</a>
            </div>
        </div>
    </div>
</body>
</html>
