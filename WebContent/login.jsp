<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript" src="login.js" ></script>
<script type="text/javascript" src="disableRightClick.js"></script>
</head>
<body>
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

/* if(session.getAttribute("eventTopic") !=null)
{
	session.removeAttribute("eventTopic");
	session.removeAttribute("eventDescription");
	session.removeAttribute("date_time_event");
	session.removeAttribute("flag");
		
} */
String errorMessage=null;
Object errorMessageObject=session.getAttribute("errorMessage");
if(errorMessageObject!=null)
{
	errorMessage=errorMessageObject.toString();
	
}


%>
<center>
<% if(errorMessage!=null)
{
%>
<font style="color: red;"><%=errorMessage %>
<%}

session.removeAttribute("errorMessage");
%>
<br>
<br>
<form name="login" action="Login" method="post" onsubmit="return validate();">
Username:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="username" id="username" /><br>
Password:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="password" name="password" id="password"/><br>
<input type="submit" value="Login" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="reset" value="Clear" />
</form>
</center>
</center>
</body>
</html>