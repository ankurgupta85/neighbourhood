<%@page import="com.neighbours.imageUpload.RetrieveImage"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
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

		<br> <br> <b><font size="2"
			style="font-family: cursive; color: black; background-color: white;">Neighbours</font></b>


		<%
			if (session.getAttribute("currentUserNeighbour") != null) {
				session.removeAttribute("currentUserNeighbour");
			}
			if (session.getAttribute("otherUser") != null) {
				session.removeAttribute("otherUser");
			}

			/* if (session.getAttribute("eventTopic") != null) {
				session.removeAttribute("eventTopic");
				session.removeAttribute("eventDescription");
				session.removeAttribute("date_time_event");
				session.removeAttribute("flag");

			} */
			String username = session.getAttribute("username").toString();
			List<User> neighbourList = Neighbours.getNeighboursList(username);

			if (neighbourList.isEmpty()) {
		%>
		<font size="2"
			style="font-family: cursive; color: black; background-color: white;">You
			dont have any neighbours. Please check Recommendation List or search
			for your neighbours</font>
		<%
			} else {
		%>




		<br> <br>


		<%
			// Implement paging...

				final int NUMBER_OF_RECORDS_PERPAGE_DEFAULT = 10;

				int numPages = 0;

				int numRows = neighbourList.size();
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
					temp = temp + "<a href=\"showneighbours.jsp?startIndex="
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
		<table border="0" width="80%">
			<tr>
				<td width="43%" scope="col" class="HdrParagraph">
					<%
						if (startIndex != 0) {
					%> <a
					href="showneighbours.jsp?startIndex=<%=startIndex - numRecordsPerPage%>&txtnumrec=<%=numRecordsPerPage%>"
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
							href="showneighbours.jsp?startIndex=<%=startIndex + numRecordsPerPage%>&txtnumrec=<%=numRecordsPerPage%>"
							style="text-decoration: none;"><font size="1.5" color="black"
							style="font-family: cursive;">Next</font></a>
						<%
							}
						%>
					</div>
				</td>
			</tr>
		</table>







		<table border="0" align="center" cellpadding="3" cellspacing="3"
			width="50%">

			<%
				// if neighbour List is not empty.
					for (int index = startIndex; index < increment; index++) {
						User user = neighbourList.get(index);
						String userLink = "otheruser.jsp?username="
								+ user.getUsername();
						String otherUser=user.getUsername();
						String removeLink = "removeneighbour.jsp?username="
								+ user.getUsername();
						String fullname = user.getFname() + " " + user.getLname();
						String userImagePath = RetrieveImage
								.getProfileImagePath(user.getUsername());
						String userProfilePicName = RetrieveImage
								.getProfilePicName(user.getUsername());
			%>
			<tr>
				<td><font size="2"
					style="font-family: cursive; color: black; background-color: white;"><img
						src="<%=userImagePath%>" alt="<%=user.getUsername()%>" width="20"
						height="20"
						onclick="window.open('<%=userImagePath%>', '<%=userProfilePicName%>', 'width=300,height=300,resizabel=yes,toolbar=no,left=200,top=200')" /><a
						href="<%=userLink%>" target="main" style="text-decoration: none;"><font
							size="2"
							style="font-family: cursive; color: black; background-color: white;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=fullname%></font></a></font></td>




				<td><font size="2"
					style="font-family: cursive; color: black; background-color: white;"><a
						href="<%=userLink%>" target="main"
						style="text-decoration: none; color: black;"><%=user.getUsername()%></a></font></td>


				<td>
						<font size="2"
					style="font-family: cursive; color: black; background-color: white;"><a
						href="showneighboursForZipcode.jsp?zipcode=<%=user.getZipcode() %>"  target="main"
						style="text-decoration: none;color: black;"><%=user.getZipcode()%></a></font></td>
			
				<td><font size="1"
					style="font-family: cursive; color: black; background-color: white; text-align: right;"><a
						href="<%=removeLink%>" style="color: black; font-size: 1;text-decoration: none;"  target="_top">Remove</a></font></td>

				
				<%
				String blockupdates = "blockupdates.jsp?username=" + otherUser;
				String unblockupdates = "unblockupdates.jsp?username="
						+ otherUser;
				
				
				if (Neighbours.isBlocked(username, otherUser)) {
			%>
			<td width="auto"><font size="1"
				style="font-family: cursive; color: black; background-color: white;"><a
					href="<%=unblockupdates%>"
					style="color: black; font-size: 1; text-decoration: none;"
					target="_top">Unblock Updates</a></font></td>

			<%
				}
				else
				{
			%>
						<td width="auto"><font size="1"
				style="font-family: cursive; color: black; background-color: white;"><a
					href="<%=blockupdates%>"
					style="color: black; font-size: 1; text-decoration: none;"
					target="_top">Block Updates</a></font></td>
		<%
				}
					
		%>
				
				
			
			</tr>

			<%
				}
				}
			%>



		</table>

		<%%>



	</center>
</body>
</html>