<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="com.neighbourhood.request.*" %>
    <%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript" src="disableRightClick.js"></script>
</head>
<body>

<%

/* System.out.println("In rejectRequest.jsp"); */
String rejectRequest=request.getQueryString();
String[] splitRequest=rejectRequest.split("=");
String username=splitRequest[1];
boolean rejected=Request.rejectedRequest(session.getAttribute("username").toString(),username);
if(rejected)
{
	session.setAttribute("message", "You have declined the neighbour request of "+username);
//	HashMap<String,String> requestsFromList=(HashMap<String,String>)session.getAttribute("requestsFromList");
	// if(requestsFromList.containsKey(username))
//	{
	//	requestsFromList.remove(username);
		//session.setAttribute("requestsFromList", requestsFromList);
	//}
	 
 }
else
{
	session.setAttribute("message", "There was some problem deleting request from "+username+" as your neighbour");

}


response.sendRedirect("user.jsp");




%>
</body>
</html>