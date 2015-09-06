<%@page import="com.neighbours.imageUpload.RetrieveImage"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page
	import="java.util.*,com.neighbourhood.recommendation.*,com.neighbourhood.user.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript" src="disableRightClick.js"></script>
</head>
<body bgcolor="white">
	<center><br><br>
	<b><font size="2"
			style="font-family: cursive; color: black; background-color: white;">Recommendations</font></b><br><br>
		<%
			if (session.getAttribute("currentUserNeighbour") != null) {
				session.removeAttribute("currentUserNeighbour");
			}
			if (session.getAttribute("otherUser") != null) {
				session.removeAttribute("otherUser");
			}

/* 			if (session.getAttribute("eventTopic") != null) {
				session.removeAttribute("eventTopic");
				session.removeAttribute("eventDescription");
				session.removeAttribute("date_time_event");
				session.removeAttribute("flag");

			} */
			//Recommendation List for the neighbours
			String username = session.getAttribute("username").toString();
			List<User> recommendationList = null;
			if (session != null
					&& session.getAttribute("recommendationList") != null) {
				recommendationList = (List<User>) session
						.getAttribute("recommendationList");

			}
			if (recommendationList == null) {
				recommendationList = RecommendationList.getRecommendation(
						username, Integer.parseInt(session.getAttribute(
								"zipcode").toString()));
				// Remove login username from the list
				recommendationList.remove(username);

				// Update the list with the neighbours who are not in neighbour table
				// Remove the ppl who are already in neighbour table and only keep those who doesnt exist in table.
				/* recommendationList = RecommendationList
						.updateRecommendationList(recommendationList, username); */
			}
			// set recommendationList in session so that the user can be removed from it after requst is sent to him
			/* session.setAttribute("recommendationList", recommendationList); */
			// if recommendation List is empty
			if (recommendationList.isEmpty()) {
		%>
		<font size="2"
			style="font-family: cursive; color: black; background-color: white;">No
			Recommendations Available</font> <br> <font size="2"
			style="font-family: cursive; color: black; background-color: white;">Please
			use search.</font>
		<%
			} else {
		%>
		<br>
		<%
			// Implement paging here...... 
				final int NUMBER_OF_RECORDS_PERPAGE_DEFAULT = 10;
				int numPages = 0;

				int numRows = recommendationList.size();
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
							+ "<a href=\"shownrecommendations.jsp?startIndex="
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
					href="shownrecommendations.jsp?startIndex=<%=startIndex - numRecordsPerPage%>&txtnumrec=<%=numRecordsPerPage%>"
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
							href="shownrecommendations.jsp?startIndex=<%=startIndex + numRecordsPerPage%>&txtnumrec=<%=numRecordsPerPage%>"
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
				// if recommendation List is not empty.
						for (int index = startIndex; index < increment; index++) {
							User user = recommendationList.get(index);
							String userLink = "otheruser.jsp?username="
									+ user.getUsername();
							String neighbourRequest = "neighbourRequest.jsp?username="
									+ user.getUsername();
							String userImage = RetrieveImage.getProfileImagePath(user
									.getUsername());
							String userProfilePic = RetrieveImage
									.getProfilePicName(user.getUsername());
							String userFullname = user.getFname() + " "
									+ user.getLname();
			%>
			<tr>
				<td align="left"><img src="<%=userImage%>"
					alt="<%=user.getUsername()%>" width="20" height="20"
					onclick="window.open('<%=userImage%>', '<%=userProfilePic%>', 'width=300,height=300,resizabel=yes,toolbar=no,left=200,top=200')" /><a
					href="<%=userLink%>" style="text-decoration: none;"><font
						size="2"
						style="font-family: cursive; color: black; background-color: white; text-align: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=userFullname%></font></a></td>
				<td align="right"><a href="<%=neighbourRequest%>" target="_top"
					style="text-decoration: none;"><font size="2"
						style="font-family: cursive; color: black; background-color: white; text-align: right;">Add
							neighbour</font></a></td>

			</tr>

			<%
				}
			%>
		</table>
		<%
			}
		%>

		<%
			/* session.removeAttribute("recommendationList"); */
		%>



	</center>
</body>
</html>