<%@page import="com.neighbourhood.user.*"%>
<%@page import="com.neighbourhood.user.RetrieveMessage"%>
<%@page import="com.neighbourhood.message.MessageInfo"%>
<%@page import="java.util.List,java.util.ArrayList,java.util.Iterator"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript" src="disableRightClick.js"></script>
<script type="text/javascript" src="replymessage.js"></script>
</head>
<body bgcolor="white">
	<center>
		<%
			if (session.getAttribute("currentUserNeighbour") != null) {
				session.removeAttribute("currentUserNeighbour");
			}
			if (session.getAttribute("otherUser") != null) {
				session.removeAttribute("otherUser");
			}

		/* 	if (session.getAttribute("eventTopic") != null) {
				session.removeAttribute("eventTopic");
				session.removeAttribute("eventDescription");
				session.removeAttribute("date_time_event");
				session.removeAttribute("flag");

			} */

			/* System.out.println("In otherUser.jsp");
			 */String userMessage = request.getQueryString();
			String[] splitRequest = userMessage.split("=");
			String[] messageStatusSplit = splitRequest[1].split(";");
			int messageID = Integer.parseInt(messageStatusSplit[0]);
			String status = messageStatusSplit[1];
			MessageInfo message = RetrieveMessage.getMessage(messageID);
			String username = session.getAttribute("username").toString();
			if (message == null) {
		%>
		<font size="2"
			style="font-family: cursive; color: black; background-color: white;">Could
			not retrieve message. Please contact admin</font>

		<%
			}
			// TO DO Show whole message

			else {
				if (status.equals(MessageInfo.MESSAGE_STATUS_UNREAD)) {

					// Update message to READ
					boolean statusUpdated = MessageInfo.updateMessageStatus(
							messageID, username);
					if (!statusUpdated) {
						/* 		System.out.println("Message status not updated");
						 */
					}

				}
		%>
		<%
			// TO-DO --> Handle message in such a way to show all the previous messages 

				List<MessageInfo> messageList = (ArrayList<MessageInfo>) RetrieveMessage
						.getMessageList(messageID);
		%>
		<br>
		<table border="0" align="center" width="50%">
			<tr>
				<td><font size="2"
					style="font-family: cursive; color: black; background-color: white;">Message
						Topic:</font></td>
				<td><b><font size="2"
						style="font-family: cursive; color: black; background-color: white;"><%=message.getMessageTopic()%></font></b></td>
			</tr>
			<tr></tr>
			<%
				for (MessageInfo currentMessage : messageList) {

							String currentMessageSender = currentMessage.getSender();
							String userLink = "otheruser.jsp?username="
									+ currentMessageSender;
							User senderInfo = UserInfo
									.getUserInfoByUsername(currentMessageSender);
							String fullName = senderInfo.getFname() + " "
									+ senderInfo.getLname();
			%>
			
			<tr>
				<td width="auto"><a href="<%=userLink%>" target="main"
					style="text-decoration: none;"><font size="2"
						style="font-family: cursive; color: black; background-color: white;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=fullName%></font></a></td>
				<td width="auto"><font size="2"
					style="font-family: cursive; color: black; background-color: white;"><%=currentMessage.getMessage()%></font></td>
					<td width="auto"> <font size="1"
					style="font-family: cursive; color: black; background-color: white;"><%=currentMessage.getDate_time()%></font></td>
			</tr>
			<%
				}
			%>

		</table>
		<%
			}
		%>

		<br>
		<%-- <form method="post" onsubmit="return validateMessage();"
		style="visibility: hidden" name="messageForm" action=ReplyMessage>
		<textarea rows="3" cols="80" name="messageField" id="messageField"></textarea>
		<font size="1">(Maximum characters: 175)</font><br> <br> <input
			type="hidden" name="messageid" value="<%=messageID%>" />
		<input type="hidden" name="sender" value="<%=username%>" /> <input
			type="submit" value="Send Message" />

		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="reset"
			value="Cancel Message" onclick="hideText()" />
	</form>
 --%>
		<form method="post" onsubmit="return validateMessage();"
			name="messageForm" action=ReplyMessage>
			<textarea rows="3" cols="80" name="messageField" id="messageField"
				style="font-family: cursive; font-size: 2; color: black; background-color: white;"></textarea>
			<font size="1"
				style="font-family: cursive; color: black; background-color: white;">(Maximum
				characters: 175)</font><br> <br> <input type="hidden"
				name="messageid" value="<%=messageID%>" /> <input type="hidden"
				name="sender" value="<%=username%>" /> <input type="submit"
				value="Send Message"
				style="font-family: cursive; font-size: 2; color: black; background-color: white;" />

			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="reset"
				value="Cancel Message" onclick="hideText()"
				style="font-family: cursive; font-size: 2; color: black; background-color: white;" />
		</form>

		<br>
		<!-- <input type="button" value="Reply" id="sendMessage" name="sendMessage"
		onclick="activateMessageForm();" />
	<br> -->
		<br> <font size="2"
			style="font-family: cursive; color: black; background-color: white;"><a
			href="otheruser.jsp?username=<%=username%>"><font size="2"
				style="font-family: cursive; color: black; background-color: white;">Go
					back to home</font></a></font>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

		<%
			if (status.equals(MessageInfo.MESSAGE_STATUS_UNREAD)) {
		%>
		<font size="2"
			style="font-family: cursive; color: black; background-color: white;"><a
			href="showAllUnreadMessages.jsp"><font size="2"
				style="font-family: cursive; color: black; background-color: white;">Back
					to Unread Messages list</font></a></font>

		<%
			} else if (status.equals(MessageInfo.MESSAGE_STATUS_READ)) {
		%>
		<font size="2"
			style="font-family: cursive; color: black; background-color: white;"><a
			href="showAllReadMessages.jsp"><font size="2"
				style="font-family: cursive; color: black; background-color: white;">Back
					to Read Messages list</font></a></font>

		<%
			}
		%>
	</center>
</body>
</html>