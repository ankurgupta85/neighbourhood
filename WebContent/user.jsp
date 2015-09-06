<%@page import="com.neighbourhood.neighbours.Neighbours"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="disableRightClick.js"></script>

<link rel="shortcut icon" href="N.ico" />
<title>
	<%
		if (session.getAttribute("currentUserNeighbour") != null) {
			session.removeAttribute("currentUserNeighbour");
		}
		if (session.getAttribute("otherUser") != null) {
			session.removeAttribute("otherUser");
		}
		/* if(session.getAttribute("eventTopic") !=null)
		{
			session.removeAttribute("eventTopic");
			session.removeAttribute("eventDescription");
			session.removeAttribute("date_time_event");
			session.removeAttribute("flag");
				
		} */

		if (session == null || session.getAttribute("username") == null) {

		} else {
	%> <%=Neighbours.getFullName(session.getAttribute(
						"username").toString())%>'s HomePage <%
 	}
 %>
</title>

<link rel="Logo" href="logo.ico" />
<script language=" JavaScript">
function MyReload() 
{ 
window.location.reload(); 
} 
</script>
</head>

<%
	response.setHeader("Cache-Control", "no-cache"); //Forces caches to obtain a new copy of the page from the origin server
	response.setHeader("Cache-Control", "no-store"); //Directs caches not to store the page under any circumstance
	response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0 backward compatibility

	if (session.getAttribute("currentUserNeighbour") != null) {
		session.removeAttribute("currentUserNeighbour");
	}
	if (session.getAttribute("otherUser") != null) {
		session.removeAttribute("otherUser");
	}
	if (session.getAttribute("eventTopic") != null) {
		session.removeAttribute("eventTopic");
		session.removeAttribute("eventDescription");
		session.removeAttribute("date_time_event");
		session.removeAttribute("flag");

	}

	if (session == null || session.getAttribute("username") == null) {
		response.sendRedirect("index.jsp");
	} else {
%>

<frameset rows="10%,85%,5%" onload="MyReload()" bordercolor="white"
	border="0" style="background-color: white;">
	<frame name="header" frameborder="0" scrolling="no" marginheight="20"
		marginwidth="100" src="header.jsp" style="background-color: white;">
	<!-- <frameset cols="60%,40%"  bordercolor="white" border="0">
		<frame name="sessionmessage" frameborder="0" scrolling="no"
			marginheight="10" marginwidth="100" src="sessionmessage.jsp" style="background-color: white;">
		<frame name="currentLocation" frameborder="0" scrolling="no"
			marginheight="10" marginwidth="50" src="currentLocation.jsp" style="background-color: white;">
	</frameset> -->
	<frameset cols="12%,68%,20%" bordercolor="white" border="0">
		<frame frameborder="0" scrolling="auto" src="neighbourlist.jsp"
			style="background-color: white;">
		<frame frameborder="0" scrolling="auto" name="main"
			src="postUpdates.jsp"
			style="background-color: white; overflow: hidden; scrollbar-base-color: #000000; scrollbar-arrow-color: #FFFFFF; scrollbar-DarkShadow-Color: #888888;">
		<frame frameborder="0" scrolling="auto" noresize="noresize"
			src="eventMessage.jsp" style="background-color: white;">
	</frameset>
	<frame name="footer" frameborder="0" scrolling="no" marginheight="20"
		marginwidth="100" src="footer.jsp"
		style="background-color: white; color: black">
</frameset>
<%
	}
%>
</html>