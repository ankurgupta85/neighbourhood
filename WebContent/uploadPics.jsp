<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript" src="disableRightClick.js"></script>

<script type="text/javascript">
	function addRows() {

		var TABLE = document.getElementById('tableUpload');

		var TR = document.createElement('tr');
		/* var TD1 = document.createElement('td'); */
		var TD2 = document.createElement('td');

		/* TD1.innerHTML = "<font size='2' style='font-family: cursive; color: black; background-color: white;''>Profile	Pic: </font><input type='checkbox' name='check'	style='font-family: cursive; font-size: 2; color: black; background-color: white;' />"; */
		TD2.innerHTML = "<input type='file' name='file'	style='font-family: cursive; font-size: 2; color: black; background-color: white;'>"

		/* TR.appendChild(TD1); */
		TR.appendChild(TD2);
		TABLE.appendChild(TR);

	}
	
	function validateUploadPics()
	{
		var length=document.UploadPics.check.length;
		var count=0;
		i = 0;
		for(;i < length; i++)
		{
			if(document.UploadPics.check[i].checked== true)
				count++;
		}
		if(count > 1)
			{
			alert("Please select only one profile pic name");
			return false;
			}
		return true;
		
		
	}
</script>
</head>
<body bgcolor="white">
	<center>
		<%
			if (session.getAttribute("currentUserNeighbour") != null) {
				session.removeAttribute("currentUserNeighbour");
			}
			if (session.getAttribute("otherUser") != null) {
				session.removeAttribute("otherUser");
			}
			/* if(session.getAttribute("eventTopic") !=null)
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
		%>
		<br> <br> <b><font size="2"
			style="font-family: cursive; color: black; background-color: white;">Upload
				Pics</font></b> <br> <br>
		<form action="UpLoadImage.jsp" method="post" target="_top"
			enctype="multipart/form-data" onsubmit="return validateUploadPics();" name="UploadPics">
			<table border="0" width="50%" id="tableUpload" align="center">
						 
				<tr>
					<!-- <td><font size="2"
						style="font-family: cursive; color: black; background-color: white;">Profile
							Pic: </font><input type="checkbox" name="check" 
						style="font-family: cursive; font-size: 2; color: black; background-color: white;" /></td> -->
					<td><font size="2"
						style="font-family: cursive; color: black; background-color: white;"><input type="file" name="file"
						style="font-family: cursive; font-size: 2; color: black; background-color: white;"></font>
						
					</td>
				</tr>
			</table>
			<br>
			<br>
			<input type=submit value="Upload"
				style="font-family: cursive; font-size: 2; color: black; background-color: white;">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" onclick="addRows();" value="Add More Pics"
				style="font-family: cursive; font-size: 2; color: black; background-color: white;" />
		</form>

	</center>
</body>
</html>