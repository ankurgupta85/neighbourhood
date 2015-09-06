package com.neighbourhood.user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ChangeUserPassword
 */
@WebServlet("/ChangeUserPassword")
public class ChangeUserPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangeUserPassword() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String userName=request.getParameter("username");
		String oldPassword=request.getParameter("old_password");
		User userObj=UserInfo.getUserInfoByUsername(userName);
		if(!(oldPassword.equals(userObj.getPassword())))
		{
			request.getSession().setAttribute("changePasswordMessage", "Current Password you entered is incorrect");
			
		}
		else
		{
			String newPassword=request.getParameter("new_password");
			// Change the password of the user
			boolean updated=UserInfo.changePassword(userName,newPassword);
			
			if(updated)
			{
				request.getSession().setAttribute("changePasswordMessage", "Your Password has been updated");
				
			}
			else
			{
				request.getSession().setAttribute("changePasswordMessage", "Your Password was not updated");
			}
				
			
			
			
		}
		response.sendRedirect("changeUserPassword.jsp");
	}

}
