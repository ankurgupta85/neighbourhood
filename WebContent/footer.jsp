<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body  bgcolor="white">
	<center>
	<a href="Info.html" target="main" style="text-decoration: none;"><font
						size="1"
						style="font-family: cursive; color: black; background-color: white;">About Us</font></a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="terms_condition.html" target="main" style="text-decoration: none;"><font
						size="1"
						style="font-family: cursive; color: black; background-color: white;">Terms
							&amp; Conditions</font></a>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="userFeedback.jsp" target="main" style="text-decoration: none;"><font
						size="1"
						style="font-family: cursive; color: black; background-color: white;">Feedback</font></a>
							
<%
if(session.getAttribute("currentUserNeighbour")!=null)
{
	session.removeAttribute("currentUserNeighbour");
}
if(session.getAttribute("otherUser")!=null)
{
	session.removeAttribute("otherUser");
}
/* if(session.getAttribute("eventTopic") !=null)
{
	session.removeAttribute("eventTopic");
	session.removeAttribute("eventDescription");
	session.removeAttribute("date_time_event");
	session.removeAttribute("flag");
		
} */

%>						
					

		
				
	</center>
</body>
</html>