<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.*,com.neighbourhood.request.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
/* System.out.println("In cancelRequest.jsp"); */
String acceptRequest=request.getQueryString();
String[] splitRequest=acceptRequest.split("=");
String username=splitRequest[1];
boolean accepted=Request.cancelRequest(session.getAttribute("username").toString(),username);
if(accepted)
{
	session.setAttribute("message", "Request for "+username+" has been cancelled");
	/* HashMap<String,String> showSentRequest=(HashMap<String,String>)session.getAttribute("showSentRequest");
			if(showSentRequest.containsKey(username))
			{
				
				showSentRequest.remove(username);
				session.setAttribute("showSentRequest", showSentRequest);

				
			}
 */	
	
}
else
{
	session.setAttribute("message", "There was some problem cancelling your request for  "+username);

}


response.sendRedirect("user.jsp");
%>

</body>
</html>