<%@page import="com.neighbourhood.neighbours.Neighbours"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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

		boolean blockDone = false;

		blockDone = Neighbours.blockUpdates(username, otherUser);
		if (blockDone) {
			session.setAttribute(
					"blockMessage",
					"Post/Updates have been blocked for "
							+ Neighbours.getFullName(otherUser));

		} else {
			session.setAttribute("blockMessage",
					"Problem encountered while blocking Post/Updates for "
							+ Neighbours.getFullName(otherUser));

		}

		response.sendRedirect("user.jsp");
	%>
</body>
</html>