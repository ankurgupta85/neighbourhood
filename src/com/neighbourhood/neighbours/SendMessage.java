package com.neighbourhood.neighbours;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SendMessage
 */
public class SendMessage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SendMessage() {
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
		
	/*	System.out.println("In SendMEssage");*/
		String sender=request.getParameter("sender");
		String receiver=request.getParameter("receiver");
		String message=request.getParameter("messageField");
		String messageTopic=request.getParameter("messageTopic");
		
		boolean messageSent=SendMessages.sendMessage(sender,receiver,message,messageTopic);
		if(messageSent)
		{
			request.getSession().setAttribute("message","Message has been sent to "+Neighbours.getFullName(receiver));
			
		}
		else
		{
			request.getSession().setAttribute("message","Error in sending message to "+Neighbours.getFullName(receiver)+" Please contact admin");
			
		}
		response.sendRedirect("otheruser.jsp?username="+receiver);
		
	}

}
