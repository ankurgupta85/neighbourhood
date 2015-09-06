<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<script type="text/javascript">

function validUserFeedback() {

	var feedback = document.getElementById("feedback").value;

	if (feedback.length == 0 || feedback == " ") {
		alert("Feedback cannot be empty");
		document.validUserFeedbackForm.feedback.focus();
		return false;
	}

	return true;

}
</script>
</head>
<body>
<center>
		<%
			String username = null;
			if (session != null && session.getAttribute("username") != null) {
				username = session.getAttribute("username").toString();
			}
			else
			{
				response.sendRedirect("user.jsp");
			}

			if (username != null) {
				// User logged in to system.. So Just need to get feedback
		%>


		<br> <br> <b> <font size="3"
			style="font-family: cursive; color: black; background-color: white;">Feedback</font></b>
		<br>
<br>
<% if(session!=null && session.getAttribute("messageFeedbackMember")!=null)
		{
			
			%>
			<font size="2"
				style="font-family: cursive; color: red; background-color: white;"><%=session.getAttribute("messageFeedbackMember").toString() %></font>
			
			<br><br>
			
			<% 
			
			session.removeAttribute("messageFeedbackMember");
		}
	
%>
		<form name="validUserFeedbackForm"
			onsubmit="return validUserFeedback();" action="SendFeedbackMember" method="post"  target="_top">

		<%
		if(session != null && session.getAttribute("userFeedback")!=null)
		{
			%>
			<div align="center">
				<font size="2"
					style="font-family: cursive; color: black; background-color: white;">
					Please input your valuable feedback/issues*</font> <br> <br>
				<textarea rows="10" cols="70" name="feedback" id="feedback"><%=session.getAttribute("userFeedback").toString() %></textarea>


			</div>
			
			<% 
		}
		else
		{
		
		
		%>

			<div align="center">
				<font size="2"
					style="font-family: cursive; color: black; background-color: white;">
					Please input your valuable feedback/issues*</font> <br> <br>
				<textarea rows="10" cols="70" name="feedback" id="feedback"></textarea>


			</div>
			
			<%} %>
			<br> <br> <input type="hidden" name="username"
				value="<%=username%>" /> <input type="submit" value="Send Feedback"
				style="color: black; background-color: white; font-family: cursive;">
		</form>
		
		
		<%
		session.removeAttribute("userFeedback");
		
			
			} %>
</center>
</body>
</html>