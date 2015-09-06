<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome to Neighbourhood</title>
<script type="text/javascript">
	function anonymousFeedback() {

		var email = document.getElementById("email").value;
		var feedback = document.getElementById("feedback").value;
		var fname = document.getElementById("fname").value;
		var lname = document.getElementById("lname").value;
		var regEmail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		regName = /^[A-Za-z]+$/;
		var iChars = "!@#$%^&*()+=-[]\\\';,./{}|\":<>?";
		/* var addressChars = "!@$%^&*()+=-[]\\\;/{}|\"<>?"; */
		/*
		 * alert(fname + " " + lname + " " + username + " " + password + " " + email + " " +
		 * address1 + " " + address2 + " " + city + " " + state + " " + country + " " +
		 * zipcode);
		 */
		// First Name Validation
		if (fname.length == 0 || fname == " ") {
			alert("First name field cannot be empty");
			document.anonymousFeedbackForm.fname.focus();
			return false;
		}

		for ( var i = 0; i < fname.length; i++) {
			if (fname.charAt(i) == " ") {
				alert("First Name field cannot have space");
				document.anonymousFeedbackForm.fname.focus();
				return false;
			}
		}

		if (!regName.test(fname)) {
			alert('Invalid First Name');
			document.anonymousFeedbackForm.fname.focus();
			return false;
		}

		// Last Name Validation
		if (lname.length == 0 || lname == " ") {
			alert("Last name field cannot be empty");
			document.anonymousFeedbackForm.lname.focus();
			return false;
		}

		for ( var i = 0; i < lname.length; i++) {
			if (lname.charAt(i) == " ") {
				alert("Last Name field cannot have space");
				document.anonymousFeedbackForm.lname.focus();
				return false;
			}
		}

		if (!regName.test(lname)) {
			alert('Invalid Last Name');
			document.anonymousFeedbackForm.lname.focus();
			return false;
		}

		// Email Validation
		if (email.length == 0 || email == " ") {
			alert("Email field cannot be empty");
			document.anonymousFeedbackForm.email.focus();
			return false;
		}

		for ( var i = 0; i < email.length; i++) {
			if (email.charAt(i) == " ") {
				alert("Email field cannot have space");
				document.anonymousFeedbackForm.email.focus();
				return false;
			}
		}

		if (!regEmail.test(email)) {
			alert("Email is not valid");
			document.anonymousFeedbackForm.email.focus();
			return false;

		}

		if (feedback.length == 0 || feedback == " ") {
			alert("Feedback cannot be empty");
			document.anonymousFeedbackForm.feedback.focus();
			return false;
		}

		return true;
	}
</script>


</head>
<body>

	<center>

		<div align="center">
			<font size="5"
				style="font-family: cursive; color: black; background-color: white;"><img
				src="MainLogo.png" /></font>
		</div>

		<br> <br> <b> <font size="3"
			style="font-family: cursive; color: black; background-color: white;">Feedback</font></b>
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

		<%
			if ((session != null)
					&& session.getAttribute("nonmemberfeedback") != null) {
		%>


		<form name="anonymousFeedbackForm"
			onsubmit="return anonymousFeedback();" action="SendFeedbackNonMember"
			method="post">
			<table border="0" align="center" width="50%" cellpadding="5"
				cellspacing="5">
				<tr>
					<td><font size="2"
						style="font-family: cursive; color: black; background-color: white;">First
							Name</font></td>
					<td><input type="text" name="fname" id="fname"
						style="color: black; background-color: white; font-family: cursive;"
						value="<%=session.getAttribute("nonmemberfname").toString()%>" /></td>
				</tr>
				<tr>
					<td><font size="2"
						style="font-family: cursive; color: black; background-color: white;">Last
							Name</font></td>
					<td><input type="text" name="lname" id="lname"
						style="color: black; background-color: white; font-family: cursive;"
						value="<%=session.getAttribute("nonmemberlname").toString()%>" /></td>
				</tr>

				<tr>
					<td><font size="2"
						style="font-family: cursive; color: black; background-color: white;">Email
							address</font></td>
					<td><input type="text" name="email" id="email"
						style="color: black; background-color: white; font-family: cursive;"
						size="30" maxlength="30"
						value="<%=session.getAttribute("nonmemberemail").toString()%>" /></td>
				</tr>
				<tr>
					<td><font size="2"
						style="font-family: cursive; color: black; background-color: white;">Feedback</font></td>
					<td><textarea rows="10" cols="70" name="feedback"
							id="feedback"
							style="color: black; background-color: white; font-family: cursive;"><%=session.getAttribute("nonmemberfeedback").toString()%></textarea>
					</td>
				</tr>
			</table>

			<br> <input type="submit" value="Send Feedback"
				style="color: black; background-color: white; font-family: cursive;" />
		</form>






		<%
			} else {
		%>
		<form name="anonymousFeedbackForm"
			onsubmit="return anonymousFeedback();" action="SendFeedbackNonMember"
			method="post">
			<table border="0" align="center" width="50%" cellpadding="5"
				cellspacing="5">
				<tr>
					<td><font size="2"
						style="font-family: cursive; color: black; background-color: white;">First
							Name</font></td>
					<td><input type="text" name="fname" id="fname"
						style="color: black; background-color: white; font-family: cursive;" /></td>
				</tr>
				<tr>
					<td><font size="2"
						style="font-family: cursive; color: black; background-color: white;">Last
							Name</font></td>
					<td><input type="text" name="lname" id="lname"
						style="color: black; background-color: white; font-family: cursive;" /></td>
				</tr>

				<tr>
					<td><font size="2"
						style="font-family: cursive; color: black; background-color: white;">Email
							address</font></td>
					<td><input type="text" name="email" id="email"
						style="color: black; background-color: white; font-family: cursive;"
						size="30" maxlength="30" /></td>
				</tr>
				<tr>
					<td><font size="2"
						style="font-family: cursive; color: black; background-color: white;">Feedback</font></td>
					<td><textarea rows="10" cols="70" name="feedback"
							id="feedback"
							style="color: black; background-color: white; font-family: cursive;"></textarea>
					</td>
				</tr>
			</table>

			<br> <input type="submit" value="Send Feedback"
				style="color: black; background-color: white; font-family: cursive;" />
		</form>

		<%
			}
		%>


		<br> <br> <br> <br> <br> <a href="Info.html"
			target="main" style="text-decoration: none;"><font size="1"
			style="font-family: cursive; color: black; background-color: white;">About
				Us</font></a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a
			href="terms_condition.html" target="_top"
			style="text-decoration: none;"><font size="1"
			style="font-family: cursive; color: black; background-color: white;">Terms
				&amp; Conditions</font></a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <font
			size="1"
			style="font-family: cursive; color: black; background-color: white;"><a
			href="index.jsp" target="_top"
			style="text-decoration: none; color: black;">Login Page</a></font> <br>

		<%
			session.removeAttribute("nonmemberfname");
			session.removeAttribute("nonmemberlname");
			session.removeAttribute("nonmemberemail");
			session.removeAttribute("nonmemberfeedback");
		%>


	</center>
</body>
</html>