<%@page import="com.neighbourhood.request.Request"%>
<%@page import="com.neighbourhood.request.ShowPendingRequests"%>
<%@page import="com.neighbourhood.request.NeighbourRequest"%>
<%@page import="com.neighbourhood.neighbours.Neighbours"%>
<%@page import="com.neighbourhood.user.RetrieveMessage,com.neighbourhood.post.Post,com.neighbourhood.user.*"%>
<%@page
	import="com.neighbourhood.message.MessageInfo,com.neighbourhood.event.EventInfo,com.neighbourhood.event.ShowEvents"%>

<%@page
	import="com.neighbourhood.recommendation.RecommendationList,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
</style>
<script language="Javascript" src="userhome.js"></script>
<script type="text/javascript" src="disableRightClick.js"></script>
<script language=" JavaScript">
function MyReload() 
{ 
window.location.reload(); 
} 
</script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<title><%=session.getAttribute("fname")%>'s Homepage</title>
</head>
<body onload="MyReload()">

	<div align="center">
		<center>
			<img alt="Neighbourhood" src="neighbours.png" />
		</center>
	</div>
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
		}
	%>
	<br><div align="center" style="font-family: cursive;font-size: 14"><h2><%=Neighbours.getFullName(username)%></h2> </div>
	<br>
	<%
		if (session != null
				&& session.getAttribute("inviteNeighboursMessage") != null) {
	%>
	<div align="center"><%=session.getAttribute("inviteNeighboursMessage").toString() %></div>
	<%
		session.removeAttribute("inviteNeighboursMessage");
		}
	%>

	<br> <div>Events
	
	<br>&nbsp;&nbsp;
	
	
	
	<%
					List<EventInfo> eventsList = ShowEvents.getAllEvents(username);
						if (eventsList.isEmpty()) {
				

	
		} else {
	%>

	<table>
		<tr>
			<td>Event Topic</td>
			<td>Date & Time</td>
			<td>Creator</td>
		</tr>


		<%
			for (EventInfo event : eventsList) {
		%>
		<tr>

			<td><a href="eventDetails.jsp?event_id=<%=event.getEvent_id()%>" style="text-decoration: none;"><%=event.getEventTopic()%></a></td>
			<td><%=event.getDate()%> <%=event.getTime() %></td>
			<td><a href="otheruser.jsp?username=<%=event.getCreator()%>" style="text-decoration: none;"><%=event.getCreator()%></a></td>


		</tr>

		<%
			}
		%>

	</table></div>
	<%
		eventsList.clear();
		}
	%>

	<br> 
	<a href="createEvent.jsp" style="text-decoration: none;">Create Event</a>
	<br>
	<br>

	<b>Messages for <%=username%></b>
	<br>


	<%
		Map<Integer, String> messageMap = (HashMap<Integer, String>) RetrieveMessage
				.getMessages(username);
		List<Integer> unreadMessageList = new ArrayList<Integer>();
		List<Integer> readMessageList = new ArrayList<Integer>();
		Iterator iter = messageMap.entrySet().iterator();
		while (iter.hasNext()) {
			Map.Entry<Integer, String> entry = (Map.Entry<Integer, String>) iter
					.next();
			if (entry.getValue().equals(MessageInfo.MESSAGE_STATUS_UNREAD)) {
				unreadMessageList.add(entry.getKey());

			} else {
				readMessageList.add(entry.getKey());
			}
		}

/* 		System.out.println("Messages " + messageMap);
		System.out.println("Unread Messages " + unreadMessageList);
		System.out.println("Read MEssages " + readMessageList);
 */		messageMap.clear();
	%>
	Unread Messages:
	<br>
	<%
		if (unreadMessageList.size() == 0) {
	%>
	You dont have any unread messages
	<%
		} else {
	%>


	<table border="1">


		<%
			for (Integer currmessageid : unreadMessageList) {

					MessageInfo message = RetrieveMessage
							.getMessage(currmessageid);
					int messageID = message.getMessageID();
					String sender = message.getSender();
					String receiver = message.getReceiver();
					String messageFull = message.getMessage();
					String date_time = message.getDate_time();
					String status = message.getStatus();
					String messageTopic = message.getMessageTopic();
		%>
		<tr>
			<td><a href="otheruser.jsp?username=<%=sender%>" style="text-decoration: none;"><font style="font-family: cursive;font-size: 2"><%=Neighbours.getFullName(sender)%></font></a></td>


			<td><b><a
					href="showmessage.jsp?messageid=<%=messageID%>;UNREAD" style="font-size: 2;font-family: cursive;text-decoration: none;"><%=messageTopic%></a></b></td>


			<td><%=date_time%></td>
		</tr>

		<%
			}
		%>
	</table>
	<%
		}

		unreadMessageList.clear();
	%>

	<br> Read Messages:
	<br>
	<%
		if (readMessageList.size() == 0) {
	%>
	You dont have any read messages
	<%
		} else {
	%>
	<table border="1">
		<%
			for (Integer currmessageid : readMessageList) {

					MessageInfo message = RetrieveMessage
							.getMessage(currmessageid);
					int messageID = message.getMessageID();
					String sender = message.getSender();
					String receiver = message.getReceiver();
					String messageFull = message.getMessage();
					String date_time = message.getDate_time();
					String status = message.getStatus();
					String messageTopic = message.getMessageTopic();
		%>
		<tr>
			<td><a href="otheruser.jsp?username=<%=sender%>" style="text-decoration: none;"><%=Neighbours.getFullName(sender)%></a></td>
			<td><a href="showmessage.jsp?messageid=<%=messageID%>;READ" style="text-decoration: none;"><%=messageTopic%></a></td>
			<td><%=date_time%></td>
		</tr>

		<%
			}
		%>
	</table>
	<%
		}

		readMessageList.clear();
	%>


	<br>

	<br>
	<br>
	<b>Invite Neighbours:</b>
	<form method="post" action="InviteNeighbour" name="inviteNeighbour"
		onsubmit="return validateInvite();">
		<input type="text" name="inviteEmail" id="inviteEmail" /><input
			type="hidden" value="<%=username%>" name="username" /><br> <input
			type="submit" value="Invite" />
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
			type="reset" value="Clear" />

	</form>
	<br>
	<br>
	<form method="post" action="Search" name="search"
		onsubmit="return validateSearch();">
		<h2>Search:</h2>
		<br>
		<h4>Select one of the attributes to search</h4>
		<select name="attribute" id="attribute">
			<option value="Username">Username</option>
			<option value="Name">Name</option>
			<option value="Zipcode">Zipcode</option>
		</select> <input type="text" name="searchValue" id="searchValue" /><br> <input
			type="submit" value="Search" />&nbsp;&nbsp;&nbsp; <input
			type="reset" value="Clear" />
	</form>
	<br>
	<br>


	<%
		response.setHeader("Cache-Control", "no-cache"); //Forces caches to obtain a new copy of the page from the origin server
		response.setHeader("Cache-Control", "no-store"); //Directs caches not to store the page under any circumstance
		response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
		response.setHeader("Pragma", "no-cache"); //HTTP 1.0 backward compatibility

		if (session == null || session.getAttribute("username") == null) {
			response.sendRedirect("index.jsp");
		} else {
	%>



	<%
		}

		if (session == null || session.getAttribute("username") == null) {
			response.sendRedirect("index.jsp");
		} else {

			if (session.getAttribute("message") != null) {
	%>

	<%=session.getAttribute("message").toString()%><br>
	<br>
	<br>
	<%
		session.removeAttribute("message");
			}
	%>

<!--  Update post -->
	<div>
		<form method="post" action="UpdateStatus" name="updateStatus"
			onsubmit="return validateUpdate();">
			<textarea rows="4" cols="30" name="post" id="post"></textarea>
			<br> <input type="hidden" name="username" value="<%=username%>" />
			<input type="submit" value="Update Status" /> &nbsp; &nbsp; &nbsp;
			&nbsp; <input type="reset" value="Cancel Update" />

		</form>
	</div>

	<br>


	<b>Recommendations</b>
	<%
		//Recommendation List for the neighbours
			List<User> recommendationList = null;
			if (session != null
					&& session.getAttribute("recommendationList") != null) {
				recommendationList = (List<User>) session
						.getAttribute("recommendationList");

			}
			if (recommendationList == null) {
				recommendationList = RecommendationList
						.getRecommendation(username,Integer.parseInt(session
								.getAttribute("zipcode").toString()));
				// Remove login username from the list
				recommendationList.remove(username);

				// Update the list with the neighbours who are not in neighbour table
				// Remove the ppl who are already in neighbour table and only keep those who doesnt exist in table.
				/* recommendationList = RecommendationList
						.updateRecommendationList(recommendationList,
								username); */
			}
			// set recommendationList in session so that the user can be removed from it after requst is sent to him
			session.setAttribute("recommendationList", recommendationList);
			// if recommendation List is empty
			if (recommendationList.isEmpty()) {
	%>
	Please let ur neighbours know about ur existence by inviting them to
	join NEIGHBOURHOOD. :D
	<%
		} else {
	%>
	<table border="1">
		<%
			// if recommendation List is not empty.
					if (recommendationList.size() > 0) {
						for(int index=0;index<recommendationList.size();index++) {
							
							User user=recommendationList.get(index);
							String userLink = "otheruser.jsp?username="
									+ user.getUsername();
							String neighbourRequest = "neighbourRequest.jsp?username="
									+ user.getUsername();
		%>
		<tr>
			<td><a
				href="<%=userLink%>"><%=user.getFname()%> <%=user.getLname() %></a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="<%=neighbourRequest%>" style="text-decoration: none;">Add
					neighbour</a></td>

		</tr>

		<%
			}
					}
		%>
	</table>
	<%
		}
		}
	%>


	<br>
	<br>
	<h3>Requests:</h3>
	<br>
	<h5>Pending Request:</h5>
	<!-- Show  pending requests to accept or decline-->
	<%
		List<User> requestsFromList = null;
		if (session == null || session.getAttribute("username") == null) {
			response.sendRedirect("index.jsp");
		} else {

			if (session != null
					&& session.getAttribute("requestsFromList") != null) {
				requestsFromList = (List<User>) session
						.getAttribute("requestsFromList");

			}

			if (requestsFromList == null) {
				requestsFromList = ShowPendingRequests
						.getPendingRequestToAccept(username);
			}

			session.setAttribute("requestsFromList", requestsFromList);

			if (requestsFromList.isEmpty()) {
	%>
	You have no pending requests

	<%
		} else {
				// Show pending requests
	%>

	<table border="1">

		<%
			// if requestfrom/pendingrequest List is not empty.
					if (requestsFromList.size() > 0) {
					for(int index=0;index<requestsFromList.size();index++) {
						User user=requestsFromList.get(index);
						String userLink = "otheruser.jsp?username="
									+ user.getUsername();
							String acceptRequest = "acceptRequest.jsp?username="
									+ user.getUsername();

							String rejectRequest = "rejectRequest.jsp?username="
									+ user.getUsername();
		%>
		<tr>
			<td><a
				href="<%=userLink%>"><%=user.getFname()%> <%=user.getLname() %></a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="<%=acceptRequest%>" style="text-decoration: none;">Accept
					Request</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="<%=rejectRequest%>" style="text-decoration: none;">Reject
					Request</a></td>


		</tr>

		<%
			}
					}
		%>



	</table>

	<%
		}

		}
	%>





	<br>
	<br>












	<!-- Show user sent requests which are pending or user can cancel the request -->

	<b> Requests sent by You:</b>



	<%
		Map<String, String> showSentRequest = null;
		Map<String, String> updateShowSentRequest = null;
		if (session == null || session.getAttribute("username") == null) {
			response.sendRedirect("index.jsp");
		} else {

			if (session != null
					&& session.getAttribute("showSentRequest") != null) {
				showSentRequest = (HashMap<String, String>) session
						.getAttribute("showSentRequest");

			}

			//updateShowSentRequest = Request.showSentRequest(username);

			showSentRequest = Request.updateShowSentRequest(
					showSentRequest, updateShowSentRequest);

			session.setAttribute("showSentRequest", showSentRequest);

			if (showSentRequest == null || showSentRequest.isEmpty()) {
	%>
	No Request sent from you are pending

	<%
		} else {
				// Show pending requests
	%>

	<table border="1">

		<%
			// if showSentRequest List is not empty.
					if (showSentRequest.size() > 0) {
						Iterator listIterator = showSentRequest.entrySet()
								.iterator();
						int i = 0;
						while (listIterator.hasNext()) {
							i++;
							Map.Entry pairs = (Map.Entry) listIterator.next();
							String userLink = "otheruser.jsp?username="
									+ pairs.getKey().toString();

							String cancelRequest = "cancelRequest.jsp?username="
									+ pairs.getKey().toString();
		%>
		<tr>
			<td><%=i%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
				href="<%=userLink%>"><%=pairs.getValue().toString()%></a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Request
				Sent&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="<%=cancelRequest%>" style="text-decoration: none;">Cancel
					Sent Request</a></td>


		</tr>

		<%
			}
					}
		%>



	</table>

	<%
		}

		}
	%>







	<br>
	<br> Your current Neighbours List


	<!-- Show Neighbours List -->



	<%
		List<User> neighbourList = null;
		if (session == null || session.getAttribute("username") == null) {
			response.sendRedirect("index.jsp");
		} else {

			neighbourList = Neighbours.getNeighboursList(username);

			if (neighbourList.isEmpty()) {
	%>
	You dont have any neighbours. Please check Recommendation List or
	search for your neighbours
	<%
		} else {
	%>

	<table border="1">

		<%
			// if neighbour List is not empty.
					if (neighbourList.size() > 0) {
						for(int index=0;index<neighbourList.size();index++) {
							
							User user=neighbourList.get(index);
							String userLink = "otheruser.jsp?username="
									+ user.getUsername();

							String fullname = user.getUsername();
		%>
		<tr>
			<td><a
				href="<%=userLink%>" style="text-decoration: none;"><%=fullname%></a></td>


		</tr>

		<%
			}
					}
		%>



	</table>

	<%
		}

		}
	%>


	<br>
	<br>

	<h3>Updates:</h3>

	<%
		neighbourList = null;
		if (session == null || session.getAttribute("username") == null) {
			response.sendRedirect("index.jsp");
		} else {

			neighbourList = Neighbours.getNeighboursList(username);

			if (neighbourList.isEmpty()) {
	%>
	You dont have any neighbours.Please add our neighbours to get updates
	from them.
	<%
		} else {

				List<String> updates = (ArrayList<String>) Neighbours
						.getUpdatesFromNeighbours(username);

				if (updates.isEmpty()) {
	%>

	No updates from ur neighbours
	<%
		} else {
	%>
	<table border="1">
		<%
			for (int i = 0; i < updates.size(); i++) {
							String record = updates.get(i);
						/* 	System.out.println(record);
						 */	String[] record_split = record.split("~");
							/* System.out.println(record_split.length);
							 */String user = record_split[1];
							String userLink = "otheruser.jsp?username=" + user;
							String fullname = Neighbours.getFullName(user);
							String post_id=record_split[0];
							String post = record_split[2];
							String date = record_split[3];
							String time = record_split[4];
		%>
		<tr>

			<td><a href="<%=userLink%>" style="text-decoration: none;"><%=fullname%></a>:
			<%=post%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<font size="2"><%=date%> &nbsp;&nbsp;&nbsp;<%=time%></font><br>
			<% 
					List<Post> updatesChild=(ArrayList<Post>)Neighbours.getChildList(post_id);
					for(Post childPost: updatesChild)
					{
					
					String childLink="otheruser.jsp?username=" + childPost.getUsername();
					String[] date_time_split=childPost.getDate_time().split(" ");
					String childDate=date_time_split[0];
					String childTime=date_time_split[1];
					%>
						<a href="<%=childLink%>" style="text-decoration: none;"><%=Neighbours.getFullName(childPost.getUsername())%></a>:
							<%=childPost.getPost()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<font size="2"><%=childDate%>&nbsp;&nbsp;&nbsp;<%=childTime%></font><br>
						
						<% 
						
					}
					
					
					%>
			<form name="updateReplyForm" method="post"
					onsubmit="return validateUpdateReply();" action="UpdateStatusReply">
					<textarea rows="2" cols="10" name="updateReply" id="updateReply"></textarea>
					<br>
					
					<font size="2"><input type="submit" value="Reply" /></font>
					<input type="hidden" name="post_id" value="<%=post_id %>" />
					<input type="hidden" name="username" value="<%=username %>" />
				</form></td>

		</tr>
		<%
			}
		%>
	</table>
	<%
		}
			}

		}
	%>







	<div>
		<form action="LogOut" method="get">
			<input type="submit" value="Log Out" />
		</form>
	</div>
</body>
</html>