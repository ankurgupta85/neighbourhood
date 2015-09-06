<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Insert title here</title>
<script type="text/javascript" src="disableRightClick.js"></script>

</head>
<body bgcolor="white">


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
		
}
 */String message=null;
if(session!=null && session.getAttribute("message")!=null)
{
	message=session.getAttribute("message").toString();
	
}
if(message!=null)
{
%>
<center>
<font size="2" style="font-family: cursive;;color: black;background-color: white;"><b><%=message %></b></font>
<%}
session.removeAttribute("message");
%>
</center></body>
</html>