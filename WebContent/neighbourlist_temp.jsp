<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page
	import="java.util.*,com.neighbourhood.neighbours.*,com.neighbourhood.recommendation.*"%>
<%@ page
	import="com.neighbours.imageUpload.RetrieveImage,java.io.*,com.neighbourhood.user.*"%>
<%@ page import="com.neighbourhood.request.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title></title>
<script type="text/javascript" src="disableRightClick.js"></script>
</head>
<body bgcolor="white">
	<center>

		<!-- Show Neighbours List -->



		<%
			if (session.getAttribute("currentUserNeighbour") != null) {
				session.removeAttribute("currentUserNeighbour");
			}
			if (session.getAttribute("otherUser") != null) {
				session.removeAttribute("otherUser");
			}
		/* 
			if (session.getAttribute("eventTopic") != null) {
				session.removeAttribute("eventTopic");
				session.removeAttribute("eventDescription");
				session.removeAttribute("date_time_event");
				session.removeAttribute("flag");

			} */
			String username = null;
			List<User> neighbourList = null;
			if (session == null || session.getAttribute("username") == null) {
				response.sendRedirect("index.jsp");
			} else {
				username = session.getAttribute("username").toString();
		String fullPath=RetrieveImage.getProfileImagePath(username);
		String profilePicName=RetrieveImage.getProfilePicName(username);
				/* 	String absPath = null;
				String fullPath = null;
				// show user Profile Pic 
				// check if user has profile pic set?
				// checking if profile pic is null.
				String profilePicName = RetrieveImage
						.getProfilePicName(username);

				// if profile pic is null, then show default pic and no need to check the pic in user folder
				if (profilePicName == null) {
					profilePicName = "defaultNoPic.ico";
					fullPath = "http://localhost:8080"
							+ pageContext.getServletContext().getContextPath()
							+ "/images_users/defaultNoPic.ico";

				}
				//user has profile pic
				else {
					// if user has profile pic, then check if the profile pic is in folder using absolute path
					// if profile pic is in folder then use that pic, else show default pic.
					absPath = pageContext.getServletContext().getInitParameter(
							"file-upload")
							+ username + "\\";
					File userDirectory = new File(absPath);
					String[] userFiles = userDirectory.list();
					boolean picFound = false;
					for (String userFile : userFiles) {
						// check if the pic is in the images folder of user
						if (userFile!=null && userFile.equals(profilePicName)) {
							picFound = true;
							break;
						}

					}

					// if pic found in the user image folder
					if (picFound) {
						fullPath = "http://localhost:8080"
								+ pageContext.getServletContext()
										.getContextPath() + "/images_users/"
								+ username + "/" + profilePicName;
					}
					// if pic found in the user image folder
					else {
						fullPath = "http://localhost:8080"
								+ pageContext.getServletContext()
										.getContextPath()
								+ "/images_users/defaultNoPic.ico";
					}

				}

				/* System.out.println(fullPath); */
		%>
		<img src="<%=fullPath%>" alt="<%=username%>" width="50" height="50"
			onclick="window.open('<%=fullPath%>', '<%=profilePicName%>', 'width=300,height=300,resizabel=yes,toolbar=no,left=200,top=200')" />
		<br> <font size="2"
			style="font-family: cursive; color: black; background-color: white;"><%=Neighbours.getFullName(username)%></font>
		<br> <font size="1"
			style="font-family: cursive; color: black; background-color: white;"><a
			href="changeUserPassword.jsp" target="main"
			style="text-decoration: none;"><font size="1"
				style="font-family: cursive; color: black; background-color: white; text-decoration: none;">Change
					Password</font></a></font>
					<br> <font size="1"
			style="font-family: cursive; color: black; background-color: white;"><a
			href="setProfilePic.jsp" target="main"
			style="text-decoration: none;"><font size="1"
				style="font-family: cursive; color: black; background-color: white; text-decoration: none;">Change Profile Pic</font></a></font> 
					<br> <br> <br>
		<%
			neighbourList = Neighbours.getNeighboursList(username);
		%>

		<font size="2"
			style="font-family: cursive; color: black; background-color: white;"><a
			href="showneighbours_temp.jsp" target="main"
			style="text-decoration: none;"><font size="2"
				style="font-family: cursive; color: black; background-color: white; text-decoration: none;">Neighbours</font>
					<font size="1"
				style="font-family: cursive; color: black; background-color: white; text-decoration: none;">(<%=Neighbours.getNeighboursListSize(username)%>)
			</font></a></font>
		<%
			}
		%>



		<br> <br>
		<%
			//Recommendation List for the neighbours
			List<User> recommendationList = RecommendationList
					.getRecommendation(username, Integer.parseInt((UserInfo
							.getUserInfoByUsername(username).getZipcode())));
			/* if (session != null
					&& session.getAttribute("recommendationList") != null) {
				recommendationList = (List<User>) session
						.getAttribute("recommendationList");

			}
			if (recommendationList == null) {
				recommendationList = RecommendationList.getRecommendation(
						username, Integer.parseInt((UserInfo
								.getUserInfo(username).getZipcode())));
				// Remove login username from the list
				recommendationList.remove(username);

				// Update the list with the neighbours who are not in neighbour table
				// Remove the ppl who are already in neighbour table and only keep those who doesnt exist in table.
				/* recommendationList = RecommendationList
						.updateRecommendationList(recommendationList, username); 
			}
			// set recommendationList in session so that the user can be removed from it after requst is sent to him
			session.setAttribute("recommendationList", recommendationList);
			 */
		%>
		<font size="2"
			style="font-family: cursive; color: black; background-color: white;"><a
			href="shownrecommendations.jsp" target="main"
			style="text-decoration: none;"><font size="2"
				style="font-family: cursive; color: black; background-color: white; text-decoration: none;">Recommendations	<font size="1"
				style="font-family: cursive; color: black; background-color: white; text-decoration: none;">(<%=recommendationList.size()%>)</font>
			</font></a></font> <br> <br> <font size="2"
			style="font-family: cursive; color: black; background-color: white;">
			<a href="showAllPendingRequests.jsp" target="main"
			style="text-decoration: none;"><font size="2"
				style="font-family: cursive; color: black; background-color: white; text-decoration: none;">Pending
					Requests	<font size="1"
				style="font-family: cursive; color: black; background-color: white; text-decoration: none;"> (<%=ShowPendingRequests.getPendingRequestCount(username)%>)</font>
			</font> </a>
		</font> <br>
		<%-- <br>
	<!-- Show  pending requests to accept or decline-->
	<%
		Map<String, String> requestsFromList = null;
		if (session == null || session.getAttribute("username") == null) {
			response.sendRedirect("index.jsp");
		} else {

			if (session != null
					&& session.getAttribute("requestsFromList") != null) {
				requestsFromList = (HashMap<String, String>) session
						.getAttribute("requestsFromList");

			}

			if (requestsFromList == null) {
				requestsFromList = ShowPendingRequests
						.getPendingRequestToAccept(username);
			}

			session.setAttribute("requestsFromList", requestsFromList);

			if (requestsFromList.isEmpty()) {
	%>
	<font size="2" style="font-family: cursive;">No pending requests</font>

	<%
		} else {
				// Show pending requests
	%>

	<table border="1">

		<%
			// if requestfrom/pendingrequest List is not empty.
					if (requestsFromList.size() > 0) {
						Iterator listIterator = requestsFromList.entrySet()
								.iterator();
						int i = 1;
						while (listIterator.hasNext() && i <= 4) {
							i++;
							Map.Entry pairs = (Map.Entry) listIterator.next();
							String userLink = "otheruser.jsp?username="
									+ pairs.getKey().toString();
							String acceptRequest = "acceptRequest.jsp?username="
									+ pairs.getKey().toString();

							String rejectRequest = "rejectRequest.jsp?username="
									+ pairs.getKey().toString();
		%>
		<tr>
			<td><font size="2" style="font-family: cursive;"><a
				href="<%=userLink%>" target="main"><%=pairs.getValue().toString()%></a></font>
				<br><font size="1"
							style="font-family: cursive;"> <a href="<%=acceptRequest%>">Accept
					Request</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="<%=rejectRequest%>"
				target="_top">Reject Request</a></font></td>


		</tr>

		<%
			}

						if (requestsFromList.size() > 4) {
		%>
		<tr>
			<td></td>
		</tr>
		<tr>
			<td><font size="2" style="font-family: cursive;"><b><a
						href="showAllPendingRequests.jsp" target="main">Show all Pending
							Requests</a></b></font></td>
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





 --%>






		<!-- Show user sent requests which are pending or user can cancel the request -->

		<br>

		<%
			List<User> showSentRequest = null;
			//	Map<String, String> updateShowSentRequest = null;
			if (session == null || session.getAttribute("username") == null) {
				response.sendRedirect("index.jsp");
			} else {

				if (session != null
						&& session.getAttribute("showSentRequest") != null) {
					showSentRequest = (List<User>) session
							.getAttribute("showSentRequest");

				}

				showSentRequest = Request.showSentRequest(username);

				//showSentRequest = Request.updateShowSentRequest(
				//showSentRequest, updateShowSentRequest);

				if (showSentRequest == null) {
					showSentRequest = new ArrayList<User>();
				}
				session.setAttribute("showSentRequest", showSentRequest);
		%>
		<font size="2"
			style="font-family: cursive; color: black; background-color: white;"><a
			href="showAllSentRequests.jsp" target="main"
			style="text-decoration: none;"><font size="2"
				style="font-family: cursive; color: black; background-color: white; text-decoration: none;">Show
					Sent Request <font size="1"
				style="font-family: cursive; color: black; background-color: white; text-decoration: none;">(<%=showSentRequest.size()%>)</font>
			</font> </a></font>
		<%
			}
		%>





	</center>
</body>
</html>