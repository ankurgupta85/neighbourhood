package com.neighbourhood.event;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class NeighbourEvent
 */
public class NeighbourEvent extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public NeighbourEvent() {
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
		/*System.out.println("In NeighbourEvent");*/
	
		String eventTopic = request.getSession().getAttribute("eventTopic")
				.toString();
		String eventDescription = request.getSession()
				.getAttribute("eventDescription").toString();
		String date_time_event = request.getSession()
				.getAttribute("date_time_event").toString();
		String[] invites = request.getParameterValues("invite");
		
		String username = request.getSession().getAttribute("username")
				.toString();
		List<String> invite=new ArrayList<String>();
		for(String user:invites)
		{
			invite.add(user);
		}
		invite.add(username);
		
	/*	System.out.println(invite);
		System.out.println(eventDescription);
		System.out.println(eventTopic);
		System.out.println(date_time_event);
		System.out.println(username);
*/
		boolean neighboursInvited = false;
		// Enter event into table
		int event_id = EventCreation.createEvent(username, eventTopic,
				eventDescription, date_time_event);
		if (event_id > 0) {
			// Enter event id and user into event_user table
			neighboursInvited = InviteNeighbours.inviteNeighbours(event_id,
					invite);
			if (neighboursInvited) {
				request.getSession()
						.setAttribute("message",
								"Event Created and invites sent to all Selected neighbours");
			}

		} else {

			request.getSession().setAttribute("message",
					"Event Could not be created. Please contact admin");

		}

		request.getSession().removeAttribute("eventTopic");
		request.getSession().removeAttribute("eventDescription");
		request.getSession().removeAttribute("date_time_event");
		request.getSession().removeAttribute("flag");
		response.sendRedirect("user.jsp");

		// Send email to all the users

	}

}
