<%@ page import="java.sql.*"%>
<%@ include file="db.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Medicine — MediCore HMS</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --teal: #0F6E56;
            --teal-light: #E1F5EE;
            --teal-hover: #0d5a46;
            --blue: #185FA5;
            --blue-light: #E6F1FB;
            --red: #E24B4A;
            --red-light: #FCEBEB;
            --text-dark: #1a2332;
            --text-muted: #64748b;
            --border: #e2e8f0;
            --white: #ffffff;
            --bg: #f8fbff;
            --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            --radius: 12px;
            --radius-sm: 8px;
            --transition: all 0.2s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'DM Sans', sans-serif;
            background: var(--bg);
            color: var(--text-dark);
            line-height: 1.6;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 40px 20px;
        }

        .container {
            width: 100%;
            max-width: 500px;
        }

        .page-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .page-header h1 {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            font-weight: 600;
            color: var(--teal);
            margin-bottom: 8px;
        }

        .page-header p {
            color: var(--text-muted);
            font-size: 14px;
        }

        .card {
            background: var(--white);
            border-radius: var(--radius);
            border: 1px solid var(--border);
            box-shadow: var(--shadow);
            padding: 30px;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: 500;
            margin-bottom: 8px;
            color: var(--text-dark);
            font-size: 14px;
        }

        .form-group input {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            font-size: 14px;
            font-family: inherit;
            transition: var(--transition);
            background: var(--white);
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--teal);
            box-shadow: 0 0 0 3px var(--teal-light);
        }

        .form-group input::placeholder {
            color: var(--text-muted);
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 12px 24px;
            background: var(--teal);
            color: white;
            border: none;
            border-radius: var(--radius-sm);
            font-weight: 500;
            font-size: 14px;
            cursor: pointer;
            transition: var(--transition);
            text-decoration: none;
            width: 100%;
        }           rr

        .btn:hover {
            background: var(--teal-hover);
            transform: translateY(-1px);
            box-shadow: var(--shadow);
        }

        .btn:active {
            transform: translateY(0);
        }

        .btn-secondary {
            background: var(--blue);
        }

        .btn-secondary:hover {
            background: #144d8a;
        }

        .alert {
            padding: 12px 16px;
            border-radius: var(--radius-sm);
            margin-bottom: 20px;
            font-size: 14px;
            font-weight: 500;
            text-align: center;
        }

        .alert-success {
            background: var(--teal-light);
            color: var(--teal);
            border: 1px solid var(--teal);
        }

        .alert-error {
            background: var(--red-light);
            color: var(--red);
            border: 1px solid var(--red);
        }

        .actions {
            display: flex;
            gap: 12px;
            margin-top: 10px;
        }

        .actions a {
            flex: 1;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            color: var(--text-muted);
            text-decoration: none;
            font-size: 14px;
            margin-bottom: 20px;
            transition: var(--transition);
        }

        .back-link:hover {
            color: var(--teal);
        }

        .back-link::before {
            content: "←";
            margin-right: 6px;
            font-weight: bold;
        }

        @media (max-width: 576px) {
            body {
                padding: 20px 15px;
            }
            
            .card {
                padding: 24px 20px;
            }
            
            .page-header h1 {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="PatientHome.jsp" class="back-link"> Back to Dashboard</a>
        <div class="page-header">
            <h1>Add Medicine</h1>
            <p>Enter medicine details to add to inventory</p>
        </div>

        <%
            String msg = "";
            boolean isSuccess = false;

            if (request.getParameter("submit") != null) {
                try {
                    String name = request.getParameter("medicine_name");
                    String company = request.getParameter("company");
                    double price = Double.parseDouble(request.getParameter("price"));
                    int qty = Integer.parseInt(request.getParameter("quantity"));

                    PreparedStatement ps = con.prepareStatement(
                            "INSERT INTO medical(medicine_name, company, price, quantity) VALUES(?,?,?,?)");
                    ps.setString(1, name);
                    ps.setString(2, company);
                    ps.setDouble(3, price);
                    ps.setInt(4, qty);

                    int i = ps.executeUpdate();

                    if (i > 0) {
                        msg = "✓ Medicine added successfully!";
                        isSuccess = true;
                    } else {
                        msg = "✗ Failed to add medicine. Please try again.";
                    }
                } catch (NumberFormatException e) {
                    msg = "✗ Invalid price or quantity format.";
                } catch (Exception e) {
                    msg = "✗ Error: " + e.getMessage();
                }
            }
            
            if (!msg.isEmpty()) {
                String alertClass = isSuccess ? "alert-success" : "alert-error";
        %>
                <div class="alert <%= alertClass %>"><%= msg %></div>
        <%
            }
        %>

        <div class="card">
            <form method="post">
                <div class="form-group">
                    <label for="medicine_name">Medicine Name *</label>
                    <input type="text" id="medicine_name" name="medicine_name" 
                           placeholder="e.g., Paracetamol 500mg" required 
                           value="<%= request.getParameter("medicine_name") != null ? request.getParameter("medicine_name") : "" %>">
                </div>

                <div class="form-group">
                    <label for="company">Company *</label>
                    <input type="text" id="company" name="company" 
                           placeholder="e.g., Pfizer, GSK" required
                           value="<%= request.getParameter("company") != null ? request.getParameter("company") : "" %>">
                </div>

                <div class="form-group">
                    <label for="price">Price (₹) *</label>
                    <input type="number" id="price" name="price" 
                           step="0.01" min="0.01" placeholder="0.00" required
                           value="<%= request.getParameter("price") != null ? request.getParameter("price") : "" %>">
                </div>

                <div class="form-group">
                    <label for="quantity">Quantity *</label>
                    <input type="number" id="quantity" name="quantity" 
                           min="1" placeholder="Number of units" required
                           value="<%= request.getParameter("quantity") != null ? request.getParameter("quantity") : "" %>">
                </div>

                <button type="submit" name="submit" class="btn">Add Medicine</button>
            </form>
        </div>

        <div class="actions">
            <a href="ViewMedicines.jsp" class="btn btn-secondary">View All Medicines</a>
        </div>
    </div>
</body>
</html>