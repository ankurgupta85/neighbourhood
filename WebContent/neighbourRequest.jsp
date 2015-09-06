<%@page import="com.neighbourhood.neighbours.Neighbours"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.neighbourhood.request.NeighbourRequest"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.neighbourhood.status.NeighbourhoodStatus" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="disableRightClick.js"></script>
<title>Insert title here</title>
</head>
<body bgcolor="white">
<%

/* System.out.println("In neighbourRequest.jsp"); */
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
boolean requestSent=false;
String neighbourRequest = request.getQueryString();
String[] splitRequest=neighbourRequest.split("=");
String neighbourUsername=splitRequest[1];
String status=NeighbourhoodStatus.getNeighboursStatus(session.getAttribute("username").toString(), neighbourUsername);
if(status.equals(NeighbourhoodStatus.REQUEST_FOR_NEIGHBOURS))
{
	
	// Display the neighbours homepage/profile along with message that request already been sent
	%>
	
	<font size="2" style="font-family: cursive;color: black;background-color: white;">Request to <%=Neighbours.getFullName(neighbourUsername) %> has been  already sent</font>
	
	<% 
	
}
else
	 if(status.equals(NeighbourhoodStatus.NOT_NEIGHBOURS))
	 {
		//enter the value in "neighbours" table
		 
		requestSent=NeighbourRequest.addNeighbourRequest(session.getAttribute("username").toString(), neighbourUsername);
		/* System.out.println(requestSent); */
		/* HashMap<String,String> recommendationList=(HashMap<String,String>)session.getAttribute("recommendationList"); */
		/* if(recommendationList!=null && recommendationList.containsKey(neighbourUsername))
		{
			recommendationList.remove(neighbourUsername);
			session.setAttribute("recommendationList", recommendationList);
				
		}
		 */
		//Display neighbours page with message that request has been sent 
		if(requestSent)
		session.setAttribute("message", "Your request has been sent to "+Neighbours.getFullName(neighbourUsername));
		else
		{
			session.setAttribute("message", "Problem sending request to "+Neighbours.getFullName(neighbourUsername));
		}
		 
	 }
	
response.sendRedirect("user.jsp");
%>

</body>
</html>