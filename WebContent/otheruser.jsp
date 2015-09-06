<%@page import="com.neighbourhood.user.UserInfo"%>
<%@page import="com.neighbourhood.user.User"%>
<%@page import="com.neighbours.imageUpload.RetrieveImage"%>
<%@page
	import="com.neighbourhood.neighbours.Neighbours,com.neighbourhood.post.*"%>
<%@page
	import="com.neighbourhood.status.NeighbourhoodStatus,java.util.*,java.io.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<style type="text/css">
textarea {
	resize: none;
}
</style>
<script type="text/javascript" src="otheruser.js"></script>
<!-- <script type="text/javascript" src="disableRightClick.js"></script> -->
<%
	String username = null;
	if (session == null || session.getAttribute("username") == null) {
		response.sendRedirect("index.jsp");
	} else {

		username = session.getAttribute("username").toString();
	}
	String otherUser = null;

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
	/* if (session.getAttribute("currentUserNeighbour") == null) { */

	/* 	System.out.println("In otherUser.jsp");
	 */String userRequest = request.getQueryString();
	String[] splitRequest = userRequest.split("=");
	otherUser = splitRequest[1];
	session.setAttribute("currentUserNeighbour", otherUser);
	/* } else {
		otherUser = session.getAttribute("currentUserNeighbour")
				.toString();
	} */
	if (otherUser.equals(session.getAttribute("username").toString())) {
		response.sendRedirect("postUpdates.jsp");
	}
%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><%=Neighbours.getFullName(otherUser)%></title>
</head>
<body bgcolor="white">
	<center>
		<br> <br>
		<%
			if (session == null || session.getAttribute("username") == null) {
				response.sendRedirect("index.jsp");
			}

			if (session.getAttribute("messageSent") != null) {
		%>

		<font size="2"
			style="font-family: cursive; color: black; background-color: white;"><%=session.getAttribute("messageSent").toString()%></font>
		<br> <br>

		<%
			session.removeAttribute("messageSent");
			}
		%>





		<%
			String status = NeighbourhoodStatus.getNeighboursStatus(session
					.getAttribute("username").toString(), otherUser);

			if (status.equals(NeighbourhoodStatus.NOT_NEIGHBOURS)
					|| status
							.equals(NeighbourhoodStatus.REQUEST_FOR_NEIGHBOURS)) {
		%>


		<font size="2"
			style="font-family: cursive; color: black; background-color: white;">Not
			neighbours ... You need to be neighbours to see information of <%=otherUser%>(<%=Neighbours.getFullName(otherUser)%>)
		</font>
		<%
			String neighbourRequest = "neighbourRequest.jsp?username="
						+ otherUser;
		%>
		<br> <br> <font size="2"
			style="font-family: cursive; color: black; background-color: white;"><a
			href="<%=neighbourRequest%>" target="_top"
			style="text-decoration: none;"><font size="2"
				style="font-family: cursive; color: black; background-color: white;">Send
					Neighbour Request</font></a></font>


		<%
			}
			// IF neighbours
			// give links to write message, show all pics, show all neighbours
			else if (status.equals(NeighbourhoodStatus.NEIGHBOURS)) {
		%>
		<%-- <font size="2"
			style="font-family: cursive; color: black; background-color: white;">You
			and <%=Neighbours.getFullName(otherUser)%> are Neighbours. You will
			have access to all the information that a neighbour needs.
		</font> <br>
 --%>
		<%
			String profilePicName = RetrieveImage
						.getProfilePicName(otherUser);
				String removelink = "removeneighbour.jsp?username=" + otherUser;
				String blockupdates = "blockupdates.jsp?username=" + otherUser;
				String unblockupdates = "unblockupdates.jsp?username="
						+ otherUser;
				String fullPath = RetrieveImage.getProfileImagePath(otherUser);
				/* String fullPath = null;
						String absPath = null;
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
									+ otherUser + "\\";
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
										+ otherUser + "/" + profilePicName;
							}
							// if pic found in the user image folder
							else {
								fullPath = "http://localhost:8080"
										+ pageContext.getServletContext()
												.getContextPath()
										+ "/images_users/defaultNoPic.ico";
							}

						}
				 *//* 
					 System.out.println(fullPath);
					 */
		%>

		<table>
			<tr>
				<td width="40%" align="center"><img src="<%=fullPath%>"
					alt="<%=otherUser%>" width="50" height="50"
					onclick="window.open('<%=fullPath%>', '<%=profilePicName%>', 'width=300,height=300,resizabel=yes,toolbar=no,left=200,top=200')" />
					<br> <font size="2"
					style="font-family: cursive; color: black; background-color: white;"><%=Neighbours.getFullName(otherUser)%></font>
				</td>
				<td></td>
				<td></td>
				<td width="60%">
					<table border="0" cellspacing="5" cellpadding="5">
						<tr>
							<td width="auto"><font size="1.5"
								style="font-family: cursive; color: black; background-color: white;"><a
									href="writeMessage.jsp?sendMessageTo=<%=otherUser%>"
									style="text-decoration: none;"><font size="1.5"
										style="font-family: cursive; color: black; background-color: white;">Write
											Message</font></a></font></td>
							<td width="auto"><font size="1.5"
								style="font-family: cursive; color: black; background-color: white;"><a
									href="getFullNeighbourList.jsp?user=<%=otherUser%>"
									style="text-decoration: none;"><font size="1.5"
										style="font-family: cursive; color: black; background-color: white;">View
											Neighbours</font></a></font></td>
							<td width="auto"><font size="1.5"
								style="font-family: cursive; color: black; background-color: white;"><a
									href="showImages.jsp?user=<%=otherUser%>"
									style="text-decoration: none;"><font size="1.5"
										style="font-family: cursive; color: black; background-color: white;">View
											all Pics</font></a></font></td>
							<td width="auto"><font size="1.5"
								style="font-family: cursive; color: black; background-color: white;"><a
									href="<%=removelink%>"
									style="color: black; font-size: 1; text-decoration: none;"
									target="_top">Remove</a></font></td>

							<%
								if (Neighbours.isBlocked(username, otherUser)) {
							%>
							<td width="auto"><font size="1.5"
								style="font-family: cursive; color: black; background-color: white;"><a
									href="<%=unblockupdates%>"
									style="color: black; font-size: 1; text-decoration: none;"
									target="_top">Unblock Updates</a></font></td>

							<%
								}
								else
								{
							%>
										<td width="auto"><font size="1.5"
								style="font-family: cursive; color: black; background-color: white;"><a
									href="<%=blockupdates%>"
									style="color: black; font-size: 1; text-decoration: none;"
									target="_top">Block Updates</a></font></td>
						<%
								}
						%>
						</tr>

					</table>
				</td>
			</tr>
		</table>
		<%
			String name = Neighbours.getFullName(otherUser);
		%>


		<br>


		<%-- <%
		// Show neighbours list of user.
			Map<String, String> neighbourList = null;

			neighbourList = Neighbours.getNeighboursList(otherUser);

			if (neighbourList.isEmpty()) {
	%>
	<font size="2"  style="font-family: cursive;"><%=name%>
	dont have any neighbours. Please help him find some.</font>

	<%
		} else {
	%>
	<table border="1">
	
		<tr>
			<td><font size="2"  style="font-family: cursive;"><%=name%> Neighbour List</font> <br>
				<table border="1">

					<%
						// if neighbour List is not empty.
								if (neighbourList.size() > 0) {
									Iterator listIterator = neighbourList.entrySet()
											.iterator();
									int i = 0;
									while (listIterator.hasNext()) {
										i++;
										Map.Entry pairs = (Map.Entry) listIterator.next();
										String userLink = "otheruser.jsp?username="
												+ pairs.getKey().toString();

										String fullNeighbourname = pairs.getValue()
												.toString();
					%>
					<tr>
						<td><font size="2"  style="font-family: cursive;"><%=i%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
							href="<%=userLink%>"><%=fullNeighbourname%></a></font></td>


					</tr>

					<%
						}
								}

							}
					%>


				</table></td>

			<td><font size="2"  style="font-family: cursive;"><%=name%> Images</font><br>
			<br> <%
 	List<String> imagesNames = RetrieveImage
 				.getAllImagesForUser(otherUser);
 		if (imagesNames.size() == 0) {
 %> <font size="2"  style="font-family: cursive;">There are no images uploaded by <%=name%></font> <%
 	} else {
 			int i = 0;
 %>
				<table cellpadding="5" border="1" cellspacing="5" width="auto"
					height="auto">
					<tr>
						<%
							for (String image : imagesNames) {
										System.out.println(i);
										// if i is multiple of 3 then new row
										if ((i % 5) == 0) {
						%>
					</tr>
					<tr>
						<%
							}
										// if i is not multiple of 3 display the images in <td> and increment i
										String imageSrc = "http://localhost:8080"
												+ pageContext.getServletContext()
														.getContextPath() + "/images_users/"
												+ otherUser + "/" + image;
										System.out.println(imageSrc);
						%>
						<td><font size="2"  style="font-family: cursive;"><img src="<%=imageSrc%>" alt="Error" width="75"
							height="75" border="0"
							onclick="window.open('<%=imageSrc%>', '<%=image%>', 'width=300,height=300,resizabel=yes,toolbar=no,left=200,top=200')" />
							<br> <%=image%></font></td>
						<%
							i++;

									}
						%>
					</tr>
				</table> <%
 	}
 %></td>
		</tr>
	</table>
 --%>
		<%-- 
		<font size="2"
			style="font-family: cursive; color: black; background-color: white;">Updates
			from neighbours of <%=name%></font> --%>
		<%
			// Show post of the other user neighbours...

				List<String> updates = (ArrayList<String>) Neighbours
						.getUpdatesFromNeighbours(otherUser);

				if (updates.isEmpty()) {
		%>

		<font size="2"
			style="font-family: cursive; color: black; background-color: white;">No
			updates found</font>
		<%
			} else {
		%>

		<table border="0">
			<%
				//Implement Paging

						final int NUMBER_OF_RECORDS_PERPAGE_DEFAULT = 10;
						int numPages = 0;

						int numRows = updates.size();
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
							temp = temp + "<a href=\"otheruser.jsp?startIndex="
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


			<table width="100%" border="0">

				<tr>
					<td width="43%" scope="col" class="HdrParagraph">
						<%
							if (startIndex != 0) {
						%> <a
						href="otheruser.jsp?startIndex=<%=startIndex - numRecordsPerPage%>&txtnumrec=<%=numRecordsPerPage%>"
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
								href="otheruser.jsp?startIndex=<%=startIndex + numRecordsPerPage%>&txtnumrec=<%=numRecordsPerPage%>"
								style="text-decoration: none;"><font size="1.5"
								color="black" style="font-family: cursive;">Next</font></a>
							<%
								}
							%>
						</div>
					</td>
				</tr>
			</table>

			<%
				for (int i = startIndex; i < increment; i++) {
							String record = updates.get(i);
							/* 					System.out.println(record);
							 */String[] record_split = record.split("~");
							/* 				System.out.println(record_split.length);
							 */String user = record_split[1];
							String userLink = "otheruser.jsp?username=" + user;
							String fullname = Neighbours.getFullName(user);
							String post_id = record_split[0];
							String post = record_split[2];
							String date = record_split[3];
							String time = record_split[4];
							String userImageFullPath = RetrieveImage
									.getProfileImagePath(user);
							String userProfilePicName = RetrieveImage
									.getProfilePicName(user);
			%>
			<tr>
				<td><table border="0">
						<tr>
							<td width="15%"><font size="2"
								style="font-family: cursive; color: black; background-color: white;"><img
									src="<%=userImageFullPath%>" alt="<%=user%>" width="20"
									height="20"
									onclick="window.open('<%=userImageFullPath%>', '<%=userProfilePicName%>', 'width=300,height=300,resizabel=yes,toolbar=no,left=200,top=200')" />
									<a href="<%=userLink%>" style="text-decoration: none;"><font
										size="2"
										style="font-family: cursive; color: black; background-color: white;"><%=fullname%>:</font></a></font></td>
							<td width="55%"><font size="2"
								style="font-family: cursive; color: black; background-color: white; text-decoration: none;">
									<%=post%></font></td>

							<td width="20%"><font size="1"
								style="font-family: cursive; color: black; background-color: white;"><%=date%>
									&nbsp;&nbsp;&nbsp;<%=time%></font></td>
						
							
									
						</tr>
						<%
							List<Post> updatesChild = (ArrayList<Post>) Neighbours
												.getChildList(otherUser, post_id);
										for (Post childPost : updatesChild) {

											String childLink = "otheruser.jsp?username="
													+ childPost.getUsername();
											String[] date_time_split = childPost.getDate_time()
													.split(" ");
											String childDate = date_time_split[0];
											String childTime = date_time_split[1];
											String childUserImageFullPath = RetrieveImage
													.getProfileImagePath(childPost
															.getUsername());
											String childUserImageName = RetrieveImage
													.getProfilePicName(childPost.getUsername());
						%>
						<tr>
							<td width="auto"><font size="2"
								style="font-family: cursive; color: black; background-color: white;">
									<img src="<%=childUserImageFullPath%>" alt="<%=user%>"
									width="20" height="20"
									onclick="window.open('<%=childUserImageFullPath%>', '<%=childUserImageName%>', 'width=300,height=300,resizabel=yes,toolbar=no,left=200,top=200')" />
									<a href="<%=childLink%>" style="text-decoration: none;"><font
										size="2"
										style="font-family: cursive; color: black; background-color: white; text-decoration: none;"><%=Neighbours.getFullName(childPost
									.getUsername())%>:</font></a>
							</font></td>
							<td width="auto"><font size="2"
								style="font-family: cursive; color: black; background-color: white;"><%=childPost.getPost()%></font></td>
							<td width="auto"><font size="1"
								style="font-family: cursive; color: black; background-color: white;"><%=childDate%>&nbsp;&nbsp;&nbsp;<%=childTime%></font></td>

						</tr>

						<%
							}
						%>
						<tr>
							<td></td>
							<td width="300">
								<form name="updateReplyForm" method="post" target="main"
									onsubmit="return validateUpdateReply();"
									action="UpdateStatusReply">
									<textarea rows="3" cols="80" name="updateReply"
										id="updateReply"
										style="font-family: cursive; font-size: 2; color: black; background-color: white;"></textarea>

									<br> <input type="submit" value="Reply"
										style="font-family: cursive; font-size: 2; color: black; background-color: white;" />
									<input type="hidden" name="post_id" value="<%=post_id%>" /> <input
										type="hidden" name="username" value="<%=otherUser%>" />
								</form>
							</td>
							<td></td>
						</tr>


					</table></td>
			</tr>
			<tr>
				<td></td>
			</tr>
			<tr>
				<td></td>
			</tr>



			<%
				}
			%>
		</table>

		<%
			}

			}
		%>
	</center>
</body>
</html>