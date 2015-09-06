<%@page import="com.neighbourhood.request.NeighbourRequest"%>
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

		if (session == null || session.getAttribute("username") == null) {
			response.sendRedirect("index.jsp");
		} else {
			username = session.getAttribute("username").toString();

			String userRequest = request.getQueryString();
			String[] splitRequest = userRequest.split("=");
			String otherUser = splitRequest[1];
			//out.println(otherUser+"      "+username);
			if (otherUser != null && !otherUser.isEmpty()) {
				boolean neighbourDeleted = Neighbours
						.removeNeighbours(username, otherUser);
				if (neighbourDeleted) {
					session.setAttribute("neighbourDeleted", "Neighbour "
							+ Neighbours.getFullName(otherUser)
							+ " successfully removed from your list");

				} else {
					session.setAttribute("neighbourDeleted",
							"Some problem occured while removing "
									+ Neighbours.getFullName(otherUser)
									+ " from your list");
				}

			} else {

				session.setAttribute(
						"neighbourDeleted",
						"Some problem occured while removing "
								+ Neighbours.getFullName(otherUser)
								+ " from your list");

			}

			response.sendRedirect("user.jsp");

		}
	%>

</body>
</html>