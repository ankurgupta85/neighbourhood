package com.neighbourhood.neighbours;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.neighbourhood.email.EmailService;

/**
 * Servlet implementation class InviteNeighbour
 */
public class InviteNeighbour extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public InviteNeighbour() {
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

		boolean mailSent = false;
		String email = request.getParameter("inviteEmail").toString();
		String username = request.getParameter("username").toString();
		if (email == null || email.isEmpty() || email.trim().isEmpty()) {
			request.getSession().setAttribute("message",
					"Please enter email id of neighbour you wish to invite");

			/* response.sendRedirect("user.jsp"); */
		} else {
			boolean userExist = Neighbours.checkUserByEmail(email);
			if (userExist) {
				// delete user email id from invitesent table
				Neighbours.deleteFromInviteList(email);
				
				request.getSession()
						.setAttribute(
								"message",
								"User Already Exist. Please use search to find your neighbour with email id as "+email);
			} else {
				boolean alreadyInvited = Neighbours.checkInviteSent(email);
				if (alreadyInvited) {
					request.getSession().setAttribute("message",
							"Invite have been already sent to " + email+". <a href=sendReminder.jsp?"+email+" target='_top'>Send Reminder</a>");
				
				} else {
					mailSent = EmailService.inviteNeighbour(username, email);
					if (mailSent) {
						boolean inviteAdded=Neighbours.addToInviteList(email);
						if(inviteAdded && mailSent)
						request.getSession().setAttribute("message",
								"Invitation mail sent to " + email);
					}
					else
					{
						request.getSession().setAttribute("message",
								"Some problem encountered while sending invite to " + email);
					
					}
				}
			}

		}
		response.sendRedirect("user.jsp");

	}

}
