package com.neighbourhood.user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UpdateStatus
 */
public class UpdateStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static boolean updated=false;   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateStatus() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	/*	System.out.println("In UpdateStatus");
	*/	String username=request.getParameter("username");
		String post=request.getParameter("post");
	/*	System.out.println(username+"    "+post);
	*/	
		if(post.length()>=150)
		{
			request.getSession().setAttribute("message", "Post cannot have more than 150 characters");
			
		}
		else
		{
		
			updated=EnterPost.enterNewPost(username,post);
			
			if(updated)
			{
				request.getSession().setAttribute("message", "Post have been entered");
				
			}
			else
			{
				request.getSession().setAttribute("message", "Problem posting");
				
			}
		}
		
		response.sendRedirect("user.jsp");
	}

}
