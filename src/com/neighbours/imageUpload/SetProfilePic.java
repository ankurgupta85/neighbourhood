package com.neighbours.imageUpload;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SetProfilePic
 */
@WebServlet("/SetProfilePic")
public class SetProfilePic extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SetProfilePic() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username=null;
		String profilePicName = request.getParameter("profilePic");
		if(request.getSession().getAttribute("username") == null)
		{
			response.sendRedirect("user.jsp");
		}
		else
		{
			username=request.getSession().getAttribute("username").toString();
		}
		 
		
		boolean profilePicChanged=SaveImage.saveProfilePic(profilePicName, username);
		if(profilePicChanged)
		{
			request.getSession().setAttribute("message", "Your Profile Pic has been changed");
			
		}
		else
		{
			request.getSession().setAttribute("message", "Profile pic not changed. Please try again");
		}
		
		response.sendRedirect("user.jsp");
	}

}
