<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="java.util.*,com.neighbourhood.message.*,com.neighbourhood.user.*,com.neighbourhood.neighbours.*,com.neighbourhood.event.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<script type="text/javascript" src="disableRightClick.js"></script>
<title>Insert title here</title>
</head>
<body bgcolor="white">
<center>

<br><br>
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
	String username = null;
		if (session == null || session.getAttribute("username") == null) {
			response.sendRedirect("index.jsp");
		} else {
			username = session.getAttribute("username").toString();
	%>

	<font size="2"
		style="font-family: cursive; color: black; background-color: white;"><b>Messages</b></font>
	<br>&nbsp;&nbsp;
	
	<a href="showAllUnreadMessages.jsp" style="text-decoration: none;" target="main"><font size="2"
		style="font-family: cursive; color: black; background-color: white;">Unread Message<font size="1"
		style="font-family: cursive; color: black; background-color: white;"> (<%=MessageInfo.countUnreadMessages(username) %>)</font></font></a>
	<br>
	&nbsp;&nbsp;
	
	<a href="showAllReadMessages.jsp" style="text-decoration: none;" target="main"><font size="2"
		style="font-family: cursive; color: black; background-color: white;">Read Message <font size="1"
		style="font-family: cursive; color: black; background-color: white;">(<%=MessageInfo.countReadMessages(username) %>)</font></font></a>
	<br>
	

	
	<br>
	<b><font size="2"
		style="font-family: cursive; color: black; background-color: white;">Events</font></b>

	<br>&nbsp;&nbsp;<a href="showPastEvents.jsp"  target="main" style="text-decoration: none;"><font size="2"
		style="font-family: cursive; color: black; background-color: white;text-decoration: none;">Past Events<font size="1"
		style="font-family: cursive; color: black; background-color: white;">  (<%= EventInfo.countPastEvents(username) %>)</font></font></a>

<br>&nbsp;&nbsp;<a href="showTodayEvents.jsp"  target="main" style="text-decoration: none;"><font size="2"
		style="font-family: cursive; color: black; background-color: white;text-decoration: none;">Today Events <font size="1"
		style="font-family: cursive; color: black; background-color: white;">(<%= EventInfo.countTodayEvents(username) %>)</font></font></a>


<br>&nbsp;&nbsp;<a href="showUpcomingEvents.jsp" target="main" style="text-decoration: none;"><font size="2"
		style="font-family: cursive; color: black; background-color: white;text-decoration: none;">Upcoming Events<font size="1"
		style="font-family: cursive; color: black; background-color: white;"> (<%= EventInfo.countFutureEvents(username) %>)</font></font></a>



	




	<%
		}
	%>
	
	</center>

</body>
</html>