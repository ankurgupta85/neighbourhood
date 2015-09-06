<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="login.js"></script>
<script type="text/javascript" src="newuser.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="Logo" href="logo.ico">
<script type="text/javascript" src="disableRightClick.js"></script>
<link rel="shortcut icon" href="N.ico" />
<title>Welcome to Neighbourhood</title>
</head>
<body bgcolor="white">
	<center>
		<div align="center">
			<font size="5"
				style="font-family: cursive; color: black; background-color: white;"><img
				src="MainLogo.png" /></font>
		</div>


		<%
			String errorMessageLoginDetails = null;
			if (session != null
					&& session.getAttribute("errorMessage_loginDetails") != null) {
				errorMessageLoginDetails = session.getAttribute(
						"errorMessage_loginDetails").toString();
			}
			if (errorMessageLoginDetails != null
					&& !errorMessageLoginDetails.trim().isEmpty()) {
		%><div style="text-transform: capitalize; color: red; font-size: 2">
			<font size="2"
				style="font-family: cursive; color: red; background-color: white;"><%=errorMessageLoginDetails%></font>
			<br>
		</div>

		<%
			session.removeAttribute("errorMessage_loginDetails");

			}
		%>



		<br> <br>
		
		
		<% if(session!=null && session.getAttribute("feedbacknonmembermessage")!=null)
		{
			
			%>
			<font size="2"
				style="font-family: cursive; color: red; background-color: white;"><%=session.getAttribute("feedbacknonmembermessage").toString() %></font>
			
			<br><br>
			
			<% 
			
			session.removeAttribute("feedbacknonmembermessage");
		}
	
			
			
			%>

		
		
		
		<div>

			<div align="center">
				<font size="3"
					style="font-family: cursive; color: black; background-color: white;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;New
					User&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Login</font>
			</div>
			<table align="center" width="auto" border="1" cellpadding="1"
				cellspacing="1">

				<tr>
					<td>
						<center>
							<%
								if (session.getAttribute("currentUserNeighbour") != null) {
									session.removeAttribute("currentUserNeighbour");
								}
								if (session.getAttribute("otherUser") != null) {
									session.removeAttribute("otherUser");
								}

								/* if(session.getAttribute("eventTopic") !=null)
								{
									session.removeAttribute("eventTopic");
									session.removeAttribute("eventDescription");
									session.removeAttribute("date_time_event");
									session.removeAttribute("flag");
										
								} */

								List<String> errorMessage = null;
								if (session != null
										&& session.getAttribute("errorMessage_signup") != null) {
									errorMessage = (ArrayList<String>) session
											.getAttribute("errorMessage_signup");
								}
								if (errorMessage != null && errorMessage.size() != 0) {
							%><div
								style="text-transform: capitalize; color: red; font-size: 2">
								<%
									for (int i = 0; i < errorMessage.size(); i++) {
								%>
								<font size="2"
									style="font-family: cursive; color: red; background-color: white;"><%=errorMessage.get(i)%></font>
								<br>
								<%
									}
								%>
							</div>

							<%
								}
							%>








							<form method="post" action="NewUser"
								onsubmit="return validateNewUser();" name="newuser"
								target="_top">

								<table border="0" cellspacing="1">
									<tr>
										<td align="right"><font size="2"
											style="font-family: cursive; color: black; background-color: white;">First
												Name*</font></td>
										<%
											if (session != null && session.getAttribute("fname") != null
													&& !session.getAttribute("fname").toString().isEmpty()) {
										%>
										<td align="left"><input type="text" name="fname"
											id="fname" size="15" maxlength="15"
											value="<%=session.getAttribute("fname").toString()%>"
											style="font-family: cursive; font-size: 2; color: black; background-color: white;" /></td>

										<%
											} else {
										%>
										<td align="left"><input type="text" name="fname"
											id="fname" size="15" maxlength="15"
											style="font-family: cursive; font-size: 2; color: black; background-color: white;" /></td>

										<%
											}
										%>
										<td><font size="2"
											style="font-family: cursive; color: black; background-color: white;">Last
												Name*</font></td>
										<%
											if (session != null && session.getAttribute("lname") != null
													&& !session.getAttribute("lname").toString().isEmpty()) {
										%>
										<td><input type="text" name="lname" id="lname" size="20"
											maxlength="20"
											value=<%=session.getAttribute("lname").toString()%>
											style="font-family: cursive; font-size: 2; color: black; background-color: white;" /></td>

										<%
											} else {
										%>
										<td><input type="text" name="lname" id="lname" size="20"
											maxlength="20"
											style="font-family: cursive; font-size: 2; color: black; background-color: white;" /></td>

										<%
											}
										%>
									</tr>

									<tr>
										<td><font size="2"
											style="font-family: cursive; color: black; background-color: white;">Username*</font></td>
										<%
											if (session != null && session.getAttribute("username") != null
													&& !session.getAttribute("username").toString().isEmpty()) {
										%>
										<td><input type="text" name="username" id="username"
											size="20" maxlength="20"
											value="<%=session.getAttribute("username").toString()%>"
											style="font-family: cursive; font-size: 2; color: black; background-color: white;" /></td>

										<%
											} else {
										%>
										<td><input type="text" id="username" name="username"
											size="20" maxlength="20"
											style="font-family: cursive; font-size: 2; color: black; background-color: white;" /></td>

										<%
											}
										%>

										<td><font size="2"
											style="font-family: cursive; color: black; background-color: white;">Email*</font></td>
										<%
											if (session != null && session.getAttribute("email") != null
													&& !session.getAttribute("email").toString().isEmpty()) {
										%>
										<td><input type="text" name="email" id="email" size="30"
											maxlength="30"
											value="<%=session.getAttribute("email").toString()%>"
											style="font-family: cursive; font-size: 2; color: black; background-color: white;" /></td>

										<%
											} else {
										%>
										<td><input type="text" id="email" name="email" size="30"
											maxlength="30"
											style="font-family: cursive; font-size: 2; color: black; background-color: white;" /></td>

										<%
											}
										%>

									</tr>
									<tr>
										<td><font size="2"
											style="font-family: cursive; color: black; background-color: white;">Password*</font></td>
										<td><input type="password" id="password" name="password"
											size="20" maxlength="20"
											style="font-family: cursive; font-size: 2; color: black; background-color: white;" /></td>
										<td><font size="2"
											style="font-family: cursive; color: black; background-color: white;">Re-Enter
												Password*</font></td>
										<td><input type="password" id="re_password"
											name="re_password" size="20" maxlength="20"
											style="font-family: cursive; font-size: 2; color: black; background-color: white;" /></td>

									</tr>
									<tr>
									<!-- 	<td><font size="2"
											style="font-family: cursive; color: black; background-color: white;">Country*</font></td> -->
<%-- 										<%
											if (session != null && session.getAttribute("country") != null
													&& !session.getAttribute("country").toString().isEmpty()) {
										%>
										<td><input type="text" id="country" size="20"
											maxlength="20" name="country"
											value="<%=session.getAttribute("country").toString()%>"
											style="font-family: cursive; font-size: 2; color: black; background-color: white;" /></td>

										<%
											} else {
										%>
										<td><input type="text" id="country" size="20"
											maxlength="20" name="country"
											style="font-family: cursive; font-size: 2; color: black; background-color: white;" /></td>

										<%
											}
										%>
 --%>										<td colspan="2" align="right"><font size="2"
											style="font-family: cursive; color: black; background-color: white;">Zipcode*</font></td>
										<%
											if (session != null && session.getAttribute("zipcode") != null
													&& !session.getAttribute("zipcode").toString().isEmpty()) {
										%>
										<td colspan="2" align="left"><input type="text" id="zipcode" size="15"
											name="zipcode" maxlength="5"
											value="<%=session.getAttribute("zipcode").toString()%>"
											style="font-family: cursive; font-size: 2; color: black; background-color: white;" /></td>

										<%
											} else {
										%>
										<td colspan="2" align="left"><input type="text" id="zipcode" size="15"
											name="zipcode" maxlength="5"
											style="font-family: cursive; font-size: 2; color: black; background-color: white;" /></td>

										<%
											}
										%>

									</tr>
									<tr>

										<td align="center" colspan="2"><input type="submit" value="Submit"
											style="font-family: cursive; font-size: 2; color: black; background-color: white;" /></td>

										<td align="center" colspan="2"><input type="reset"
											value="Clear all values"
											style="font-family: cursive; font-size: 2; color: black; background-color: white;" /></td>
									</tr>

								</table>

							</form>
							<br> <font size="2"
								style="font-family: cursive; color: black; background-color: white;">All
								fields are required</font>
						</center>
					</td>
					<td width="auto">
						<center>

							<%
								List<String> errorMessageLogin = null;
								Object errorMessageObject = session.getAttribute("errorMessage");
								if (errorMessageObject != null) {
									errorMessageLogin = (ArrayList<String>) errorMessageObject;

								}
							%>

							<%
								if (errorMessageLogin != null) {
									for (String error : errorMessageLogin) {
							%>
							<font size="2"
								style="font-family: cursive; color: red; background-color: white;"><%=error%></font><br>
							<%
								}
								}

								session.removeAttribute("errorMessage");
							%>


							<form name="login" action="Login" method="post"
								onsubmit="return validate();" target="_top">
								<table border="0" cellspacing="1">
									<tr>
										<td><font size="2"
											style="font-family: cursive; color: black; background-color: white;">Username:</font></td>
										<td><input type="text" name="login_username"
											id="login_username"
											style="font-family: cursive; font-size: 2; color: black; background-color: white;" /></td>
									</tr>
									<tr>

										<td><font size="2"
											style="font-family: cursive; color: black; background-color: white;">Password:</font></td>
										<td><input type="password" name="login_password"
											id="login_password"
											style="font-family: cursive; font-size: 2; color: black; background-color: white;" /></td>
									</tr>
									<tr><td></td><td><font size="1"
										style="font-family: cursive; color: black; background-color: white;"><a
										href="forgotPassword.jsp" target="_top"
										style="text-decoration: none; color: black;">Forgot
											Password ?</a></font></td></tr>
									
								</table>
								<br>
								<input type="submit" value="Login" name="login" id = "login"
										style="font-family: cursive; font-size: 2; color: black; background-color: white;" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="reset" value="Clear"
										style="font-family: cursive; font-size: 2; color: black; background-color: white;" />
							</form>



						</center>


					</td>


				</tr>

			</table>
		</div>

		<br> <br> <br> <br> <br> <br> <br>
		
			<b><font size="2"
				style="font-family: cursive; color: green; background-color: white;">We need help for better UI!!!! <br>
				Please leave your contact details in feedback form!!
				</font></b>
		
		
		<br> <br> <br> <br> <br> <br> <br>
		<br> <a href="Info.html" target="main"
			style="text-decoration: none;"><font size="1"
			style="font-family: cursive; color: black; background-color: white;">About
				Us</font></a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a
			href="terms_condition.html" target="main"
			style="text-decoration: none;"><font size="1"
			style="font-family: cursive; color: black; background-color: white;">Terms
				&amp; Conditions</font></a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a
			href="feedback.jsp" target="_top" style="text-decoration: none;"><font
			size="1"
			style="font-family: cursive; color: black; background-color: white;">Feedback</font></a>


	</center>
</body>
</html>