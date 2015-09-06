package com.neighbours.imageUpload;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * Servlet implementation class UpLoadImage
 */
@WebServlet("/UpLoadImage")
public class UpLoadImage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpLoadImage() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// check if the type of file is image
		// if image then check if size of file is as per the max size allowed
		// Check if the user folder exist 
		// if does not exist, create folder
		// if exist then directly save image
		// Then add the entry in table with user profile picture name

		String username=null;
		int maxFileSize = 5000 * 1024;
		 int maxMemSize = 5000 * 1024;
		   
		String contentType = request.getContentType();
		   if(contentType.indexOf("multipart/form-data") >= 0)
		   {
			  DiskFileItemFactory factory=new DiskFileItemFactory();
			  
			// maximum size that will be stored in memory
			  factory.setSizeThreshold(maxMemSize);
			  
			// Location to save data that is larger than maxMemSize.
			  factory.setRepository(new File("c:\\"));
			 
			  // Create a new file upload handler
		      ServletFileUpload upload = new ServletFileUpload(factory);
		     
		      // maximum file size to be uploaded.
		      upload.setSizeMax( maxFileSize );
		     
		      try{ 
		          // Parse the request to get file items.
		          List fileItems = upload.parseRequest(request);

		          // Process the uploaded file items
		          Iterator iter = fileItems.iterator();
		          while(iter.hasNext())
		          {
		        	  FileItem fi=(FileItem)iter.next();
		        	  
		        	  // check if the current file item is form field.
		        	  // if it is form field, get username value
		        	  		        	  
		        	  if(fi.isFormField() && fi.getFieldName().equals("username"))
		        	  {
		        		  username=fi.getString();
/*		        		  System.out.println(username);
*/		        	  }
		        	  // if it is not form field, then it must be image
		        	  // check if the content type is image
		        	  else if(fi.getContentType().contains("image"))
		        	  {
		        		  
		        		  
		        		  
		        	  }
		        	  // check if the type of file uploaded is not image
		        	  else
		        		  if(!fi.getContentType().contains("image"))
		        		  {
		        			  
		        		  }
		        	  
		        	  
		        	  
		        	  
		          }
		          
		          
		          
		          
		          
		      }
		      catch(Exception e)
		      {
		    	  request.getSession().setAttribute("message", "Could not upload Image. Some Exception Encountered");
		      }
			   
		   }
		   else
		   {
			   request.getSession().setAttribute("message", "Image could not be uploaded because of some error");
			   
		   }
		   		
		response.sendRedirect("user.jsp");
	}

}
