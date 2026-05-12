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
    <title>Book Appointment - Hospital Management</title>
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
            max-width: 700px;
            margin: 0 auto;
        }
        .form-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            animation: slideIn 0.5s ease-out;
        }
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .form-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 30px;
            text-align: center;
        }
        .form-header h2 {
            font-size: 28px;
            margin-bottom: 10px;
        }
        .form-header p {
            font-size: 14px;
            opacity: 0.9;
        }
        .icon {
            width: 60px;
            height: 60px;
            margin: 0 auto 15px;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 30px;
        }
        .form-body {
            padding: 40px 30px;
        }
        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            border: 1px solid #c3e6cb;
            font-weight: 600;
            text-align: center;
            animation: fadeIn 0.5s ease-out;
        }
        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            border: 1px solid #f5c6cb;
            font-weight: 600;
            text-align: center;
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
        .form-group {
            margin-bottom: 25px;
        }
        .form-group label 
        {
            display: block;
            margin-bottom: 8px; 
            color: #333;
            font-weight: 600;
            font-size: 14px;
        }
        .form-group input 
        {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 15px;
            transition: all 0.3s ease;
        }
        .form-group input:focus 
        {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        .btn-container 
          {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            flex: 1;
            padding: 14px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            text-align: center;
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
        .action-links {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            margin-top: 30px;
        }
        .link-btn {
            padding: 12px 25px;
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
    </style>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <div class="form-header">
                <div class="icon">📅</div>
                <h2>Book Appointment</h2>
                <p>Schedule a new patient appointment</p>
            </div>
            <div class="form-body">
                <%
                    String msg = "";
                    String doctor_id = request.getParameter("doctor_id");

                    if (request.getParameter("submit") != null) {
                        int patient_id = Integer.parseInt(request.getParameter("patient_id"));
                        int doc_id = Integer.parseInt(request.getParameter("doctor_id"));
                        String date = request.getParameter("date");
                        String time = request.getParameter("time");

                        try {
                            PreparedStatement ps = con.prepareStatement(
                                "INSERT INTO appointments(patient_id, doctor_id, appointment_date, appointment_time, status) VALUES(?,?,?,?,?)");
                            
                            ps.setInt(1, patient_id);
                            ps.setInt(2, doc_id);
                            ps.setString(3, date);
                            ps.setString(4, time);
                            ps.setString(5, "Booked");
                            
                            int i = ps.executeUpdate();
                            
                            if (i > 0) {
                                msg = "success";
                            } else {
                                msg = "error";
                            }
                            ps.close();
                        } catch (Exception e) {
                            msg = "error: " + e.getMessage();
                        }
                    }
                    if (msg.equals("success")) 
                    {
                %>
                    <div class="success-message">Appointment Booked Successfully!</div>
                <%
                    }else if (!msg.isEmpty() && !msg.equals("")) {
                %>
                    <div class="error-message"> ❌ Booking Failed! Please try again.</div>
                <%
                    }
                %>
                <form method="post">
                    <div class="form-group">
                        <label for="patient_id">Patient ID</label>
                        <input type="number" id="patient_id" name="patient_id" required placeholder="Enter patient ID">
                    </div>
                    <div class="form-group">
                        <label for="doctor_id">Doctor ID</label>
                        <input type="number" id="doctor_id" name="doctor_id" value="<%= (doctor_id != null ? doctor_id : "") %>" required placeholder="Enter doctor ID">
                    </div>
                    <div class="form-group">
                        <label for="date">Appointment Date</label>
                        <input type="date" id="date" name="date" required>
                    </div>
                    <div class="form-group">
                        <label for="time">Appointment Time</label>
                        <input type="time" id="time" name="time" required>
                    </div>
                    <div class="btn-container">
                        <button type="submit" name="submit" class="btn btn-primary">Book Appointment</button>
                    </div>
                </form> 
                <div class="action-links">
                    <a href="ViewAppoint.jsp" class="link-btn link-btn-primary">📋 View Appointments</a>
                    <a href="ShowDoctor.jsp" class="link-btn link-btn-secondary">👥 Back to Doctors</a>
                    <a href="index.html" class="link-btn link-btn-logout">🚪 Logout</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
