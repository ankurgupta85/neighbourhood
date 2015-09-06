<%@page import="com.neighbours.imageUpload.RetrieveImage"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="java.util.*,com.neighbourhood.request.*,com.neighbourhood.user.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript" src="disableRightClick.js"></script>
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

			}
 */
			String username = null;
			if (session == null || session.getAttribute("username") == null) {
				response.sendRedirect("index.jsp");
			} else {
				username = session.getAttribute("username").toString();
			}
			// show all pending request for current user
		%>

		<br> <br> <font size="2"
			style="font-family: cursive; color: black; background-color: white;"><b>Pending
				Request</b></font> <br>
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

				/* 	session.setAttribute("requestsFromList", requestsFromList);
				 */
				if (requestsFromList.isEmpty()) {
		%>
		<font size="2"
			style="font-family: cursive; color: black; background-color: white;">No
			pending requests</font>

		<%
			} else {
					// Show pending requests
		%>





		<%
			// Implement paging here...... 
					final int NUMBER_OF_RECORDS_PERPAGE_DEFAULT = 10;
					int numPages = 0;

					int numRows = requestsFromList.size();
					String startIndexString = request
							.getParameter("startIndex");
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
								+ "<a href=\"showAllPendingRequests.jsp?startIndex="
								+ startpoint + "&txtnumrec="
								+ numRecordsPerPage + "\" >" + inum + "</a> ";
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


		<table width="80%" border="0">

			<tr>
				<td width="43%" scope="col" class="HdrParagraph">
					<%
						if (startIndex != 0) {
					%> <a
					href="showAllPendingRequests.jsp?startIndex=<%=startIndex - numRecordsPerPage%>&txtnumrec=<%=numRecordsPerPage%>"
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
							href="showAllPendingRequests.jsp?startIndex=<%=startIndex + numRecordsPerPage%>&txtnumrec=<%=numRecordsPerPage%>"
							style="text-decoration: none;"><font size="1.5" color="black"
							style="font-family: cursive;">Next</font></a>
						<%
							}
						%>
					</div>
				</td>
			</tr>
		</table>

		<br>

		<table border="0" cellpadding="5" cellspacing="10" width="50%">
			<%
				// show records using paging......

							for (int i = startIndex; i < increment; i++) {

								User user = requestsFromList.get(i);
								String uname = user.getUsername();

								String userLink = "otheruser.jsp?username=" + uname;
								String acceptRequest = "acceptRequest.jsp?username="
										+ uname;

								String rejectRequest = "rejectRequest.jsp?username="
										+ uname;
								String fullname = user.getFname() + " "
										+ user.getLname();
								String imagePath = RetrieveImage.getProfileImagePath(user
										.getUsername());
								String imageName = RetrieveImage.getProfilePicName(user
										.getUsername());
			%>
			<tr>
				<td align="left"><img src="<%=imagePath%>" alt="<%=user.getUsername()%>"
					width="20" height="20"
					onclick="window.open('<%=imagePath%>', '<%=imageName%>', 'width=300,height=300,resizabel=yes,toolbar=no,left=200,top=200')" />
					<font size="2"
					style="font-family: cursive; color: black; background-color: white;"><a
						href="<%=userLink%>" target="main" style="text-decoration: none;"><font
							size="2"
							style="font-family: cursive; color: black; background-color: white;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=fullname%></font></a></font>
							<td align="right">
					<font size="1"
					style="font-family: cursive; color: black; background-color: white;"><a
						href="<%=acceptRequest%>" target="_top"
						style="text-decoration: none;"><font size="1"
							style="font-family: cursive; color: black; background-color: white;">Accept
								Request</font></a></font></td><td align="right"><font size="1"
					style="font-family: cursive; color: black; background-color: white;">
						<a href="<%=rejectRequest%>" target="_top"
						style="text-decoration: none;"><font size="1"
							style="font-family: cursive; color: black; background-color: white;">Reject
								Request</font></a>
				</font></td>


			</tr>

			<%
				}

					}
			%>



		</table>

		<%
			}
		%>

	</center>
</body>
</html>