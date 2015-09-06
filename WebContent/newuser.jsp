<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="newuser.js"></script>
<script type="text/javascript" src="disableRightClick.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome to Neighbourhood</title>
</head>
<body onload="document.newuser.fname.focus();">
<center>
	<div align="center">
		<center>
			<img alt="Neighbourhood" src="neighbourhood.png" width="500"
				height="150">
		</center>
	</div>
	<div>
		<center>

			<%
			
			if(session.getAttribute("currentUserNeighbour")!=null)
			{
				session.removeAttribute("currentUserNeighbour");
			}
			if(session.getAttribute("otherUser")!=null)
			{
				session.removeAttribute("otherUser");
			}
		/* 	if(session.getAttribute("eventTopic") !=null)
			{
				session.removeAttribute("eventTopic");
				session.removeAttribute("eventDescription");
				session.removeAttribute("date_time_event");
				session.removeAttribute("flag");
					
			}
		 */		List<String> errorMessage = null;
				if (session != null && session.getAttribute("errorMessage") != null) {
					errorMessage = (ArrayList<String>) session
							.getAttribute("errorMessage");
				}
				if (errorMessage != null && errorMessage.size() != 0) {
			%><div style="text-transform: capitalize; color: red;">
				<%
					for (int i = 0; i < errorMessage.size(); i++) {
				%>
				<%=errorMessage.get(i)%>
				<br>
				<%
					}
				%>
			</div>

			<%
				}
			%>

			<form method="post" action="NewUser" onsubmit="return validateNewUser();" name="newuser">
				<fieldset title="Login Info">
					<table cellpadding="1" cellspacing="1">
						<tr>
							<td>First Name*</td>
							<%
								if (session != null && session.getAttribute("fname") != null
										&& !session.getAttribute("fname").toString().isEmpty()) {
							%>
							<td><input type="text" name="fname" id="fname" size="15" maxlength="15"
								value="<%=session.getAttribute("fname").toString()%>" /></td>

							<%
								} else {
							%>
							<td><input type="text" name="fname" id="fname" size="15" maxlength="15"  /></td>

							<%
								}
							%>
							<td>Last Name*</td>
							<%
								if (session != null && session.getAttribute("lname") != null
										&& !session.getAttribute("lname").toString().isEmpty()) {
							%>
							<td><input type="text" name="lname" id="lname" size="20" maxlength="20" 
								value=<%=session.getAttribute("lname").toString()%> /></td>

							<%
								} else {
							%>
							<td><input type="text" name="lname" id="lname" size="20" maxlength="20" /></td>

							<%
								}
							%>
						</tr>

						<tr>
							<td>Username*</td>
							<%
								if (session != null && session.getAttribute("username") != null
										&& !session.getAttribute("username").toString().isEmpty()) {
							%>
							<td><input type="text" name="username" id="username"
								size="20" maxlength="20"  
								value="<%=session.getAttribute("username").toString()%>" /></td>

							<%
								} else {
							%>
							<td><input type="text" id="username" name="username"
								size="20" maxlength="20"  /></td>

							<%
								}
							%>

							<td>Email*</td>
							<%
								if (session != null && session.getAttribute("email") != null
										&& !session.getAttribute("email").toString().isEmpty()) {
							%>
							<td><input type="text" name="email" id="email" size="30" maxlength="30" 
								value="<%=session.getAttribute("email").toString()%>" /></td>

							<%
								} else {
							%>
							<td><input type="text" id="email" name="email" size="30" maxlength="30" /></td>

							<%
								}
							%>



							<td>Password*</td>
							<td><input type="password" id="password" name="password"
								size="20" maxlength="20"  /></td>
						</tr>
						<tr>
						<%-- 	<td>Country*</td>
							<%
								if (session != null && session.getAttribute("country") != null
										&& !session.getAttribute("country").toString().isEmpty()) {
							%>
							<td><input type="text" id="country" size="20" maxlength="20"  name="country"
								value="<%=session.getAttribute("country").toString()%>" /></td>

							<%
								} else {
							%>
							<td><input type="text" id="country" size="20" maxlength="20"  name="country" /></td>

							<%
								}
							%>
 --%>							<td colspan="2" align="center">Zipcode*</td>
							<%
								if (session != null && session.getAttribute("zipcode") != null
										&& !session.getAttribute("zipcode").toString().isEmpty()) {
							%>
							<td colspan="2" align="center"><input type="text" id="zipcode" size="15" name="zipcode" maxlength="5" 
								value="<%=session.getAttribute("zipcode").toString()%>" /></td>

							<%
								} else {
							%>
							<td colspan="2" align="center"><input type="text" id="zipcode" size="15" name="zipcode" maxlength="5" /></td>

							<%
								}
							%>

						</tr>
						<tr>

							<td><input type="submit" value="Submit" /></td>

							<td><input type="reset" value="Clear all values" /></td>
						</tr>

					</table>
				</fieldset>
			</form>
		</center>
	</div>
	</center>
</body>
</html>