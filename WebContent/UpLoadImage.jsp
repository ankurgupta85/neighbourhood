<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="org.apache.commons.fileupload.disk.DiskFileItemFactory,org.apache.commons.io.*,java.util.*,java.io.File"%>
<%@ page
	import="org.apache.commons.fileupload.servlet.*,org.apache.commons.fileupload.*"%>
<%@page import="com.neighbours.imageUpload.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="disableRightClick.js"></script>
<title>Insert title here</title>
</head>
<body>
	<center>
		<%
		String message="";
		String username=null;
			if (session.getAttribute("currentUserNeighbour") != null) {
				session.removeAttribute("currentUserNeighbour");
			}
			if (session.getAttribute("otherUser") != null) {
				session.removeAttribute("otherUser");
			}
			
			if(session.getAttribute("username") !=null)
			{
				username=session.getAttribute("username").toString();
				
			}
			else
			{
				response.sendRedirect("user.jsp");
			}
			/* if(session.getAttribute("eventTopic") !=null)
			 {
			 session.removeAttribute("eventTopic");
			 session.removeAttribute("eventDescription");
			 session.removeAttribute("date_time_event");
			 session.removeAttribute("flag");
			
			 } */

		int maxFileSize = 50000 * 1024;
			int maxMemSize = 50000 * 1024;
			boolean profilePic = false;
			String contentType = request.getContentType();
			if (contentType.indexOf("multipart/form-data") >= 0) {
				DiskFileItemFactory factory = new DiskFileItemFactory();

				// maximum size that will be stored in memory
				factory.setSizeThreshold(maxMemSize);

				// Location to save data that is larger than maxMemSize.
				factory.setRepository(new File("c:\\"));

				// Create a new file upload handler
				ServletFileUpload upload = new ServletFileUpload(factory);

				// maximum file size to be uploaded.
				upload.setSizeMax(maxFileSize);

				try {
					// Parse the request to get file items.
					List fileItems = upload.parseRequest(request);

					// Process the uploaded file items
					Iterator iter = fileItems.iterator();
					while (iter.hasNext()) {
						FileItem fi = (FileItem) iter.next();

						// check if the current file item is form field.
						//check if form field, get value of check

						if(fi.getFieldName()!=null && fi.getName()!=null && !fi.getFieldName().isEmpty() && !fi.getName().isEmpty())
						{
						/* if (fi.isFormField()
								&& fi.getFieldName().equals("check")
								&& fi.getString().equals("on")) {

							profilePic = true;
						}
 */						// if it is form field, get username value

/* 						else if (fi.isFormField()
								&& fi.getFieldName().equals("username")) {
							username = fi.getString();
							 System.out.println(username); 
						}
						*/
 						// if it is not form field, then it must be image
						// check if the content type is image
						if (fi.getContentType().contains("image")) {

							// if image size is greater than max allowed size
							if (fi.getSize() > maxFileSize) {
								message=message+"The file "+fi.getName()+" is too large<br>";
								session.setAttribute("message",message);
								continue;
							}
							// if image size is less than or equal to max allowed size
							else {
								// Then add the entry in table with user profile picture name
								ServletContext context = pageContext
										.getServletContext();
								String filePath = context
										.getInitParameter("file-upload");
								File f = new File(filePath);
								String[] directories = f.list();
								boolean found = false;

								// Check if the user folder exist 
								for (String directory : directories) {
									if (directory.equals(username)) {
										found = true;
										break;
									}
								}
								File f1 = new File(filePath + username + "\\");
								// if does not exist, create folder
								if (!found) {
									if (!f1.exists()) {
										f1.mkdir();
										f1.setWritable(true);

									}
								}

								boolean sameName = false;
								// if exist then check if the filename is same as already present file 
								String[] fileList = f1.list();
								for (String file : fileList) {
									if (file.equals(fi.getName())) {
										sameName = true;
										break;
									}
								}
								// if file with same name exist
								if (sameName) {
									message+="The file with name "+fi.getName()+" already exists<br>";
									session.setAttribute("message",message);
									continue;
								}

								// if the file with same name doest not exist, save image
								filePath = filePath + username + "\\";
								boolean isInMemory = fi.isInMemory();
								long sizeInBytes = fi.getSize();
								// Write the file
								String fileName = fi.getName();
								File newFile = null;
								if (fileName.lastIndexOf("\\") >= 0) {
									newFile = new File(filePath
											+ fileName.substring(fileName
													.lastIndexOf("\\")));
								} else {
									newFile = new File(filePath
											+ fileName.substring(fileName
													.lastIndexOf("\\") + 1));
								}
								fi.write(newFile);

								/* System.out.println("Profile Pic "+profilePic); */
								/* if (profilePic) {
									boolean profilePicSet = SaveImage
											.saveProfilePic(fileName, username);
									if (profilePicSet) {
										session.setAttribute("message",
												"File successfully Uploaded and saved to database");

									} else {
										session.setAttribute("message",
												"File successfully Uploaded but not saved to database");

									}
								} else { */
									message+="File "+fi.getName()+" is successfully uploaded<br>";
									session.setAttribute("message",message);
											

								//}

							}

						}
						// check if the type of file uploaded is not image
						else
							if (!fi.getContentType().contains("image")) {
								message+="The file "+ fi.getName()+" is not an image file<br>";
								session.setAttribute("message",message);
								
								continue;
							
						}

					}

					}
				} catch (Exception e) {
					session.setAttribute("message",
							"Could not upload Image. Some Exception Encountered");
				}

			} else {
				session.setAttribute("message",
						"Image could not be uploaded because of some error");

			}

			response.sendRedirect("user.jsp");
		%>
	</center>
</body>
</html>