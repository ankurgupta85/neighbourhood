<%@page import="com.neighbourhood.status.NeighbourhoodStatus"%>
<%@page import="com.neighbours.imageUpload.RetrieveImage"%>
<%@page import="com.neighbourhood.neighbours.Neighbours"%>
<%@page
	import="com.neighbourhood.search.SearchNeighbours,com.neighbourhood.user.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript" src="disableRightClick.js"></script>
</head>
<body bgcolor="white">

	<br>
	<br>
	<div align="center">
		<b><font size="2"
			style="font-family: cursive; color: black; background-color: white;">Search
				Results</font></b>
	</div>
	<br>
	<center>

		<%
			String username = null;
			if (session != null && session.getAttribute("username") != null) {
				username = session.getAttribute("username").toString();
			} else {
				response.sendRedirect("index.jsp");
			}

			if (session.getAttribute("currentUserNeighbour") != null) {
				session.removeAttribute("currentUserNeighbour");
			}
			if (session.getAttribute("otherUser") != null) {
				session.removeAttribute("otherUser");
			}
			/* 		if (session.getAttribute("eventTopic") != null) {
						session.removeAttribute("eventTopic");
						session.removeAttribute("eventDescription");
						session.removeAttribute("date_time_event");
						session.removeAttribute("flag");

					}
			 */List<User> searchResults = (List<User>) session
					.getAttribute("searchResult");

			if (searchResults == null || searchResults.size() == 0) {
		%>

		<b><font size="2"
			style="font-family: cursive; color: black; background-color: white;">There
				are no results for the query you entered. Please try again.</font></b>
		<%
			} else {

				// Implement paging....

				final int NUMBER_OF_RECORDS_PERPAGE_DEFAULT = 10;

				int numPages = 0;

				int numRows = searchResults.size();
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
					temp = temp + "<a href=\"search.jsp?startIndex="
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
		<table width="80%" border="0">
			<tr>
				<td width="43%" scope="col" class="HdrParagraph">
					<%
						if (startIndex != 0) {
					%> <a
					href="search.jsp?startIndex=<%=startIndex - numRecordsPerPage%>&txtnumrec=<%=numRecordsPerPage%>"
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
							href="search.jsp?startIndex=<%=startIndex + numRecordsPerPage%>&txtnumrec=<%=numRecordsPerPage%>"
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
				for (int index = startIndex; index < increment; index++) {
						User user = searchResults.get(index);
						String otherUser = user.getUsername();
						String userLink = "otheruser.jsp?username=" + otherUser;
						String imagePath = RetrieveImage.getProfileImagePath(user
								.getUsername());
						String removelink = "removeneighbour.jsp?username="
								+ otherUser;
						String profilePicName = RetrieveImage
								.getProfilePicName(user.getUsername());
						if (session.getAttribute("attribute").toString()
								.equals(SearchNeighbours.USERNAME)) {
							String fullNeighbourname = user.getFname() + " "
									+ user.getLname();
			%>
			<tr>
				<td align="left"><font size="2"
					style="font-family: cursive; color: black; background-color: white;"><img
						src="<%=imagePath%>" alt="<%=user.getUsername()%>" width="20"
						height="20"
						onclick="window.open('<%=imagePath%>', '<%=profilePicName%>', 'width=300,height=300,resizabel=yes,toolbar=no,left=200,top=200')" /><a
						href="<%=userLink%>" style="text-decoration: none;"><font
							size="2"
							style="font-family: cursive; color: black; background-color: white;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=otherUser%></font></a></font></td>
				<td align="left"><font size="2"
					style="font-family: cursive; color: black; background-color: white;"><a
						href="<%=userLink%>" style="text-decoration: none;"><font
							size="2"
							style="font-family: cursive; color: black; background-color: white;"><%=fullNeighbourname%></font></a></font></td>

				<td align="left"><font size="2"
					style="font-family: cursive; color: black; background-color: white; text-decoration: none;"><%=user.getZipcode()%></font></td>

				<%
					if (NeighbourhoodStatus.getNeighboursStatus(username,
										otherUser).equals(
										NeighbourhoodStatus.NEIGHBOURS)
										&& !username.equals(otherUser)) {
				%>
				<td><font size="1"
					style="font-family: cursive; color: black; background-color: white;"><a
						href="<%=removelink%>"
						style="color: black; font-size: 1; text-decoration: none;"
						target="_top">Remove</a></font></td>
				<%
					String blockupdates = "blockupdates.jsp?username="
											+ otherUser;
									String unblockupdates = "unblockupdates.jsp?username="
											+ otherUser;

									if (Neighbours.isBlocked(username, otherUser)) {
				%>
				<td width="auto"><font size="1.5"
					style="font-family: cursive; color: black; background-color: white;"><a
						href="<%=unblockupdates%>"
						style="color: black; font-size: 1; text-decoration: none;"
						target="_top">Unblock Updates</a></font></td>

				<%
					} else {
				%>
				<td width="auto"><font size="1.5"
					style="font-family: cursive; color: black; background-color: white;"><a
						href="<%=blockupdates%>"
						style="color: black; font-size: 1; text-decoration: none;"
						target="_top">Block Updates</a></font></td>
				<%
					}
								}
				%>


			</tr>

			<%
				} else if (session.getAttribute("attribute").toString()
								.equals(SearchNeighbours.NAME)) {
							String fullNeighbourname = user.getFname() + " "
									+ user.getLname();
			%>
			<tr>
				<td align="left"><font size="2"
					style="font-family: cursive; color: black; background-color: white;"><img
						src="<%=imagePath%>" alt="<%=user.getUsername()%>" width="20"
						height="20"
						onclick="window.open('<%=imagePath%>', '<%=profilePicName%>', 'width=300,height=300,resizabel=yes,toolbar=no,left=200,top=200')" /><a
						href="<%=userLink%>" style="text-decoration: none;"><font
							size="2"
							style="font-family: cursive; color: black; background-color: white;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=fullNeighbourname%></font></a></font></td>


				<td align="left"><font size="2"
					style="font-family: cursive; color: black; background-color: white;"><a
						href="<%=userLink%>" style="text-decoration: none;"><font
							size="2"
							style="font-family: cursive; color: black; background-color: white;"><%=user.getUsername()%></font></a></font></td>



				<td align="left"><font size="2"
					style="font-family: cursive; color: black; background-color: white;"><%=user.getZipcode()%></font></td>

				<%
					if (NeighbourhoodStatus.getNeighboursStatus(username,
										otherUser).equals(
										NeighbourhoodStatus.NEIGHBOURS)
										&& !username.equals(otherUser)) {
				%>
				<td><font size="1"
					style="font-family: cursive; color: black; background-color: white;"><a
						href="<%=removelink%>"
						style="color: black; font-size: 1; text-decoration: none;"
						target="_top">Remove</a></font></td>


				<%
					String blockupdates = "blockupdates.jsp?username="
											+ otherUser;
									String unblockupdates = "unblockupdates.jsp?username="
											+ otherUser;

									if (Neighbours.isBlocked(username, otherUser)) {
				%>
				<td width="auto"><font size="1.5"
					style="font-family: cursive; color: black; background-color: white;"><a
						href="<%=unblockupdates%>"
						style="color: black; font-size: 1; text-decoration: none;"
						target="_top">Unblock Updates</a></font></td>

				<%
					} else {
				%>
				<td width="auto"><font size="1.5"
					style="font-family: cursive; color: black; background-color: white;"><a
						href="<%=blockupdates%>"
						style="color: black; font-size: 1; text-decoration: none;"
						target="_top">Block Updates</a></font></td>
				<%
					}
								}
				%>








			</tr>

			<%
				} else if (session.getAttribute("attribute").toString()
								.equals(SearchNeighbours.ZIPCODE)) {

							String zipcode = user.getZipcode();
							String fullNeighbourname = Neighbours
									.getFullName(otherUser);
			%>
			<tr>
				<td align="left"><font size="2"
					style="font-family: cursive; color: black; background-color: white;"><img
						src="<%=imagePath%>" alt="<%=user.getUsername()%>" width="20"
						height="20"
						onclick="window.open('<%=imagePath%>', '<%=profilePicName%>', 'width=300,height=300,resizabel=yes,toolbar=no,left=200,top=200')" /><a
						href="<%=userLink%>" style="text-decoration: none;"><font
							size="2"
							style="font-family: cursive; color: black; background-color: white;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=fullNeighbourname%></font></a></font></td>
				<td align="left"><font size="2"
					style="font-family: cursive; color: black; background-color: white;"><a
						href="<%=userLink%>" style="text-decoration: none;"><font
							size="2"
							style="font-family: cursive; color: black; background-color: white;"><%=user.getUsername()%></font></a></font></td>
				<td align="left"><font size="2"
					style="font-family: cursive; color: black; background-color: white;"><%=zipcode%></font></td>

				<%
					if (NeighbourhoodStatus.getNeighboursStatus(username,
										otherUser).equals(
										NeighbourhoodStatus.NEIGHBOURS)
										&& !username.equals(otherUser)) {
				%>
				<td><font size="1"
					style="font-family: cursive; color: black; background-color: white;"><a
						href="<%=removelink%>" style="color: black; font-size: 1;text-decoration: none;"
						target="_top">Remove</a></font></td>


				<%
					String blockupdates = "blockupdates.jsp?username="
											+ otherUser;
									String unblockupdates = "unblockupdates.jsp?username="
											+ otherUser;

									if (Neighbours.isBlocked(username, otherUser)) {
				%>
				<td width="auto"><font size="1.5"
					style="font-family: cursive; color: black; background-color: white;"><a
						href="<%=unblockupdates%>"
						style="color: black; font-size: 1; text-decoration: none;"
						target="_top">Unblock Updates</a></font></td>

				<%
					} else {
				%>
				<td width="auto"><font size="1.5"
					style="font-family: cursive; color: black; background-color: white;"><a
						href="<%=blockupdates%>"
						style="color: black; font-size: 1; text-decoration: none;"
						target="_top">Block Updates</a></font></td>
				<%
					}
								}
				%>


			</tr>

			<%
				} else if (session.getAttribute("attribute").toString()
								.equals(SearchNeighbours.EMAIL)) {

							String zipcode = user.getZipcode();
							String fullNeighbourname = Neighbours
									.getFullName(otherUser);
			%>
			<tr>
				<td align="left"><font size="2"
					style="font-family: cursive; color: black; background-color: white;"><img
						src="<%=imagePath%>" alt="<%=user.getUsername()%>" width="20"
						height="20"
						onclick="window.open('<%=imagePath%>', '<%=profilePicName%>', 'width=300,height=300,resizabel=yes,toolbar=no,left=200,top=200')" /><a
						href="<%=userLink%>" style="text-decoration: none;"><font
							size="2"
							style="font-family: cursive; color: black; background-color: white;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=fullNeighbourname%></font></a></font></td>
				<td align="left"><font size="2"
					style="font-family: cursive; color: black; background-color: white;"><%=Neighbours.getEmail(otherUser)%></font></td>

				<td align="left"><font size="2"
					style="font-family: cursive; color: black; background-color: white;"><%=zipcode%></font></td>

				<%
					if (NeighbourhoodStatus.getNeighboursStatus(username,
										otherUser).equals(
										NeighbourhoodStatus.NEIGHBOURS)
										&& !username.equals(otherUser)) {
				%>
				<td><font size="1"
					style="font-family: cursive; color: black; background-color: white;"><a
						href="<%=removelink%>" style="color: black; font-size: 1;text-decoration: none;"
						target="_top">Remove</a></font></td>
				<%
					String blockupdates = "blockupdates.jsp?username="
											+ otherUser;
									String unblockupdates = "unblockupdates.jsp?username="
											+ otherUser;

									if (Neighbours.isBlocked(username, otherUser)) {
				%>
				<td width="auto"><font size="1.5"
					style="font-family: cursive; color: black; background-color: white;"><a
						href="<%=unblockupdates%>"
						style="color: black; font-size: 1; text-decoration: none;"
						target="_top">Unblock Updates</a></font></td>

				<%
					} else {
				%>
				<td width="auto"><font size="1.5"
					style="font-family: cursive; color: black; background-color: white;"><a
						href="<%=blockupdates%>"
						style="color: black; font-size: 1; text-decoration: none;"
						target="_top">Block Updates</a></font></td>
				<%
					}
								}
				%>

			</tr>

			<%
				}

					}

				}
			%>

		</table>
	</center>
</body>
</html>