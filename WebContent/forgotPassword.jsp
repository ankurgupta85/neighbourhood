<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome to Neighbourhood</title>
<script type="text/javascript" src="disableRightClick.js"></script>
<script type="text/javascript">
	function validateUsername() {
		var username = document.getElementById("username").value;
		var iChars = "!@#$%^&*()+=-[]\\\';,./{}|\":<>?";

		if (username == "") {
			alert("Please enter Username");
			return false;
		}

		for ( var i = 0; i < username.length; i++) {
			if (iChars.indexOf(username.charAt(i)) != -1) {
				alert("Your username has special characters. \nThese are not allowed.\n Please remove them and try again.");
				return false;
			}
		}

	}

	function validateEmail() {

		var email = document.getElementById("email").value;
		var regEmail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		// Email Validation
		if (email.length == 0 || email == " ") {
			alert("Email field cannot be empty");
			document.forgotUsernameForm.email.focus();
			return false;
		}

		for ( var i = 0; i < email.length; i++) {
			if (email.charAt(i) == " ") {
				alert("Email field cannot have space");
				document.forgotUsernameForm.email.focus();
				return false;
			}
		}

		if (!regEmail.test(email)) {
			alert("Email is not valid");
			document.forgotUsernameForm.email.focus();
			return false;

		}

		return true;
	}
</script>
</head>
<body bgcolor="white">

	<center>


		<br> <br>
		<div align="center">
			<font size="5"
				style="font-family: cursive; color: black; background-color: white;"><img
				src="MainLogo.png" /></font>
		</div>
<br><br>

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

		<div align="center">
			<font size="3"
				style="font-family: cursive; color: black; background-color: white;">Forgot
				Password</font>
		</div>
		<form name="forgotPasswordForm" onsubmit="return validateUsername();"
			action="SendLoginDetails" method="post">
			<br>
			<table align="center" border="0">
				<tr>
					<td><font size="2"
						style="font-family: cursive; color: black; background-color: white;">Username</font></td>
					<td><input type="text" name="username" id="username" />
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="submit" value="Get Password"
						style="font-family: cursive; background-color: white; color: black;" />

					</td>
				</tr>
			</table>

		</form>


		<br><br><br>

		<div align="center">
			<font size="3"
				style="font-family: cursive; color: black; background-color: white;">If
				you forgot username, enter email</font>
		</div>
		<form name="forgotUsernameForm" onsubmit="return validateEmail();"
			action="SendLoginDetails" method="post">
			<br>
			<table align="center" border="0">
				<tr>
					<td><font size="2"
						style="font-family: cursive; color: black; background-color: white;">Email</font></td>
					<td><input type="text" name="email" id="email" />
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="submit" value="Get Login Details"
						style="font-family: cursive; background-color: white; color: black;" />
					</td>
				</tr>
			</table>




		</form>

		<br> <br> <font size="1"
			style="font-family: cursive; color: black; background-color: white;"><a
			href="index.jsp" target="_top"
			style="text-decoration: none; color: black;">Login Page</a></font> <br>



	</center>

</body>
</html>