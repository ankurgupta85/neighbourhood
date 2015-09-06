<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.neighbourhood.neighbours.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<!-- <script type="text/javascript" src="otheruser.js"></script> -->
<script type="text/javascript" src="disableRightClick.js"></script>
</head>
<body>
<center>
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
	
/* 		System.out.println("In writeMessage.jsp");
 */		String userRequest = request.getQueryString();
		String[] splitRequest = userRequest.split("=");
		String otherUser = splitRequest[1];
		String username = null;
		if (session != null && session.getAttribute("username") != null) {
			username = session.getAttribute("username").toString();
		} else {
			response.sendRedirect("index.jsp");
		}
	%>
	<table>
		<tr style="font-family: cursive; font-size: 2">
			<td align="left" width="50%">From: <%=Neighbours.getFullName(username)%>
			</td>
		</tr>
		<tr style="font-family: cursive; font-size: 2">
			<td align="left" width="50%">To: <%=Neighbours.getFullName(otherUser)%>
			</td>
		</tr>
	</table>

	<br>

	<form method="post" onsubmit="return validateMessage();"
		name="messageForm" action="SendMessage" target="main">
		<table border="0">
			<tr style="font-family: cursive; font-size: 2">
				<td><b>Subject:</b></td>
				<td><input type="text" name="messageTopic" id="messageTopic"
					size="80" style="font-family: cursive; font-size: 2" /></td>

			</tr>
			<tr>
				<td></td>
				<td><textarea rows="3" cols="80" name="messageField"
						id="messageField" style="font-family: cursive; font-size: 2"></textarea><font
					size="1">(Maximum characters: 175)</font></td>
			</tr>

			<tr>
				<td></td>
				<td><input type="submit" value="Send Message"
					style="font-family: cursive; font-size: 2" />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input
					type="reset" value="Cancel Message"
					style="font-family: cursive; font-size: 2" /></td>
			</tr>
		</table>
		<input type="hidden" name="sender" value="<%=username%>" /> <input
			type="hidden" name="receiver" value="<%=otherUser%>" />
	</form>
	<br>
	<br>
</center>
</body>
</html>