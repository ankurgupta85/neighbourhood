package com.neighbourhood.feedback;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.neighbourhood.email.EmailService;
import com.neighbourhood.user.User;
import com.neighbourhood.user.UserInfo;

/**
 * Servlet implementation class SendFeedbackMember
 */
@WebServlet("/SendFeedbackMember")
public class SendFeedbackMember extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SendFeedbackMember() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String username = request.getParameter("username");
		String feedback = request.getParameter("feedback");
		if(feedback == null || feedback.isEmpty() || feedback.trim().isEmpty())
		{
			request.getSession().setAttribute("messageFeedbackMember", "Please enter feedback before sending it");
			response.sendRedirect("userFeedback.jsp");
			
		}
		else
		{
			
			User user=UserInfo.getUserInfoByUsername(username);
			boolean feedbackSent = EmailService.sendMemberFeedback(user,feedback);
			if(feedbackSent)
			{
				request.getSession().setAttribute("messageFeedbackMember", "Your feedback has been sent");
				response.sendRedirect("user.jsp");
			
			}
			else
			{
				request.getSession().setAttribute("messageFeedbackMember", "Your feedback could not be sent. Please try again");
				request.getSession().setAttribute("userFeedback",feedback);
				response.sendRedirect("userFeedback.jsp");
			
			}
			
			
		
			
		}
		
			
		
		
		
		
	}

}
