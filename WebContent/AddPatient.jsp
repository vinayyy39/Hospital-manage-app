<%@include file="db.jsp"%>
<%
	String id = request.getParameter("id");
	int ig = Integer.parseInt(id);
	String name = request.getParameter("name");
	String ag = request.getParameter("age");
	int age = Integer.parseInt(ag);
	String ge = request.getParameter("gender");
	String phn = request.getParameter("phone");
	int phone = Integer.parseInt(phn);
	String add = request.getParameter("address");
	String hm = "insert into patient values(?,?,?,?,?,?)";
	PreparedStatement ps = con.prepareStatement(hm);       
	ps.setInt(1, ig);
	ps.setString(2, name);
	ps.setInt(3, age);
	ps.setString(4, ge);
	ps.setInt(5, phone);
	ps.setString(6, add);
	int i = ps.executeUpdate();     
	out.println(i + "patient added sucessfully");  
	con.close();
%> 

	
   