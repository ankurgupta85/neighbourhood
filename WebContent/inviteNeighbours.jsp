<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript" src="inviteNeighbours.js"></script>
<script type="text/javascript" src="disableRightClick.js"></script>
</head>
<body bgcolor="white">
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

String username=null;

if(session!=null && session.getAttribute("username") !=null)
{
	username=session.getAttribute("username").toString();
}%>
<b><font size="2"  style="font-family: cursive;color: black;background-color: white">Invite Neighbours:</font></b>
	<form method="post" action="InviteNeighbour" name="inviteNeighbour"
		onsubmit="return validateInvite();" target="_top">
		<input type="text" name="inviteEmail" id="inviteEmail" style="font-family: cursive;font-size: 2;color: black;background-color: white"/><input
			type="hidden" value="<%=username%>" name="username" /><br> <input
			type="submit" value="Invite"  style="font-family: cursive;font-size: 2;color: black;background-color: white"/>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
			type="reset" value="Clear"  style="font-family: cursive;font-size: 2;color: black;background-color: white"/>
		
	</form>
	</center>
</body>
</html>