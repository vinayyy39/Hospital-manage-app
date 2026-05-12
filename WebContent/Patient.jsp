<%@ page import="java.sql.*"%>
<%@ include file="db.jsp"%>

<%
if(session.getAttribute("admin")==null){
    response.sendRedirect("login.jsp");
}
%>

<html>
<head>
<title>Patient Management</title>

<!-- ✅ Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body class="bg-light">

<div class="container mt-4">

<h2 class="text-center mb-4">Patient Management System</h2>

<!-- 🔗 Buttons -->
<div class="mb-3 text-center">
    <a href="logout.jsp" class="btn btn-danger">Logout</a>
</div>

<!-- 🔍 Search -->
<form method="get" class="row mb-4">
    <div class="col-md-4">
        <select name="type" class="form-control">
            <option value="name">Search by Name</option>
            <option value="id">Search by ID</option>
        </select>
    </div>

    <div class="col-md-4">
        <input type="text" name="search" class="form-control" placeholder="Enter value">
    </div>

    <div class="col-md-2">
        <input type="submit" value="Search" class="btn btn-primary w-100">
    </div>
</form>

<!-- ➕ ADD PATIENT -->
<div class="card p-3 mb-4">
<h4>Add Patient</h4>

<form method="post" class="row g-2">
    <div class="col-md-3">
        <input type="text" name="name" class="form-control" placeholder="Name">
    </div>

    <div class="col-md-2">
        <input type="text" name="age" class="form-control" placeholder="Age">
    </div>

    <div class="col-md-2">
        <input type="text" name="gender" class="form-control" placeholder="Gender">
    </div>

    <div class="col-md-2">
        <input type="text" name="phone" class="form-control" placeholder="Phone">
    </div>

    <div class="col-md-3">
        <input type="text" name="address" class="form-control" placeholder="Address">
    </div>

    <div class="col-md-4">
        <select name="doctor_id" class="form-control">
        <%
        PreparedStatement psd = con.prepareStatement("SELECT * FROM doctor");
        ResultSet rsd = psd.executeQuery();

        while(rsd.next()){
        %>
            <option value="<%=rsd.getInt("id")%>">
                <%=rsd.getString("name")%>
            </option>
        <%
        }
        %>
        </select>
    </div>

    <div class="col-md-2">
        <input type="submit" value="Add" class="btn btn-success w-100">
    </div>
</form>
</div>

<%
/* ✅ INSERT */
String name = request.getParameter("name");

if(name != null){
    String age = request.getParameter("age");
    String gender = request.getParameter("gender");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");
    String doctor_id = request.getParameter("doctor_id");

    PreparedStatement ps = con.prepareStatement(
    "INSERT INTO patient(name, age, gender, phone, address, doctor_id) VALUES(?,?,?,?,?,?)");

    ps.setString(1, name);
    ps.setInt(2, Integer.parseInt(age));
    ps.setString(3, gender);
    ps.setLong(4, Long.parseLong(phone));
    ps.setString(5, address);
    ps.setInt(6, Integer.parseInt(doctor_id));

    ps.executeUpdate();

    out.println("<div class='alert alert-success'>Patient Added</div>");
}
%>

<!-- 📋 TABLE -->
<table class="table table-bordered table-striped text-center">
<tr class="table-dark">
    <th>ID</th>
    <th>Name</th>
    <th>Age</th>
    <th>Gender</th>
    <th>Phone</th>
    <th>Address</th>
    <th>Doctor</th>
    <th>Action</th>
</tr>

<%
String search = request.getParameter("search");
String type = request.getParameter("type");

PreparedStatement ps2;

if(search != null && !search.trim().isEmpty()){
    if("id".equals(type)){
        ps2 = con.prepareStatement(
        "SELECT p.*, d.name AS doctor_name FROM patient p LEFT JOIN doctor d ON p.doctor_id=d.id WHERE p.id=?");
        ps2.setInt(1, Integer.parseInt(search));
    } else {
        ps2 = con.prepareStatement(
        "SELECT p.*, d.name AS doctor_name FROM patient p LEFT JOIN doctor d ON p.doctor_id=d.id WHERE p.name LIKE ?");
        ps2.setString(1, "%" + search + "%");
    }
} else {
    ps2 = con.prepareStatement(
    "SELECT p.*, d.name AS doctor_name FROM patient p LEFT JOIN doctor d ON p.doctor_id=d.id");
}

ResultSet rs2 = ps2.executeQuery();

while(rs2.next()){
%>

<tr>
    <td><%=rs2.getInt("id")%></td>
    <td><%=rs2.getString("name")%></td>
    <td><%=rs2.getInt("age")%></td>
    <td><%=rs2.getString("gender")%></td>
    <td><%=rs2.getLong("phone")%></td>
    <td><%=rs2.getString("address")%></td>
    <td><%=rs2.getString("doctor_name")%></td>
   
</tr>

<%
}
%>

</table>

</div>

</body>
</html>