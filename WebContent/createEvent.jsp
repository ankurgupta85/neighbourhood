<%@page import="com.neighbourhood.neighbours.Neighbours"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link type="text/css" rel="stylesheet"
	href="dhtmlgoodies_calendar/dhtmlgoodies_calendar.css" media="screen"></LINK>
<script type="text/javascript" src="event.js"></script>
<SCRIPT type="text/javascript"
	src="dhtmlgoodies_calendar/dhtmlgoodies_calendar.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Event</title>
<script type="text/javascript" src="disableRightClick.js"></script>
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
	
		String username = null;
		if (session == null || session.getAttribute("username") == null) {
			response.sendRedirect("index.jsp");
		} else {

			username = session.getAttribute("username").toString();
		}
	%>
	<font size="2" style="font-family: cursive; color: black;;background-color: white;">Creator:
		<b><%=Neighbours.getFullName(username)%></b>
	</font>

	<br>
	<%
		if (session.getAttribute("eventMessage") != null) {
	%>

	<div align="center" style="color: red;">
		<b><%=session.getAttribute("eventMessage").toString()%></b>
	</div>
	<br>
	<%
		session.removeAttribute("eventMessage");
		}
	%>

	<br>

	<form method="post" onSubmit="return validateEvent();" name="eventForm"
		action="eventInviteNeighours.jsp">
		<table>
			<tr>
				<td align="left"><font size="2"
					style="font-family: cursive; color: black;;background-color: white;">Topic:</font></td>
			</tr>
			<tr>
				<%
					if (session.getAttribute("eventTopic") != null) {
				%>
				<td align="center"><input type="text" id="eventTopic"
					name="eventTopic"
					value="<%=session.getAttribute("eventTopic").toString()%>"
					maxlength="100" size="100"
					style="font-size: 2; font-family: cursive; color: black;;background-color: white;" /></td>
				<%
					} else {
				%>
				<td align="center"><input type="text" id="eventTopic"
					name="eventTopic" maxlength="100" size="100"
					style="font-size: 2; font-family: cursive; color: black;;background-color: white;" /></td>

				<%
					}
				%>

			</tr>
			<tr>
				<td align="left"><font size="2"
					style="font-family: cursive; color: black;;background-color: white;"> Description:</font></td>
			</tr>
			<tr>
				<%
					if (session.getAttribute("eventDescription") != null) {
				%>
				<td><textarea name="eventDescription" id="eventDescription"
						rows="10" cols="100"
						style="font-family: cursive; font-size: 2; color: black; background-color: white;"><%=session.getAttribute("eventDescription").toString()%></textarea></td>
				<%
					} else {
				%>
				<td><textarea name="eventDescription" id="eventDescription"
						rows="10" cols="100"
						style="font-family: cursive; font-size: 2; color: black; background-color: white;"></textarea></td>
				<%
					}
				%>
			</tr>
			<tr>
				<td><font size="2" style="font-family: cursive; color: black;background-color: white;">
						Date & Time:</font> <input type="text" readonly name="theDate3"
					id="theDate3"
					onclick="displayCalendar(document.forms[0].theDate3,'yyyy/mm/dd hh:ii',this,true)"
					style="font-family: cursive; font-size: 2; color: black; background-color: white;" /></td>
			</tr>
			
		</table>
		<br>
		<input type="hidden" name="flag" value="new" /> 
		 <input type="submit" value="Invite Neighbours"
			style="font-family: cursive; font-size: 2; color: black;;background-color: white;" /> &nbsp;
		&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input type="reset"
			style="font-family: cursive; font-size: 2; color: black; background-color: white;"
			value="Reset Values" />
	</form>
</center>
</body>
</html>