<%@page import="com.neighbourhood.neighbours.Neighbours"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="com.neighbourhood.status.*,java.util.*,com.neighbours.imageUpload.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript" src="disableRightClick.js"></script>
<script type="text/javascript">
function zoomin(img, height, width) {
    img.height = height;
    img.width = width;
}

function zoomout(img,height,width)
{
	
	img.height = height;
    img.width = width;
}
</script>
</head>
<body bgcolor="white">
<center>
	<%
	/* System.out.println("In Get Full Neighbour List"); */

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
	if (session != null && session.getAttribute("username") != null) {
		username = session.getAttribute("username").toString();
	} else {
		response.sendRedirect("index.jsp");
	}

	String userRequest = request.getQueryString();
	String[] splitRequest = userRequest.split("=");
	String otherUser = splitRequest[1];

	//check if the current user and otheruser are neighbours
	
	if(NeighbourhoodStatus.getNeighboursStatus(username, otherUser).equals(NeighbourhoodStatus.NEIGHBOURS))
	{
	
		%>
		<font size="2" style="font-family: cursive;color: black;background-color: white;"><%=Neighbours.getFullName(otherUser)%> Images</font><br>
		<br> <%
	List<String> imagesNames = RetrieveImage
				.getAllImagesForUser(otherUser);
		if (imagesNames.size() == 0) {
%> <font size="2" style="font-family: cursive;color: black;background-color: white;">There are no images uploaded by <%=Neighbours.getFullName(otherUser)%></font> <%
	} else {
			int i = 0;
%>
			<table cellpadding="10" border="0"  cellspacing="10" width="auto"
				height="auto">
				<tr>
					<%
						for (String image : imagesNames) {
								/* 	System.out.println(i);
								 */	// if i is multiple of 3 then new row
									if ((i % 5) == 0) {
					%>
				</tr>
				<tr>
					<%
						}
									// if i is not multiple of 3 display the images in <td> and increment i
									String imageSrc = "http://localhost:8080"
											+ pageContext.getServletContext()
													.getContextPath() + "/images_users/"
											+ otherUser + "/" + image;
									/* System.out.println(imageSrc); */
					%>
					<td><font size="2" style="font-family: cursive;color: black;background-color: white;"><img src="<%=imageSrc%>" alt="Error" width="75"
						height="75" border="0" onmouseover="zoomin(this,200,200);" onmouseout="zoomout(this,75,75);" 
						onclick="window.open('<%=imageSrc%>', '<%=image%>', 'width=300,height=300,resizabel=yes,toolbar=no,left=200,top=200')" />
						<br> <%=image%></font></td>
					<%
						i++;

								}
					%>
				</tr>
			</table> <%
	}
	

	}
	else
	{
		
	%>	
	
		<font size="2" style="font-family: cursive;color: black;background-color: white;">You are not neighbour of <%=otherUser %>.</font>
		<%
	}
					%>


				
</center>
</body>
</html>