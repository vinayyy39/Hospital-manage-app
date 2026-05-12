<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>  
<%@ include file="db.jsp"%>
<%
    String id = (String) session.getAttribute("id");
    if(id == null) {
        response.sendRedirect("doctor.html");
        return;
    }

    String name = request.getParameter("name");
    String spec = request.getParameter("spec");
    String phone = request.getParameter("phone"); 
    
    try {
        PreparedStatement ps = con.prepareStatement("INSERT INTO doctor(name, specialization, phone) VALUES(?,?,?)");
        ps.setString(1, name); 
        ps.setString(2, spec);
        ps.setLong(3, Long.parseLong(phone)); 
        ps.executeUpdate(); 
        ps.close();
        response.sendRedirect("ShowDoctor.jsp");
    } catch(Exception e) {
        out.println("<h3>Error: " + e.getMessage() + "</h3>");
        out.println("<a href='AddDoctor.jsp'>Go Back</a>");
    }
%>
