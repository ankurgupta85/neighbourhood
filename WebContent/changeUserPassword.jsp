<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript" src="disableRightClick.js"></script>
<script type="text/javascript" src="validateChangePassword.js"></script>
</head>
<body bgcolor="white">
	<center>
		<br>
		<br>
		<%
			String username = null;

			if (session == null || session.getAttribute("username") == null) {
				response.sendRedirect("index.jsp");

			} else {
				username = session.getAttribute("username").toString();

				if (session.getAttribute("changePasswordMessage") != null) {
		%>

		<font size="2" style="font-family: cursive; color: black;"><%=session.getAttribute("changePasswordMessage")
							.toString()%></font>
		<br>
		<br>
		<%
			}
				// Code to enable change of user password
				//Ask for prev password and then new password
				if (session.getAttribute("changePasswordMessage") == null
						|| !session.getAttribute("changePasswordMessage")
								.toString()
								.equals("Your Password has been updated")) {
		%>

		<center>
			<font size="3" style="font-family: cursive; color: black;">Change
				Password</font> <br>
			<br>
			<form action="ChangeUserPassword" method="post" name="changePassword"
				onsubmit="return validateChangePassword()">
				<table border="0">
					<tr>
						<td><font size="2"
							style="font-family: cursive; color: black;">Username</font></td>
						<td><font size="2"
							style="font-family: cursive; color: black;"><%=username%></font></td>
					</tr>
					<tr>
						<td><label><font size="2"
								style="font-family: cursive; color: black;">Old Password</font></label></td>
						<td><font size="2"
							style="font-family: cursive; color: black;"><input
								type="password" name="old_password" id="old_password"
								style="background-color: white; color: black" /></font></td>
					</tr>
					<tr>
						<td><label><font size="2"
								style="font-family: cursive; color: black;">New Password</font></label></td>
						<td><font size="2"
							style="font-family: cursive; color: black;"><input
								type="password" name="new_password" id="new_password"
								style="background-color: white; color: black;" /></font></td>
					</tr>
					<tr>
						<td><label><font size="2"
								style="font-family: cursive; color: black;">Re-Enter New
									Password</font></label></td>
						<td><font size="2"
							style="font-family: cursive; color: black;"><input
								type="password" name="re_new_password" id="re_new_password"
								style="background-color: white; color: black;" /></font></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td><input type="submit" value="Change Password"
							style="font-size: 2; font-family: cursive; background-color: white; color: black;" /></td>
						<td><input type="reset" value="Clear All"
							style="font-size: 2; font-family: cursive; background-color: white; color: black;" /></td>
					</tr>


				</table>
				<input type="hidden" name="username" value="<%=username%>" />

			</form>







		</center>





		<%
			} else {
		%>

		<br> <a href="user.jsp" target="_top"
			style="background-color: white; color: black; text-decoration: none;"><font
			size="2" style="font-family: cursive;">Click here to go to
				Homepage</font></a>
		<%
			}

				session.removeAttribute("changePasswordMessage");

			}
		%>
	</center>
</body>
</html>