<%@page import="com.neighbours.imageUpload.RetrieveImage"%>
<%@page import="com.neighbourhood.user.UserInfo"%>
<%@page import="com.neighbourhood.user.User"%>
<%@page import="com.neighbourhood.neighbours.Neighbours"%>
<%@page import="com.neighbourhood.event.ShowEvents"%>
<%@page import="java.util.List"%>
<%@page import="com.neighbourhood.event.EventInfo"%>
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
	<center>
		<br> <br> <b><font size="2"
			style="font-family: cursive; background-color: white; color: black;">Event
				Details</font><br> <br> </b>

		<%
			/* System.out.println("In eventDetails.jsp"); */
			String username = null;
			if (session == null || session.getAttribute("username") == null) {
				response.sendRedirect("index.jsp");
			} else {

				username = session.getAttribute("username").toString();
			}

			String eventDetails = request.getQueryString();
			String[] splitRequest = eventDetails.split("=");
			int event_id = Integer.parseInt(splitRequest[1].split(";")[0]);
			String eventTime = splitRequest[1].split(";")[1];
			EventInfo event = ShowEvents.getEventInfo(event_id);

			if (event == null) {
		%>
		<font size="2"
			style="font-family: cursive; background-color: white; color: black;">Event
			information not available. Please contact admin.</font>
		<%
			} else {
		%>
		<table border="0" width="80%" cellpadding="1" cellspacing="1">
			<tr>
				<td align="center"><b><font size="2"
						style="font-family: cursive; background-color: white; color: black;">Event
							Topic:</font></b></td>
				<td><font size="2"
					style="font-family: cursive; background-color: white; color: black;"><%=event.getEventTopic()%></font>
				</td>
			</tr>
			<tr>
				<td align="center"><b><font size="2"
						style="font-family: cursive; background-color: white; color: black;">Event
							Description:</font></b></td>
				<td><font size="2"
					style="font-family: cursive; background-color: white; color: black;"><%=event.getEventDescription()%></font><br>
				</td>
			</tr>
			<tr>
				<td align="center"><b><font size="2"
						style="font-family: cursive; background-color: white; color: black;">Date
							&amp; Time</font></b></td>
				<td><font size="2"
					style="font-family: cursive; background-color: white; color: black;"><%=event.getDate()%>
						<%=event.getTime()%></font></td>
			</tr>

			<tr>
				<td align="center"><b><font size="2"
						style="font-family: cursive; background-color: white; color: black;">Event
							Creator</font></b></td>
				<td>
					<%
						if (username.equals(event.getCreator())) {
					%> <a href="user.jsp" target="_top" style="text-decoration: none;"><font
						size="2"
						style="font-family: cursive; background-color: white; color: black; text-decoration: none;"><%=Neighbours.getFullName(username)%></font></a>
					<%
						} else {
					%> <font size="2"
					style="font-family: cursive; background-color: white; color: black;"><a
						href="otheruser.jsp?username=<%=event.getCreator()%>"
						target="main" style="text-decoration: none; color: black;"><%=Neighbours.getFullName(event.getCreator())%></a></font>
					<%
						}
					%>
				</td>
			</tr>

		</table>
		<%
			}
		%>
		<br> <br> <b><font size="2"
			style="font-family: cursive; background-color: white; color: black;">Invite
				List:</font></b> <br>
		<br>
		<table border="0" width="50%">
			<%
				List<String> userList = ShowEvents.getAlInivites(event_id);

				if (userList.isEmpty()) {
			%>
			Neighbour List could not be fetched. Please contact admin

			<%
				} else {
							for (String user : userList) {

								User userInfo = UserInfo.getUserInfoByUsername(user);
								String imagePath = RetrieveImage.getProfileImagePath(user);
								String profilePicName = RetrieveImage
										.getProfilePicName(user);
								String fullName = userInfo.getFname() + " "
										+ userInfo.getLname();
								String userLink = "otheruser.jsp?username=" + user;
			%>
			<tr>


				<td><font size="2"
					style="font-family: cursive; color: black; background-color: white;"><img
						src="<%=imagePath%>" alt="<%=user%>" width="20" height="20"
						onclick="window.open('<%=imagePath%>', '<%=profilePicName%>', 'width=300,height=300,resizabel=yes,toolbar=no,left=200,top=200')" /><a
						href="<%=userLink%>" target="main" style="text-decoration: none;"><font
							size="2"
							style="font-family: cursive; color: black; background-color: white;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=fullName%></font></a></font></td>

				<td><a
						href="<%=userLink%>" target="main" style="text-decoration: none;"><font
							size="2"
							style="font-family: cursive; color: black; background-color: white;"><%=user%></font></a></td>


				<td><font size="2"
					style="font-family: cursive; color: black; background-color: white;"><%=userInfo.getZipcode()%></font></td>


			</tr>
			<%
				}
			%>
		</table>

		<br> <br>
		<br>
		<%
			userList.clear();

			}

			// TODO - To Edit or update or delete event...only if creator is current user
			// if(event.getCreator().equals(session.getAttribute("username").toString()))
			//{
		%>

		<%
			if (!eventTime.equals("PAST")
					&& event.getCreator().equals(username)) {
		%>
		<font size="2"
			style="font-family: cursive; background-color: white; color: black;"><a
			href="editEvent.jsp?event_id=<%=event_id%>" target="main"
			style="text-decoration: none;"><font size="2"
				style="font-family: cursive; background-color: white; color: black;">Edit
					Event</font></a></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <font size="2"
			style="font-family: cursive; background-color: white; color: black;"><a
			href="deleteEvent.jsp?event_id=<%=event_id%>"
			style="text-decoration: none;"
			onclick="return confirm('Are you sure you wish to delete this event?');"
			target="_top"><font size="2"
				style="font-family: cursive; background-color: white; color: black;">Delete
					Event</font></a></font>
		<%
			}
		%>



	</center>
</body>
</html>