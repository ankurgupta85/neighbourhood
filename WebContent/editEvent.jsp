<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.neighbourhood.event.ShowEvents"%>
<%@page import="java.util.List"%>
<%@page import="com.neighbourhood.event.EventInfo"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>


<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link type="text/css" rel="stylesheet"
	href="dhtmlgoodies_calendar/dhtmlgoodies_calendar.css" media="screen"></LINK>
<script type="text/javascript" src="event.js"></script>
<SCRIPT type="text/javascript"
	src="dhtmlgoodies_calendar/dhtmlgoodies_calendar.js"></script>


<title>Insert title here</title>
<script type="text/javascript" src="disableRightClick.js"></script>
</head>
<body bgcolor="white">
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
	
		/* System.out.println("In eventDetails.jsp"); */
		String username = null;
		if (session == null || session.getAttribute("username") == null) {
			response.sendRedirect("index.jsp");
		} else {

			username = session.getAttribute("username").toString();
		}
		

		
		
	%>
	<font size="2"
		style="font-family: cursive; background-color: white; color: black;">Current
		User : <%=username%></font>
	<%
		if (session.getAttribute("eventMessage") != null) {
	%>

	<div align="center" style="color: black;">
		<b><font size="2"
			style="color: black; background-color: white; font-family: cursive;"><%=session.getAttribute("eventMessage").toString()%></font></b>
	</div>
	<br>
	<%
		session.removeAttribute("eventMessage");
		}
	
	%>

	<%
		String eventDetails = request.getQueryString();
		String[] splitRequest = eventDetails.split("=");
		int event_id = Integer.parseInt(splitRequest[1]);

		EventInfo event = ShowEvents.getEventInfo(event_id);
		if (event == null) {
	%>
	<font size="2"
		style="font-family: cursive; color: black; background-color: white;">Event
		information not available. Please contact admin.</font>
	<%
		} else {
	%>


	<form method="post" onSubmit="return validateEvent();" name="eventForm"
		action="editeventInviteNeighours.jsp">
		<table>
			<tr>
				<td align="left"><font size="2"
					style="font-family: cursive; color: black; background-color: white;">Topic:</font></td>
			</tr>
			<tr>
				<td align="center"><input type="text" id="eventTopic"
					name="eventTopic" value="<%=event.getEventTopic()%>"
					maxlength="100" size="100"
					style="font-family: cursive; font-size: 2; color: black; background-color: white;" /></td>

			</tr>
			<tr>
				<td align="left"><font size="2"
					style="font-family: cursive; color: black; background-color: white;">Description:</font></td>
			</tr>
			<tr>
				<td><textarea name="eventDescription" id="eventDescription"
						rows="10" cols="100"
						style="font-family: cursive; font-size: 2; color: black; background-color: white;"><%=event.getEventDescription()%></textarea></td>

			</tr>
			<tr>
				<td><font size="2" style="font-family: cursive;color: black;background-color: white;">Date & Time:</font> <input type="text" readonly name="theDate3"
					id="theDate3" value="<%=event.getDate()%> <%=event.getTime() %>"
					onclick="displayCalendar(document.forms[0].theDate3,'yyyy/mm/dd hh:ii',this,true)" style="font-family: cursive;font-size: 2;color: black;background-color: white;"/></td>
			</tr>

		</table>
		<input type="hidden" name="event_id" id="event_id"
			value="<%=event_id%>"  style="font-family: cursive;font-size: 2;color: black;background-color: white;" /> <br> <input type="submit"
			value="Invite Neighbours"  style="font-family: cursive;font-size: 2;color: black;background-color: white;"/> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
		&nbsp; &nbsp; <input type="reset" value="Reset Values"  style="font-family: cursive;font-size: 2;color: black;background-color: white;"/>
	</form>





	<%
		}
	%>
	<br>
	<br>

</center>
</body>
</html>