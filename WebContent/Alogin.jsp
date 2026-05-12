<%
	String id=request.getParameter("id");
	String pwd=request.getParameter("pwd");
	if(id.equals("vinayy")&&pwd.equals("vinayy@123"))
	{
		session.setAttribute("id", id);
		%>
		<jsp:forward page="PatientHome.jsp"></jsp:forward>
		<%
	}
	else
	{
		out.println("invalid id and password");  
	}
%>	