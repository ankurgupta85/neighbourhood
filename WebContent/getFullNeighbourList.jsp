<%@page import="com.neighbourhood.status.NeighbourhoodStatus"%>
<%@page import="com.neighbourhood.event.NeighbourEvent,com.neighbours.imageUpload.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page
	import="java.util.*,com.neighbourhood.neighbours.*,com.neighbourhood.user.*"%>
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

			} */
			/* 	System.out.println("In Get Full Neighbour List");
			 */
			String username = null;
			if (session != null && session.getAttribute("username") != null) {
				username = session.getAttribute("username").toString();
			} else {
				response.sendRedirect("index.jsp");
			}

			String otherUser = null;
			if (session.getAttribute("otherUser") == null) {
				String userRequest = request.getQueryString();
				String[] splitRequest = userRequest.split("=");
				otherUser = splitRequest[1];
				session.setAttribute("otherUser", otherUser);
			} else {
				otherUser = session.getAttribute("otherUser").toString();

			}
			//check if the current user and otheruser are neighbours

			if (NeighbourhoodStatus.getNeighboursStatus(username, otherUser)
					.equals(NeighbourhoodStatus.NEIGHBOURS)) {

				// Show neighbours list of user.
				List<User> neighbourList = null;

				neighbourList = Neighbours.getNeighboursList(otherUser);

				%>
				<br>
		<br> <b><font size="2"
			style="font-family: cursive; color: black; background-color: white;"><%=Neighbours.getFullName(otherUser) %> Neighbours</font></b>
		<br><br>
		
				<% 
				if (neighbourList.isEmpty()) {
		%>
		<br>
		<br> <b><font size="2"
			style="font-family: cursive; color: black; background-color: white;"><%=Neighbours.getFullName(otherUser) %> Neighbours</font></b>
		<br><br>
		<font size="2"
			style="font-family: cursive; color: black; background-color: white;"><%=otherUser%>
			dont have any neighbours. Please help him find some.</font>

		<%
			} else {

					// Implement paging...

					final int NUMBER_OF_RECORDS_PERPAGE_DEFAULT = 10;

					int numPages = 0;

					int numRows = neighbourList.size();
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
								+ "<a href=\"getFullNeighbourList.jsp?startIndex="
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
			<table border="0" width="80%">
	
			<tr>
				<td width="43%" scope="col" class="HdrParagraph">
					<%
						if (startIndex != 0) {
					%> <a
					href="getFullNeighbourList.jsp?startIndex=<%=startIndex - numRecordsPerPage%>&txtnumrec=<%=numRecordsPerPage%>"
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
							href="getFullNeighbourList.jsp?startIndex=<%=startIndex + numRecordsPerPage%>&txtnumrec=<%=numRecordsPerPage%>"
							style="text-decoration: none;"><font size="1.5" color="black"
							style="font-family: cursive;">Next</font></a>
						<%
							}
						%>
					</div>
				</td>
			</tr>
		</table>







		<table border="0" width="50%">
		
						<%
									// if neighbour List is not empty.
															for (int index = startIndex; index < increment; index++) {
																User user = neighbourList.get(index);
																String userLink = "otheruser.jsp?username="
																		+ user.getUsername();

																String fullNeighbourname = user.getFname() + " "
																		+ user.getLname();
																String userImagePath = RetrieveImage.getProfileImagePath(user
																		.getUsername());
																String userProfilePicName = RetrieveImage
																		.getProfilePicName(user.getUsername());
								%>
						<tr>
							<td><font size="2"
								style="font-family: cursive; color: black; background-color: white;"><img
						src="<%=userImagePath%>" alt="<%=user.getUsername()%>" width="20"
						height="20"
						onclick="window.open('<%=userImagePath%>', '<%=userProfilePicName%>', 'width=300,height=300,resizabel=yes,toolbar=no,left=200,top=200')" /><a
									href="<%=userLink%>" style="text-decoration: none;color: black;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=fullNeighbourname%></a></font></td>


			<td><font size="2"
					style="font-family: cursive; color: black; background-color: white;"><a
						href="<%=userLink%>" target="main"
						style="text-decoration: none; color: black;"><%=user.getUsername()%></a></font></td>


				<td><font size="2"
					style="font-family: cursive; color: black; background-color: white;"><%=user.getZipcode()%></font></td>



						</tr>


						<%
							}
						%>
					</table>
			
		<%
			}

			}

			else {
		%>
		<font size="2"
			style="font-family: cursive; color: black; background-color: white;">You
			are not neighbour of <%=otherUser%>
		</font>
		<%
			}
		%>



	</center>
</body>
</html>