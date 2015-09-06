<%@page import="com.neighbourhood.status.NeighbourhoodStatus"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="java.util.*,com.neighbourhood.neighbours.*,com.neighbourhood.post.*,com.neighbours.imageUpload.*,java.io.File"%>
<%@ page import="com.neighbourhood.user.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script type="text/javascript" src="postUpdates.js"></script>
<script type="text/javascript" src="disableRightClick.js"></script>
<style type="text/css">
textarea {
	resize: none;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
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

			/* 			if (session.getAttribute("eventTopic") != null) {
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
		%>
		<%
			String neighbourDeleted = null;
			if (session != null
					&& session.getAttribute("neighbourDeleted") != null) {
				neighbourDeleted = session.getAttribute("neighbourDeleted")
						.toString();

			}

			if (neighbourDeleted != null) {
		%>
		<font size="3"
			style="font-family: cursive;; color: black; background-color: white;"><b><%=neighbourDeleted%></b></font>
		<%
			session.removeAttribute("neighbourDeleted");
		%>
		<br>

		<%
			}
			
			
			String blockMessage = null;
			if (session != null
					&& session.getAttribute("blockMessage") != null) {
				blockMessage = session.getAttribute("blockMessage")
						.toString();

			}

			if (blockMessage != null) {
		%>
		<font size="3"
			style="font-family: cursive;; color: black; background-color: white;"><b><%=blockMessage%></b></font>
		<%
			session.removeAttribute("blockMessage");
		%>
		<br>

		<%
			}
		
			
			String unblockMessage = null;
			if (session != null
					&& session.getAttribute("unblockMessage") != null) {
				unblockMessage = session.getAttribute("unblockMessage")
						.toString();

			}

			if (unblockMessage != null) {
		%>
		<font size="3"
			style="font-family: cursive;; color: black; background-color: white;"><b><%=unblockMessage%></b></font>
		<%
			session.removeAttribute("unblockMessage");
		%>
		<br>

		<%
			}
			
			String message = null;
			if (session != null && session.getAttribute("message") != null) {
				message = session.getAttribute("message").toString();

			}

			if (message != null) {
		%>
		<font size="3"
			style="font-family: cursive;; color: black; background-color: white;"><b><%=message%></b></font>
		<%
			session.removeAttribute("message");
		%>
		<br>
		<%
			}
			if (session != null
					&& session.getAttribute("messageFeedbackMember") != null) {
		%>
		<font size="2"
			style="font-family: cursive; color: red; background-color: white;"><%=session.getAttribute("messageFeedbackMember")
						.toString()%></font> <br> <br>

		<%
			session.removeAttribute("messageFeedbackMember");
			}
		%>


		<br>
		<!--  Status -->
		<div style="overflow: hidden;" align="center">
			<form method="post" action="UpdateStatus" name="updateStatus"
				onsubmit="return validateUpdate();" target="_top">
				<textarea rows="3" cols="100" name="post" id="post"
					style="font-size: 2; font-family: cursive; color: black; background-color: white;"></textarea>
				<br> <input type="hidden" name="username" value="<%=username%>" />
				<input type="submit" value="Update Status"
					style="font-family: cursive; font-size: 2; color: black; background-color: white;" />
				&nbsp; &nbsp; &nbsp; &nbsp; <input type="reset"
					value="Cancel Update"
					style="font-family: cursive; font-size: 2; color: black; background-color: white;" />

			</form>
		</div>

		<br> <br>
		<div style="overflow: hidden;">
			<%
				/* System.out.println(fullPath); */

				List<User> neighbourList = null;
				neighbourList = Neighbours.getNeighboursList(username);

				if (neighbourList.isEmpty()) {
			%>
			You dont have any neighbours.Please add your neighbours to get
			updates from them.
			<%
				} else {

					List<String> updates = (ArrayList<String>) Neighbours
							.getUpdatesFromNeighbours(username);

					if (updates.isEmpty()) {
			%>

			<font size="2"
				style="font-family: cursive; color: black; background-color: white;">No
				updates from ur neighbours</font>
			<%
				} else {
			%>
			<table border="0">
				<%
					// Implement paging here...... 
							final int NUMBER_OF_RECORDS_PERPAGE_DEFAULT = 10;
							int numPages = 0;

							int numRows = updates.size();
							String startIndexString = request
									.getParameter("startIndex");
							if((startIndexString == null)
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
								temp = temp + "<a href=\"postUpdates.jsp?startIndex="
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
							href="postUpdates.jsp?startIndex=<%=startIndex - numRecordsPerPage%>&txtnumrec=<%=numRecordsPerPage%>"
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
									href="postUpdates.jsp?startIndex=<%=startIndex + numRecordsPerPage%>&txtnumrec=<%=numRecordsPerPage%>"
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
					// show records using paging......

							for (int i = startIndex; i < increment; i++) {
								String record = updates.get(i);
								/* 						System.out.println(record);
								 */String[] record_split = record.split("~");
								/* 					System.out.println(record_split.length);
								 */String user = record_split[1];
								String userLink = "otheruser.jsp?username=" + user;
								String fullname = Neighbours.getFullName(user);
								String blockupdates = "blockupdates.jsp?username="
										+ user;
								String post_id = record_split[0];
								String post = record_split[2];
								String date = record_split[3];
								String time = record_split[4];

								// Get pic of ppl with updates
								/* 	String absPath = null;
								 */String fullPath = RetrieveImage
										.getProfileImagePath(user);
								// show user Profile Pic 
								// check if user has profile pic set?
								// checking if profile pic is null.
								String profilePicName = RetrieveImage
										.getProfilePicName(user);

								// if profile pic is null, then show default pic and no need to check the pic in user folder
								/* 				if (profilePicName == null) {
													profilePicName = "defaultNoPic.ico";
													fullPath = "http://localhost:8080"
															+ pageContext.getServletContext()
																	.getContextPath()
															+ "/images_users/defaultNoPic.ico";

												}
												//user has profile pic
												else {
													// if user has profile pic, then check if the profile pic is in folder using absolute path
													// if profile pic is in folder then use that pic, else show default pic.
													absPath = pageContext.getServletContext()
															.getInitParameter("file-upload")
															+ user
															+ "\\";
													File userDirectory = new File(absPath);
													String[] userFiles = userDirectory.list();
													boolean picFound = false;
													if (userFiles != null && userFiles.length != 0)
														for (String userFile : userFiles) {
															// check if the pic is in the images folder of user
															if (userFile != null
																	&& userFile.equals(profilePicName)) {
																picFound = true;
																break;
															}

														}

													// if pic found in the user image folder
													if (picFound) {
														fullPath = "http://localhost:8080"
																+ pageContext.getServletContext()
																		.getContextPath()
																+ "/images_users/" + user + "/"
																+ profilePicName;
													}
													// if pic found in the user image folder
													else {
														fullPath = "http://localhost:8080"
																+ pageContext.getServletContext()
																		.getContextPath()
																+ "/images_users/defaultNoPic.ico";
													}

												}
								 */
				%>
				<tr>
					<td>
						<table border="0">
							<tr>


								<td width="15%"><font size="2"
									style="font-family: cursive; color: black; background-color: white; text-align: justify;"><img
										src="<%=fullPath%>" alt="<%=user%>" width="20" height="20"
										onclick="window.open('<%=fullPath%>', '<%=profilePicName%>', 'width=300,height=300,resizabel=yes,toolbar=no,left=200,top=200')" />
										<a href="<%=userLink%>" style="text-decoration: none;"><font
											size="2"
											style="font-family: cursive; color: black; background-color: white;"><%=fullname%>:</font></a></font>
								</td>
								<td width="55%"><font size="2"
									style="font-family: cursive; color: black; background-color: white; text-decoration: none;">
										<%=post%>
								</font></td>
								<td width="20%"><font size="1"
									style="font-family: cursive; color: black; background-color: white;"><%=date%>
										&nbsp;&nbsp;&nbsp;<%=time%></font></td>

								<%
									if (!username.equals(user)) {
								%>

								<td width="10%"><font size="1"
									style="font-family: cursive; color: black; background-color: white;"><a
										href="<%=blockupdates%>"
										style="text-decoration: none; font-family: cursive; color: black;" target="_top">Block
											Updates</a></font></td>

								<%
									}
									else
									{
										%>
										<td width="10%"></td>
										
										<% 
									}
								%>


							</tr>
							<%
								List<Post> updatesChild = (ArrayList<Post>) Neighbours
													.getChildList(username, post_id);
											for (Post childPost : updatesChild) {

												String childLink = "otheruser.jsp?username="
														+ childPost.getUsername();
												String[] date_time_split = childPost.getDate_time()
														.split(" ");
												String childDate = date_time_split[0];
												String childTime = date_time_split[1];
												// Get pic of ppl with updates
												/* String childAbsPath = null; */
												String childFullPath = RetrieveImage
														.getProfileImagePath(childPost
																.getUsername());
												// show user Profile Pic 
												// check if user has profile pic set?
												// checking if profile pic is null.
												String childProfilePicName = RetrieveImage
														.getProfilePicName(childPost.getUsername());

												// if profile pic is null, then show default pic and no need to check the pic in user folder
												/* 		if (childProfilePicName == null) {
															childProfilePicName = "defaultNoPic.ico";
															childFullPath = "http://localhost:8080"
																	+ pageContext.getServletContext()
																			.getContextPath()
																	+ "/images_users/defaultNoPic.ico";

														}
														//user has profile pic
														else {
															// if user has profile pic, then check if the profile pic is in folder using absolute path
															// if profile pic is in folder then use that pic, else show default pic.
															childAbsPath = pageContext.getServletContext()
																	.getInitParameter("file-upload")
																	+ childPost.getUsername() + "\\";
															File userDirectory = new File(childAbsPath);
															String[] childUserFiles = userDirectory.list();
															boolean childPicFound = false;
															if (childUserFiles != null
																	&& childUserFiles.length > 0)
																for (String childUserFile : childUserFiles) {
																	// check if the pic is in the images folder of user
																	if (childUserFile != null
																			&& childUserFile
																					.equals(childProfilePicName)) {
																		childPicFound = true;
																		break;
																	}

																}

															// if pic found in the user image folder
															if (childPicFound) {
																childFullPath = "http://localhost:8080"
																		+ pageContext.getServletContext()
																				.getContextPath()
																		+ "/images_users/"
																		+ childPost.getUsername() + "/"
																		+ childProfilePicName;
															}
															// if pic found in the user image folder
															else {
																childFullPath = "http://localhost:8080"
																		+ pageContext.getServletContext()
																				.getContextPath()
																		+ "/images_users/defaultNoPic.ico";
															}

														}
												 */
							%>

							<tr>
								<td width="auto"><font size="2"
									style="font-family: cursive; color: black; background-color: white;"><img
										src="<%=childFullPath%>" alt="<%=childPost.getUsername()%>"
										width="20" height="20"
										onclick="window.open('<%=childFullPath%>', '<%=profilePicName%>', 'width=300,height=300,resizabel=yes,toolbar=no,left=200,top=200')" />
										<a href="<%=childLink%>" style="text-decoration: none;"><font
											size="2"
											style="font-family: cursive; color: black; background-color: white;"><%=Neighbours.getFullName(childPost
									.getUsername())%>:</font></a></font></td>
								<td width="auto"><font size="2"
									style="font-family: cursive; color: black; background-color: white;">
										<%=childPost.getPost()%></font></td>
								<td width="auto"><font size="1"
									style="font-family: cursive; color: black; background-color: white;"><%=childDate%>&nbsp;&nbsp;&nbsp;<%=childTime%></font></td>
								
									<%
									if (!username.equals(childPost.getUsername())) {
								%>

								<td width="auto"><font size="1"
									style="font-family: cursive; color: black; background-color: white;"><a
										href="<%=blockupdates%>"
										style="text-decoration: none; font-family: cursive; color: black;" target="_top">Block
											Updates</a></font></td>

								<%
									}
									else
									{
										%>
										<td width="auto"></td>
										
										<% 
									}
								%>
								
							</tr>
							<%
								}
							%>
							<tr>
								<td></td>
								<td width="300"><form name="updateReplyForm" method="post"
										target="main" onsubmit="return validateUpdateReply();"
										action="UpdateStatusReply">
										<textarea rows="3" cols="80" name="updateReply"
											id="updateReply"
											style="font-family: cursive; font-size: 2; color: black; background-color: white;"></textarea>
										<br> <font size="2"><input type="submit"
											value="Reply"
											style="font-family: cursive; font-size: 2; color: black; background-color: white;" /></font>
										<input type="hidden" name="post_id" value="<%=post_id%>" /> <input
											type="hidden" name="username" value="<%=username%>" />
									</form></td>
								<td></td>
							</tr>


						</table>
					</td>
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

		</div>
	</center>

</body>
</html>
