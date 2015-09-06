<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page
	import="java.util.*,com.neighbourhood.user.*,com.neighbourhood.message.*,com.neighbourhood.neighbours.Neighbours"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript" src="disableRightClick.js"></script>
</head>
<body>
	<center>
	<br><br>
		<font size="2"
			style="font-family: cursive; color: black; background-color: white;">Unread
			Messages:</font> <br>

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

			String username = null;

			if (session == null || session.getAttribute("username") == null) {
				response.sendRedirect("index.jsp");
			} else {
				username = session.getAttribute("username").toString();
			}

			List<MessageInfo> unreadMessageList = MessageInfo
					.getUnreadMessages(username);
		%>
		<br>
		<%
			if (unreadMessageList.size() == 0) {
		%>
		<font size="2"
			style="font-family: cursive; color: black; background-color: white;">You
			dont have any unread messages</font>
		<%
			} else {
		%>

		<br>
		<br>

	
			<%
				// Implement Paging....
					final int NUMBER_OF_RECORDS_PERPAGE_DEFAULT = 10;

					int numPages = 0;

					int numRows = unreadMessageList.size();
					String startIndexString = request.getParameter("startIndex");
					if ((startIndexString == null)
							|| (startIndexString.length() == 0)) { //for pagination if page is loaded first time
						startIndexString = "0";
					}

					int startIndex = Integer.parseInt(startIndexString);
					int numRecordsPerPage = 0;
					if (request.getParameter("txtnumrec") == null)
						numRecordsPerPage = NUMBER_OF_RECORDS_PERPAGE_DEFAULT;
					else
						numRecordsPerPage = Integer.parseInt(request
								.getParameter("txtnumrec"));

					numPages = numRows / numRecordsPerPage;
					int remain = numRows % numRecordsPerPage;
					if (remain != 0)
						numPages = numPages + 1;

					int startpoint = 0;
					String temp = "";
					for (int inum = 1; inum <= numPages; inum++) {
						temp = temp
								+ "<a href=\"showAllUnreadMessages.jsp?startIndex="
								+ startpoint + "&txtnumrec=" + numRecordsPerPage
								+ "\" >" + inum + "</a> ";
						startpoint = startpoint + numRecordsPerPage;
					}

					int increment = 0;
					if ((startIndex + numRecordsPerPage) <= numRows) {

						increment = startIndex + numRecordsPerPage;
					} else {

						if (remain == 0) {
							increment = startIndex + numRecordsPerPage;
						} else {
							increment = startIndex + remain;
						}//end of inner if
					}//end of if
			%>

			<%-- 	   <%=numRows%>
		Record(s) found
	
		Displaying records:
		<%
		if (startIndex + numRecordsPerPage < numRows) {
	%>
		<%=startIndex + 1%>
		-
		<%=increment%>
		<%
			} else {
		%>
		<%=startIndex + 1%>
		-
		<%=numRows%>
		<%
			}
		%>
	
 --%>
	<table border="0" width="80%" > 

			<tr>
				<td width="43%" scope="col" class="HdrParagraph">
					<%
						if (startIndex != 0) {
					%> <a
					href="showAllUnreadMessages.jsp?startIndex=<%=startIndex - numRecordsPerPage%>&txtnumrec=<%=numRecordsPerPage%>"
					style="text-decoration: none;"><font size="1.5" color="black"
						style="font-family: cursive;">Previous</font></a> <%
 	}
 %>
				</td>
				<%-- <td width="20%" scope="col" class="HdrParagraph">Page:<%=temp%></td> --%>
				<td width="37%" align="right" class="HdrParagraph">
					<div align="right">
						<%
							if (startIndex + numRecordsPerPage < numRows) {
						%>
						<a
							href="showAllUnreadMessages.jsp?startIndex=<%=startIndex + numRecordsPerPage%>&txtnumrec=<%=numRecordsPerPage%>"
							style="text-decoration: none;"><font size="1.5" color="black"
							style="font-family: cursive;">Next</font></a>
						<%
							}
						%>
					</div>
				</td>
			</tr>
		</table>






		<table width="50%" border="0">



			<%
				for (int index = startIndex; index < increment; index++) {
						MessageInfo message = unreadMessageList.get(index);
			%>
			<tr>
				<td width="33%" colspan="2"><a
					href="otheruser.jsp?username=<%=message.getSender()%>"
					target="main" style="text-decoration: none;"><font size="2"
						style="font-family: cursive; color: black; background-color: white;"><%=Neighbours.getFullName(message.getSender())%></font></a></td>


				<td width="33%"><b><a
						href="showmessage.jsp?messageid=<%=message.getMessageID()%>;UNREAD"
						target="main" style="text-decoration: none;"><font size="2"
							style="font-family: cursive; color: black; background-color: white;"><%=message.getMessageTopic()%></font></a></b></td>


				<td width="33%"><font size="2"
					style="font-family: cursive; color: black; background-color: white;"><%=message.getDate_time()%></font></td>
			</tr>

			<%
				}
			%>
		</table>
		<%
			}

			unreadMessageList.clear();
		%>



	</center>
</body>
</html>