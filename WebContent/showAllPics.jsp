<%@page import="com.neighbours.imageUpload.RetrieveImage,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
			if (session.getAttribute("currentUserNeighbour") != null) {
				session.removeAttribute("currentUserNeighbour");
			}
			if (session.getAttribute("otherUser") != null) {
				session.removeAttribute("otherUser");
			}
			/* 	if (session.getAttribute("eventTopic") != null) {
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

			List<String> imagesNames = RetrieveImage
					.getAllImagesForUser(username);
			if (imagesNames.size() == 0) {
		%>

		<font size="2"
			style="font-family: cursive; color: black; background-color: white;">There
			are no images. Please upload them using Upload Images Link above.</font>

		<%
			} else {
		%>
		<br> <br>
		<%
			// Implement Paging...
				final int NUMBER_OF_RECORDS_PERPAGE_DEFAULT = 20;

				int numPages = 0;

				int numRows = imagesNames.size();
				String startIndexString = request.getParameter("startIndex");
				if ((startIndexString == null)
						|| (startIndexString.length() == 0)) { //for pagination if page is loaded first time
					startIndexString = "0";
				}

				int startIndex = Integer.parseInt(startIndexString);
				int numRecordsPerPage = 0;
				if (request.getParameter("txtnumrec") == null)
					numRecordsPerPage = NUMBER_OF_RECORDS_PERPAGE_DEFAULT;
				else
					numRecordsPerPage = Integer.parseInt(request
							.getParameter("txtnumrec"));

				numPages = numRows / numRecordsPerPage;
				int remain = numRows % numRecordsPerPage;
				if (remain != 0)
					numPages = numPages + 1;

				int startpoint = 0;
				String temp = "";
				for (int inum = 1; inum <= numPages; inum++) {
					temp = temp + "<a href=\"showAllPics.jsp?startIndex="
							+ startpoint + "&txtnumrec=" + numRecordsPerPage
							+ "\" >" + inum + "</a> ";
					startpoint = startpoint + numRecordsPerPage;
				}

				int increment = 0;
				if ((startIndex + numRecordsPerPage) <= numRows) {

					increment = startIndex + numRecordsPerPage;
				} else {

					if (remain == 0) {
						increment = startIndex + numRecordsPerPage;
					} else {
						increment = startIndex + remain;
					}//end of inner if
				}//end of if
		%>

		<%-- 	   <%=numRows%>
		Record(s) found
	
		Displaying records:
		<%
		if (startIndex + numRecordsPerPage < numRows) {
	%>
		<%=startIndex + 1%>
		-
		<%=increment%>
		<%
			} else {
		%>
		<%=startIndex + 1%>
		-
		<%=numRows%>
		<%
			}
		%>
	
 --%>


		<table width="100%" border="0">

			<tr>
				<td width="43%" scope="col" class="HdrParagraph">
					<%
						if (startIndex != 0) {
					%> <a
					href="showAllPics.jsp?startIndex=<%=startIndex - numRecordsPerPage%>&txtnumrec=<%=numRecordsPerPage%>"
					style="text-decoration: none;"><font size="1.5" color="black"
						style="font-family: cursive;">Previous</font></a> <%
 	}
 %>
				</td>
				<%-- <td width="20%" scope="col" class="HdrParagraph">Page:<%=temp%></td> --%>
				<td width="37%" align="right" class="HdrParagraph">
					<div align="right">
						<%
							if (startIndex + numRecordsPerPage < numRows) {
						%>
						<a
							href="showAllPics.jsp?startIndex=<%=startIndex + numRecordsPerPage%>&txtnumrec=<%=numRecordsPerPage%>"
							style="text-decoration: none;"><font size="1.5" color="black"
							style="font-family: cursive;">Next</font></a>
						<%
							}
						%>
					</div>
				</td>
			</tr>
		</table>










		<%
			int i = 0;
		%>
		<table cellpadding="10" border="0" cellspacing="10" width="auto"
			height="auto">
			<tr>
				<%
					for (int index = startIndex; index < increment; index++) {
							String image = imagesNames.get(index);
							/* 	System.out.println(i);
							 */

							// if i is multiple of 3 then new row
							if ((i % 5) == 0) {
				%>
			</tr>
			<tr>
				<%
					}
							// if i is not multiple of 3 display the images in <td> and increment i
							String imageSrc = RetrieveImage.getImagePath(username,
									image);
							/* System.out.println(imageSrc); */
				%>
				<td bordercolor="blue"><font size="2"
					style="font-family: cursive; color: black; background-color: white;">
					  
						<img src="<%=imageSrc%>" alt="Error" width="75" height="75" id="<%=image %>"
						name="image" border="0" onmouseover="zoomin(this,200,200);" onmouseout="zoomout(this,75,75);"
						onclick="window.open('<%=imageSrc%>', '<%=image%>', 'width=300,height=300,resizabel=yes,toolbar=no,left=200,top=200')" />
						<br> <%=image%>
				</font></td>
				<%
					i++;

						}
				%>
			</tr>
		</table>


		<%
			}
		%>
	</center>
</body>
</html>