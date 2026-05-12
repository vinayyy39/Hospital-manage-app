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
    <title>Medicine Billing - Hospital Management</title>
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
            max-width: 800px;
            margin: 0 auto;
        }

        .form-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            animation: slideIn 0.5s ease-out;
            margin-bottom: 30px;
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

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 600;
            font-size: 14px;
        }

        .form-group select,
        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 15px;
            transition: all 0.3s ease;
        }

        .form-group select:focus,
        .form-group input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .btn-primary {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .receipt-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            animation: fadeIn 0.6s ease-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        .receipt-header {
            background: linear-gradient(135deg, #10ac84 0%, #1dd1a1 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }

        .receipt-header h2 {
            font-size: 24px;
            margin-bottom: 5px;
        }

        .receipt-header p {
            font-size: 13px;
            opacity: 0.9;
        }

        .receipt-body {
            padding: 30px;
        }

        .receipt-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .receipt-table tr {
            border-bottom: 1px solid #f0f0f0;
        }

        .receipt-table th {
            text-align: left;
            padding: 12px 15px;
            background: #f8f9fa;
            color: #666;
            font-weight: 600;
            font-size: 13px;
        }

        .receipt-table td {
            padding: 12px 15px;
            color: #333;
            font-size: 14px;
        }

        .total-row {
            background: #f8f9ff;
        }

        .total-row td {
            font-weight: 700;
            font-size: 18px;
            color: #667eea;
        }

        .btn-container {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        .btn {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            text-align: center;
            display: inline-block;
        }

        .btn-print {
            background: #10ac84;
            color: white;
        }

        .btn-print:hover {
            background: #0e9670;
            transform: translateY(-2px);
        }

        .btn-back {
            background: #f1f1f1;
            color: #333;
        }

        .btn-back:hover {
            background: #e0e0e0;
            transform: translateY(-2px);
        }

        @media print {
            body {
                background: white;
                padding: 0;
            }
            .form-container,
            .btn-container {
                display: none;
            }
            .receipt-container {
                box-shadow: none;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <%
            String msg = "";
            int medicine_id = 0;
            String medName = "";
            double price = 0;
            int qty = 0;
            double total = 0;
            
            if (request.getParameter("submit") != null) {
                medicine_id = Integer.parseInt(request.getParameter("medicine_id"));
                qty = Integer.parseInt(request.getParameter("quantity"));
                
                try {
                    PreparedStatement ps1 = con.prepareStatement("SELECT medicine_name, price, quantity FROM medical WHERE medicine_id=?");
                    ps1.setInt(1, medicine_id);
                    ResultSet rs = ps1.executeQuery();
                    
                    if (rs.next()) {
                        medName = rs.getString("medicine_name");
                        price = rs.getDouble("price");
                        int stock = rs.getInt("quantity");
                        
                        if (qty <= stock) {
                            total = price * qty;
                            
                            PreparedStatement ps2 = con.prepareStatement("INSERT INTO medical_billing(medicine_id, quantity, price, total) VALUES(?,?,?,?)");
                            ps2.setInt(1, medicine_id);
                            ps2.setInt(2, qty);
                            ps2.setDouble(3, price);
                            ps2.setDouble(4, total);
                            int i = ps2.executeUpdate();
                            
                            if(i > 0) {
                                PreparedStatement ps3 = con.prepareStatement("UPDATE medical SET quantity = quantity - ? WHERE medicine_id=?");
                                ps3.setInt(1, qty);
                                ps3.setInt(2, medicine_id);
                                ps3.executeUpdate();
                                msg = "success";
                            }
                        } else {
                            msg = "Not enough stock! Available: " + stock;
                        }
                    }
                } catch (Exception e) {
                    msg = "Error: " + e.getMessage();
                }
            }
        %>

        <% if (!msg.equals("success")) { %>
        <div class="form-container">
            <div class="form-header">
                <div class="icon">💊</div>
                <h2>Medicine Billing</h2>
                <p>Generate bill for medicine purchase</p>
            </div>
            <div class="form-body">
                <% if (!msg.isEmpty() && !msg.equals("")) { %>
                    <div class="error-message">
                        ❌ <%= msg %>
                    </div>
                <% } %>

                <form method="post">
                    <div class="form-group">
                        <label for="medicine_id">Select Medicine</label>
                        <select name="medicine_id" id="medicine_id" required>
                            <option value="">-- Choose Medicine --</option>
                            <%
                                try {
                                    ResultSet rs = st.executeQuery("SELECT * FROM medical");
                                    while (rs.next()) {
                            %>
                            <option value="<%= rs.getInt("medicine_id") %>">
                                <%= rs.getString("medicine_name") %> (₹<%= rs.getDouble("price") %>) - Stock: <%= rs.getInt("quantity") %>
                            </option>
                            <%
                                    }
                                } catch (Exception e) {
                                    out.println(e);
                                }
                            %>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="quantity">Quantity</label>
                        <input type="number" id="quantity" name="quantity" min="1" required placeholder="Enter quantity">
                    </div>
                    <button type="submit" name="submit" class="btn-primary">Generate Bill</button>
                </form>
            </div>
        </div>
        <% } %>

        <% if (msg.equals("success")) { %>
        <div class="receipt-container">
            <div class="receipt-header">
                <div class="icon">✅</div>
                <h2>Bill Receipt</h2>
                <p>Transaction completed successfully</p>
            </div>
            <div class="receipt-body">
                <table class="receipt-table">
                    <tr>
                        <th>Date & Time</th>
                        <td><%= new java.util.Date() %></td>
                    </tr>
                    <tr>
                        <th>Medicine ID</th>
                        <td>#<%= medicine_id %></td>
                    </tr>
                    <tr>
                        <th>Medicine Name</th>
                        <td><strong><%= medName %></strong></td>
                    </tr>
                    <tr>
                        <th>Price per Unit</th>
                        <td>₹<%= String.format("%.2f", price) %></td>
                    </tr>
                    <tr>
                        <th>Quantity</th>
                        <td><%= qty %></td>
                    </tr>
                    <tr class="total-row">
                        <th>Total Amount</th>
                        <td>₹<%= String.format("%.2f", total) %></td>
                    </tr>
                </table>

                <div class="btn-container">
                    <button onclick="window.print()" class="btn btn-print">🖨️ Print Receipt</button>
                    <a href="ViewMedicine.jsp" class="btn btn-back">📋 Back to Medicines</a>
                </div>
            </div>
        </div>
        <% } else { %>
        <div style="text-align: center; margin-top: 20px;">
            <a href="ViewMedicine.jsp" class="btn btn-back" style="display: inline-block; padding: 12px 30px;">📋 Back to Medicines</a>
        </div>
        <% } %>
    </div>
</body>
</html>
