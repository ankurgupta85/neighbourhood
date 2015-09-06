<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="java.util.*,com.neighbourhood.neighbours.*,com.neighbourhood.event.*,com.neighbourhood.user.*,com.neighbours.imageUpload.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="event.js"></script>
<title>Insert title here</title>
<script type="text/javascript" src="disableRightClick.js"></script>
</head>
<body bgcolor="white">
	<center>
		<br>
		<br> <b> <font size="2"
			style="font-family: cursive; background-color: white; color: black;">Invite
				Neighbours</font></b> <br>

		<%
			if (session.getAttribute("currentUserNeighbour") != null) {
				session.removeAttribute("currentUserNeighbour");
			}
			if (session.getAttribute("otherUser") != null) {
				session.removeAttribute("otherUser");
			}

			String username = null;
			if (session == null || session.getAttribute("username") == null) {
				response.sendRedirect("index.jsp");
			} else {

				username = session.getAttribute("username").toString();
			}
		%>
		<%-- 	<font size="2"
		style="font-family: cursive; background-color: white; color: black;">Current
		User: <%=username%></font>
	<br>
 --%>
		<%
			String eventTopic = request.getParameter("eventTopic");
			String eventDescription = request.getParameter("eventDescription");
			String date_time = request.getParameter("theDate3");
			int event_id = Integer.parseInt(request.getParameter("event_id"));

			if (eventTopic == null || eventDescription == null
					|| date_time == null || eventTopic.isEmpty()
					|| eventTopic.isEmpty() || date_time.isEmpty()) {

				response.sendRedirect("editEvent.jsp?event_id=" + event_id);

			}
			else
				if(EventInfo.isPastDate(date_time))
				{
				
					session.setAttribute("eventMessage",
							"Already passed event cannot be edited "+date_time);
					response.sendRedirect("editEvent.jsp?event_id=" + event_id);

				}

			List<User> neighboursMap = Neighbours.getNeighboursList(username);

			/* System.out.println(neighboursMap); */
			if (neighboursMap.isEmpty()) {
				session.setAttribute("eventMessage",
						"Please add neighbours in your neighbours list to invite them to event");
				response.sendRedirect("editEvent.jsp?event_id=" + event_id);

			} else {
		%>
		<br><br>
		<form name="inviteNeighboursForm"
			onsubmit="return validateinviteNeighbours();" method="post"
			action="EditNeighbourEvent" target="_top">
			<input type="hidden" value="<%=event_id%>" name="event_id"
				id="event_id" /> <input type="hidden" value="<%=eventTopic%>"
				name="eventTopic" id="eventTopic" /> <input type="hidden"
				value="<%=eventDescription%>" name="eventDescription"
				id="eventDescription" /> <input type="hidden"
				value="<%=date_time%>" name="date_time" id="date_time" /> <input
				type="hidden" value="<%=username%>" name="username" id="username" />
			<table border="0" align="center" width="50%">
			
				<%
								for (int index = 0; index < neighboursMap.size(); index++) {

												User user = neighboursMap.get(index);

												String userLink = "otheruser.jsp?username="
														+ user.getUsername();

												String imagePath = RetrieveImage.getProfileImagePath(user
														.getUsername());
												String profilePicName = RetrieveImage
														.getProfilePicName(user.getUsername());
												String neighbourId = user.getUsername();
												String neighbourFullName = user.getFname() + " "
														+ user.getLname();
							%>
							<tr>
							<% 
							if (EventInfo.alreadyInvited(neighbourId, event_id)) {
								// Mark it as selected when displaying all neighbours
				%>

				<td><input type="checkbox" name="invite" checked="checked"
						value="<%=neighbourId%>"
						style="font-family: cursive; font-size: 2; color: black; background-color: white;" /></td>
					<td><font size="2"
						style="font-family: cursive; color: black; background-color: white;"><img
							src="<%=imagePath%>" alt="<%=user.getUsername()%>" width="20"
							height="20"
							onclick="window.open('<%=imagePath%>', '<%=profilePicName%>', 'width=300,height=300,resizabel=yes,toolbar=no,left=200,top=200')" /><a
							href="<%=userLink%>" target="main" style="text-decoration: none;"><font
								size="2"
								style="font-family: cursive; color: black; background-color: white;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=neighbourFullName%></font></a></font></td>




					<td><font size="2"
						style="font-family: cursive; color: black; background-color: white;"><a
							href="<%=userLink%>" target="main"
							style="text-decoration: none; color: black;"><%=user.getUsername()%></a></font></td>


					<td><font size="2"
						style="font-family: cursive; color: black; background-color: white;"><%=user.getZipcode()%></font></td>

				<%
					} else {

								// Display users without selected option
				%>

				<td><input type="checkbox" name="invite"
						value="<%=neighbourId%>"
						style="font-family: cursive; font-size: 2; color: black; background-color: white;" /></td>
					<td><font size="2"
						style="font-family: cursive; color: black; background-color: white;"><img
							src="<%=imagePath%>" alt="<%=user.getUsername()%>" width="20"
							height="20"
							onclick="window.open('<%=imagePath%>', '<%=profilePicName%>', 'width=300,height=300,resizabel=yes,toolbar=no,left=200,top=200')" /><a
							href="<%=userLink%>" target="main" style="text-decoration: none;"><font
								size="2"
								style="font-family: cursive; color: black; background-color: white;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=neighbourFullName%></font></a></font></td>




					<td><font size="2"
						style="font-family: cursive; color: black; background-color: white;"><a
							href="<%=userLink%>" target="main"
							style="text-decoration: none; color: black;"><%=user.getUsername()%></a></font></td>


					<td><font size="2"
						style="font-family: cursive; color: black; background-color: white;"><%=user.getZipcode()%></font></td>

				<%
					}
							
							%>
							</tr>
							<% 
							
							
						}
				%>
			</table>
			<br>
			<!-- <input type="button" value="Select All"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="Deselect All" />
					 -->
			<br>
			<center>
				<input type="submit" value="Send Invite"
					style="font-family: cursive; font-size: 2; color: black; background-color: white;" />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
					type="reset" value="Cancel All Selected"
					style="font-family: cursive; font-size: 2; color: black; background-color: white;" />
			</center>
		</form>
		<%
			}
		%>


	</center>
</body>
</html>