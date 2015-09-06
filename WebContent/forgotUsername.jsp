<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome to Neighbourhood</title>
<script type="text/javascript" src="disableRightClick.js"></script>
<script type="text/javascript">
function validateEmail() {

	var email = document.getElementById("email").value;
	var regEmail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	// Email Validation
	if (email.length == 0 || email == " ") {
		alert("Email field cannot be empty");
		document.newuser.email.focus();
		return false;
	}

	for ( var i = 0; i < email.length; i++) {
		if (email.charAt(i) == " ") {
			alert("Email field cannot have space");
			document.newuser.email.focus();
			return false;
		}
	}

	if (!regEmail.test(email)) {
		alert("Email is not valid");
		document.newuser.email.focus();
		return false;

	}


	return true;
}


</script>

</head>
<body bgcolor="white">

	<center>
		<div align="center">
			<font size="5"
				style="font-family: cursive; color: black; background-color: white;"><img
				src="MainLogo.png" /></font>
		</div>

		<br> <br>

		<div align="center">
			<font size="3"
				style="font-family: cursive; color: black; background-color: white;">Forgot
				Login Details</font>
		</div>
		<form name="forgotUsernameForm" onsubmit="return validateEmail();" action="SendLoginDetails" method="post" >
<br><br>
		<table align="center" border="0">
			<tr>
				<td><font size="2"
					style="font-family: cursive; color: black; background-color: white;">Email</font></td>
				<td><input type="text" name="email" id="email" />			
				</td>
			</tr>
			</table><br><br>
			<input type="submit" value="Get Login Details" style="font-family: cursive;background-color: white;color: black;"/>
	
	
		
		
		</form>
	</center>

</body>
</html>