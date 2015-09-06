<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="com.neighbourhood.neighbours.Neighbours"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
		String username = null;
		if (session != null && session.getAttribute("username") != null) {
			username = session.getAttribute("username").toString();
		} else {
			response.sendRedirect("index.jsp");
		}

		String otherUser = null;
		String userRequest = request.getQueryString();
		String[] splitRequest = userRequest.split("=");
		otherUser = splitRequest[1];

		boolean unblockDone = false;

		unblockDone = Neighbours.unblockUpdates(username, otherUser);
		if (unblockDone) {
			session.setAttribute(
					"unblockMessage",
					"Post/Updates have been unblocked for "
							+ Neighbours.getFullName(otherUser));

		} else {
			session.setAttribute("unblockMessage",
					"Problem encountered while unblocking Post/Updates for "
							+ Neighbours.getFullName(otherUser));

		}

		response.sendRedirect("user.jsp");
	%>
</body>
</html>