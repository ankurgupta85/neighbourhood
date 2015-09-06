<%@page import="com.neighbourhood.neighbours.InviteNeighbour"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="com.neighbourhood.email.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="disableRightClick.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<center>

		<%
			String username = null;
			if (session == null || session.getAttribute("username") == null) {
				response.sendRedirect("index.jsp");
			} else {

				username = session.getAttribute("username").toString();
				String email = request.getQueryString();
				
				
				boolean reminderSent=EmailService.sendReminder(username,email);
				if(reminderSent)
				{
					request.getSession().setAttribute("message", "Reminder mail sent to " + email);
					
				}
				else
				{
					request.getSession().setAttribute("message",
							"Some problem encountered while sending reminder to " + email);
				
				}
			
				response.sendRedirect("user.jsp");
			
			
			}
		%>
		
		
</center>

</body>
</html>