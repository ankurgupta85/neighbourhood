<%@page import="com.neighbourhood.neighbours.Neighbours"%>
<%@page import="com.neighbourhood.user.UserInfo"%>
<%@page import="com.neighbourhood.user.EnterPost"%>
<%@page import="com.neighbourhood.request.Request"%>
<%@page import="com.neighbourhood.user.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.*" %>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
/* System.out.println("In acceptRequest.jsp"); */
String acceptRequest=request.getQueryString();
String[] splitRequest=acceptRequest.split("=");
String username=splitRequest[1];
boolean accepted=Request.acceptedRequest(session.getAttribute("username").toString(),username);
if(accepted)
{
	session.setAttribute("message", Neighbours.getFullName(username)+" is now your neighbour");
	/* List<User> requestsFromList=(HashMap<String,String>)session.getAttribute("requestsFromList");
	
	if(requestsFromList.containsKey(username))
	{
		requestsFromList.remove(username);
		session.setAttribute("requestsFromList", requestsFromList);
		
	}
	 */
	 String user=session.getAttribute("username").toString();
	 String post="<a href=otheruser.jsp?username="+user+">"+Neighbours.getFullName(user)+"</a> is now my neighbour";
	 boolean addedNeighbourPost=EnterPost.enterNewPost(username, post);
	 
	
	
}
else
{
	session.setAttribute("message", "There was some problem adding "+Neighbours.getFullName(username) +" as your neighbour");

}


response.sendRedirect("user.jsp");
%>
</body>
</html>