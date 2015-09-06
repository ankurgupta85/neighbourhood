<%@page import="com.neighbours.imageUpload.RetrieveImage"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="java.util.*,com.neighbourhood.neighbours.*,com.neighbourhood.user.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<!-- <script type="text/javascript" src="disableRightClick.js"></script> -->
</head>
<body bgcolor="white">
	<center>

		<br> <br> <b><font size="2"
			style="font-family: cursive; color: black; background-color: white;">Neighbours</font></b>


		<%
			if (session.getAttribute("currentUserNeighbour") != null) {
				session.removeAttribute("currentUserNeighbour");
			}
			if (session.getAttribute("otherUser") != null) {
				session.removeAttribute("otherUser");
			}

			/* if (session.getAttribute("eventTopic") != null) {
				session.removeAttribute("eventTopic");
				session.removeAttribute("eventDescription");
				session.removeAttribute("date_time_event");
				session.removeAttribute("flag");

			} */
			String username = session.getAttribute("username").toString();
			List<User> neighbourList = Neighbours.getNeighboursList(username);

			if (neighbourList.isEmpty()) {
		%>
		<font size="2"
			style="font-family: cursive; color: black; background-color: white;">You
			dont have any neighbours. Please check Recommendation List or search
			for your neighbours</font>
		<%
			} else {

				List<String> zipcodeList = GetParsedNeighbours
						.parseZipCodeList(neighbourList);
		%>

		<br> <br> <font size="2"
			style="font-family: cursive; color: black; background-color: white;"><a
			href="showneighbours.jsp" target="main"
			style="text-decoration: none;"><font size="2"
				style="font-family: cursive; color: black; background-color: white; text-decoration: none;">Show
					All Neighbours</font> <font size="1"
				style="font-family: cursive; color: black; background-color: white; text-decoration: none;">(<%=Neighbours.getNeighboursListSize(username)%>)
			</font></a></font> <br> <br> <font size="2"
			style="font-family: cursive; color: black; background-color: white;">Neighbours
			By Zipcode</font> <br> <br>
		<%
			int i = 0;
		%>
		<table border="0" cellpadding="2" cellspacing="2" align="center"
			width="80%">
			<tr>
				<%
					for (int index = 0; index < zipcodeList.size(); index++) {
				%>

				<%
					String Zipcode = zipcodeList.get(index);
							/* 	System.out.println(i);
							 */// if i is multiple of 3 then new row
							if ((i % 5) == 0) {
				%>
			</tr>
			<tr>
				<%
					}
				%>
				<td bordercolor="blue" align="center" width="10" height="30"><font
					size="2"
					style="font-family: cursive; color: black; background-color: white;"><a
						href="showneighboursForZipcode.jsp?zipcode=<%=Zipcode%>"
						target="main" style="text-decoration: none;"><font size="2"
							style="font-family: cursive; color: black; background-color: white; text-decoration: none; text-align: center;"><%=Zipcode%></font>
							<font size="1"
							style="font-family: cursive; color: black; background-color: white; text-decoration: none;">(<%=GetParsedNeighbours
							.getSizeOfParsedNeighboursByZipcode(neighbourList,
									Zipcode)%>)
						</font> </a></font></td>

				<%
					i++;

						}
				%>





			</tr>

		</table>



		<%
			}
		%>












		<br> <br>




	</center>
</body>
</html>