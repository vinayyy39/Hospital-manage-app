<%@ page import="java.sql.*"%>
<%@ include file="db.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medicine List — MediCore HMS</title>
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
            padding: 40px 20px;
        }

        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
            flex-wrap: wrap;
            gap: 16px;
        }

        .page-title {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            font-weight: 600;
            color: var(--teal);
        }

        .page-actions {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 10px 20px;
            background: var(--teal);
            color: white;
            border: none;
            border-radius: var(--radius-sm);
            font-weight: 500;
            font-size: 14px;
            cursor: pointer;
            transition: var(--transition);
            text-decoration: none;
            white-space: nowrap;
        }

        .btn:hover {
            background: var(--teal-hover);
            transform: translateY(-1px);
            box-shadow: var(--shadow);
        }

        .btn-secondary {
            background: var(--blue);
        }

        .btn-secondary:hover {
            background: #144d8a;
        }

        .btn-outline {
            background: transparent;
            border: 1px solid var(--border);
            color: var(--text-dark);
        }

        .btn-outline:hover {
            background: var(--bg);
            border-color: var(--teal);
            color: var(--teal);
        }

        .card {
            background: var(--white);
            border-radius: var(--radius);
            border: 1px solid var(--border);
            box-shadow: var(--shadow);
            overflow: hidden;
        }

        .table-container {
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }

        thead {
            background: var(--teal);
            color: white;
        }

        th {
            text-align: left;
            padding: 16px 20px;
            font-weight: 600;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            white-space: nowrap;
        }

        td {
            padding: 14px 20px;
            border-bottom: 1px solid var(--border);
            color: var(--text-dark);
        }

        tbody tr {
            transition: var(--transition);
        }

        tbody tr:hover {
            background: var(--teal-light);
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        .price-cell {
            font-weight: 600;
            color: var(--teal);
        }

        .qty-cell {
            font-weight: 500;
        }

        .qty-low {
            color: var(--red);
            font-weight: 600;
        }

        .empty-state {
            text-align: center;
            padding: 40px 20px;
            color: var(--text-muted);
        }

        .empty-state p {
            font-size: 16px;
            margin-bottom: 20px;
        }

        .stats-bar {
            display: flex;
            gap: 20px;
            padding: 16px 20px;
            background: var(--bg);
            border-bottom: 1px solid var(--border);
            font-size: 13px;
            color: var(--text-muted);
            flex-wrap: wrap;
        }

        .stat-item {
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .stat-value {
            font-weight: 600;
            color: var(--text-dark);
        }

        .search-box {
            margin-bottom: 20px;
        }

        .search-box input {
            width: 100%;
            max-width: 320px;
            padding: 10px 16px;
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            font-size: 14px;
            transition: var(--transition);
        }

        .search-box input:focus {
            outline: none;
            border-color: var(--teal);
            box-shadow: 0 0 0 3px var(--teal-light);
        }

        @media (max-width: 768px) {
            .page-header {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .page-actions {
                width: 100%;
            }
            
            .btn {
                flex: 1;
                min-width: 140px;
            }
            
            th, td {
                padding: 12px 16px;
                font-size: 13px;
            }
            
            .stats-bar {
                flex-direction: column;
                gap: 8px;
            }
        }

        @media (max-width: 480px) {
            body {
                padding: 20px 12px;
            }
            
            .card {
                border-radius: var(--radius-sm);
            }
            
            th, td {
                padding: 10px 12px;
                font-size: 12px;
            }
            
            .page-title {
                font-size: 22px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="page-header">
            <h1 class="page-title">Medicine Inventory</h1>
            <div class="page-actions">
                <a href="AddMedical.jsp" class="btn">Add Medicine</a>
                <a href="AddBilling.jsp" class="btn btn-secondary">Create Bill</a>
                <a href="PatientHome.jsp" class="btn btn-outline">Dashboard</a>
            </div>
        </div>

        <div class="search-box">
            <input type="text" id="searchInput" placeholder="Search medicines..." 
                   onkeyup="filterTable()">
        </div>

        <div class="card">
            <%
                int totalMedicines = 0;
                double totalValue = 0;
                int lowStock = 0;
            %>
            
            <div class="stats-bar">
                <div class="stat-item">
                    <span>Total Items:</span>
                    <span class="stat-value" id="totalCount"><%= totalMedicines %></span>
                </div>
                <div class="stat-item">
                    <span>Inventory Value:</span>
                    <span class="stat-value"><span id="totalValue"><%= String.format("%.2f", totalValue) %></span></span>
                </div>
                <div class="stat-item">
                    <span>Low Stock:</span>
                    <span class="stat-value" id="lowStockCount" style="color: var(--red);"><%= lowStock %></span>
                </div>
            </div>

            <div class="table-container">
                <table id="medicineTable">
                    <thead>
                        <tr>
                            <th>Medicine Name</th>
                            <th>Company</th>
                            <th>Price</th>
                            <th>Quantity</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                ResultSet rs = st.executeQuery("SELECT * FROM medical");
                                boolean hasRecords = false;
                                
                                while (rs.next()) {
                                    hasRecords = true;
                                    totalMedicines++;
                                    
                                    String name = rs.getString("medicine_name");
                                    String company = rs.getString("company");
                                    double price = rs.getDouble("price");
                                    int qty = rs.getInt("quantity");
                                    
                                    totalValue += (price * qty);
                                    if (qty <= 10) lowStock++;
                                    
                                    String qtyClass = (qty <= 10) ? "qty-low" : "qty-cell";
                        %>
                        <tr>
                            <td><strong><%= name %></strong></td>
                            <td><%= company %></td>
                            <td class="price-cell"><%= String.format("%.2f", price) %></td>
                            <td class="<%= qtyClass %>"><%= qty %></td>
                        </tr>
                        <%
                                }
                                
                                if (!hasRecords) {
                        %>
                        <tr>
                            <td colspan="4">
                                <div class="empty-state">
                                    <p>No medicines found in inventory</p>
                                    <a href="AddMedical.jsp" class="btn">Add Your First Medicine</a>
                                </div>
                            </td>
                        </tr>
                        <%
                                }
                            } catch(Exception e) {
                        %>
                        <tr>
                            <td colspan="4" style="color: var(--red); text-align: center; padding: 20px;">
                                Error loading medicines: <%= e.getMessage() %>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const rows = document.querySelectorAll('#medicineTable tbody tr:not(:has(.empty-state))');
            let count = 0, value = 0, low = 0;
            
            rows.forEach(row => {
                const cells = row.querySelectorAll('td');
                if (cells.length === 4) {
                    count++;
                    const price = parseFloat(cells[2].textContent) || 0;
                    const qty = parseInt(cells[3].textContent) || 0;
                    value += price * qty;
                    if (qty <= 10) low++;
                }
            });
            
            document.getElementById('totalCount').textContent = count;
            document.getElementById('totalValue').textContent = value.toFixed(2);
            document.getElementById('lowStockCount').textContent = low;
        });

        function filterTable() {
            const input = document.getElementById('searchInput');
            const filter = input.value.toLowerCase();
            const table = document.getElementById('medicineTable');
            const rows = table.getElementsByTagName('tr');
            
            for (let i = 1; i < rows.length; i++) {
                const cells = rows[i].getElementsByTagName('td');
                if (cells.length === 4) {
                    const name = cells[0].textContent.toLowerCase();
                    const company = cells[1].textContent.toLowerCase();
                    
                    if (name.includes(filter) || company.includes(filter)) {
                        rows[i].style.display = '';
                    } else {
                        rows[i].style.display = 'none';
                    }
                }
            }
        }
    </script>
</body>
</html>