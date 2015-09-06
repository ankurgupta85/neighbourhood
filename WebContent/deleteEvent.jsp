<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="com.neighbourhood.event.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
		/* System.out.println("In eventDetails.jsp"); */
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
			
	} */
		
		
	
		String username = null;
		if (session == null || session.getAttribute("username") == null) {
			response.sendRedirect("index.jsp");
		} else {

			username = session.getAttribute("username").toString();
		}
		String eventDetails = request.getQueryString();
		String[] splitRequest = eventDetails.split("=");
		int event_id = Integer.parseInt(splitRequest[1]);

		EventInfo event = ShowEvents.getEventInfo(event_id);
		if (event == null) {
			session.setAttribute("message", "Event could not be found");
		}
		else
		{
			boolean eventDeleted=EventCreation.deleteEvent(event_id);
			if(eventDeleted)
			{
				session.setAttribute("message", "Event deleted successfully");
			}
			else
			{
				session.setAttribute("message", "Event could not be deleted");
			}
		}
		
		response.sendRedirect("user.jsp");
	%>


</body>
</html>