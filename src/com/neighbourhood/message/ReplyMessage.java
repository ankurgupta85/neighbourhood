package com.neighbourhood.message;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.neighbourhood.neighbours.Neighbours;
import com.neighbourhood.neighbours.SendMessages;
import com.neighbourhood.user.RetrieveMessage;
import com.sun.xml.internal.ws.resources.SenderMessages;

/**
 * Servlet implementation class ReplyMessage
 */
public class ReplyMessage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReplyMessage() {
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
		
		int messageid=Integer.parseInt(request.getParameter("messageid"));
		String messageReply=request.getParameter("messageField");
		String sender=request.getParameter("sender");
		MessageInfo message=RetrieveMessage.getMessage(messageid);
		String messageTopic=message.getMessageTopic();
		String receiver=null;
		if(message.getSender().equals(sender))
		{
			receiver=message.getReceiver();
			
		}
		else
		{
			receiver=message.getSender();
		}
		
		
		
		boolean replySent=SendMessages.sendReply(sender,receiver, messageReply, messageTopic,messageid);
		if(replySent)
		{
			request.getSession().setAttribute("messageSent","Message has been sent to "+Neighbours.getFullName(receiver));
			
		}
		else
		{
			request.getSession().setAttribute("messageSent","Error in sending message to "+Neighbours.getFullName(receiver)+" Please contact admin");
			
		}
		response.sendRedirect("showmessage.jsp?messageid="+messageid);
		
	}

}
