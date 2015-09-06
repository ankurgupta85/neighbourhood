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
 * Servlet implementation class EditNeighbourEvent
 */
public class EditNeighbourEvent extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditNeighbourEvent() {
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
		
		String username=request.getParameter("username");
		int event_id=Integer.parseInt(request.getParameter("event_id"));
		String eventTopic=request.getParameter("eventTopic");
		String eventDescription=request.getParameter("eventDescription");
		String date_time=request.getParameter("date_time");
		String[] invites= request.getParameterValues("invite");
		List<String> invite=new ArrayList<String>();
		for(String user:invites)
		{
			invite.add(user);
		}
		invite.add(username);
		
		/*System.out.println(invite);
		System.out.println(eventDescription);
		System.out.println(eventTopic);
		System.out.println(date_time);
		System.out.println(username);*/


		boolean eventUpdated = EventCreation.updateEvent(event_id,username, eventTopic,eventDescription, date_time);
		if (eventUpdated) {
			// Enter event id and user into event_user table
			boolean neighboursInvited = InviteNeighbours.updateInviteNeighbours(event_id,
					invite);
			if (neighboursInvited) {
				request.getSession()
						.setAttribute("message",
								"Event Updated and invites sent to all Selected neighbours");
			}
			else
			{
				request.getSession()
				.setAttribute("message",
						"Event Updated but invites could not be sent to all Selected neighbours");
			}

		} else {

			request.getSession().setAttribute("message",
					"Event Could not be updated. Please contact admin");

		}


		request.getSession().removeAttribute("eventTopic");
		request.getSession().removeAttribute("eventDescription");
		request.getSession().removeAttribute("date_time_event");
		response.sendRedirect("user.jsp");

		
	
	}

}
