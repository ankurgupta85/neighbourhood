package com.neighbourhood.status;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.neighbourhood.user.EnterPost;

/**
 * Servlet implementation class UpdateStatusReply
 */
public class UpdateStatusReply extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static boolean replied = false;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateStatusReply() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		/*System.out.println("In UpdateStatusReply");*/
		String username = request.getParameter("username");
		String post_id = request.getParameter("post_id");
		String updateReply = request.getParameter("updateReply");
		/*System.out.println(username + "   " + post_id + "  " + updateReply);*/

		if(updateReply.isEmpty() || updateReply.trim().length()==0)
		{
			request.getSession().setAttribute("message",
					"Post cannot be empty");

		}
		else if (updateReply.length() >= 150) {
			request.getSession().setAttribute("message",
					"Post cannot have more than 150 characters");

		} else {
			replied = EnterPost.enterPostReply(post_id, username, updateReply);

		}

		response.sendRedirect("otheruser.jsp?username=" + username);

	}

}
