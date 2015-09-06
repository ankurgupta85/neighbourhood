<%@page import="com.neighbourhood.neighbours.Neighbours"%>
<%@page import="com.neighbours.imageUpload.RetrieveImage"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript">
function checkRadio(){
	
	var radioLength=document.setProfilePic.profilePic;
	var checked=false;
	//alert("Radio Length "+radioLength);
	for( var i = 0; i<radioLength.length;i++)
		{
			
		
		if(radioLength[i].checked)
			{
			checked=true;
			break;
			}
		}
	
	if(!checked)
		{
		alert("Please select atleast one pic");
		return false;
		}
	else
		{
		return true;
		}
	
}





</script>

</head>
<body>

<%

String username = null;
if (session.getAttribute("currentUserNeighbour") != null) {
	session.removeAttribute("currentUserNeighbour");
}
if (session.getAttribute("otherUser") != null) {
	session.removeAttribute("otherUser");
}

if (session.getAttribute("username") != null) {
	username = session.getAttribute("username").toString();

} else {
	response.sendRedirect("user.jsp");
}

%>
<br><br><center>
<font size="2" style="font-family: cursive;">Images for <%=Neighbours.getFullName(username) %></font><br><br>
<%	
		List<String> imagesNames = RetrieveImage
				.getAllImagesForUser(username);
		if (imagesNames.size() == 0) {
		%>	<font size="2"
					style="font-family: cursive; color: black; background-color: white;">There
					are no images. Please upload them using Upload Images Link above.</font>
<% 
		} else {
			%>			
		
		<form onsubmit="return checkRadio();" action="SetProfilePic" method="post" name="setProfilePic" target="_top">	
			<table cellpadding="10" border="1" cellspacing="10" width="auto"
				height="auto">
				<tr>
					<%
					int i=0;
						for (String imageName : imagesNames) {
								/* 	System.out.println(i);
								 */// if i is multiple of 3 then new row
								if ((i % 5) == 0) {
					%>
				</tr>
				<tr>
					<%
						}
								// if i is not multiple of 3 display the images in <td> and increment i
								String imageSrc = RetrieveImage.getImagePath(username, imageName);
					
								 
					%>
					<td bordercolor="blue"><font size="2"
						style="font-family: cursive; color: black; background-color: white;">
							<img src="<%=imageSrc%>" alt="Error" width="75" height="75"
							border="0"
							onclick="window.open('<%=imageSrc%>', '<%=imageName%>', 'width=300,height=300,resizabel=yes,toolbar=no,left=200,top=200')" />
							<br>
							<center><%=imageName%>
							<br>
							<input type="radio" name="profilePic" value="<%=imageName %>" id="profilePic" />
							</center>
					</font></td>
					<%
						i++;

							}
					%>
				</tr>
			</table>
			<br>
<center>
<input type="submit" value="Set Profile Pic" style="font-family: cursive; font-size: 2; color: black; background-color: white;" />
</center>


</form>
			<%
				}
			%>
</center>
</body>
</html>