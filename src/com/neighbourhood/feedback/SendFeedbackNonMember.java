package com.neighbourhood.feedback;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.neighbourhood.email.EmailService;

/**
 * Servlet implementation class SendFeedbackNonMember
 */
@WebServlet("/SendFeedbackNonMember")
public class SendFeedbackNonMember extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SendFeedbackNonMember() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		String nonmemberfname = request.getParameter("fname");
		String nonmemberlname = request.getParameter("lname");
		String nonmemberemail = request.getParameter("email");
		String nonmemberfeedback = request.getParameter("feedback");
		if (nonmemberemail == null || nonmemberemail.isEmpty()
				|| nonmemberemail.trim().isEmpty() || nonmemberfeedback == null
				|| nonmemberfeedback.isEmpty()
				|| nonmemberfeedback.trim().isEmpty() || nonmemberfname == null
				|| nonmemberfname.isEmpty() || nonmemberfname.trim().isEmpty()
				|| nonmemberlname == null || nonmemberlname.isEmpty()
				|| nonmemberlname.trim().isEmpty()) {

			request.getSession().setAttribute("feedbacknonmembermessage",
					"All the fields are required for feedback");
			response.sendRedirect("feedback.jsp");

		} else {
			boolean feedbackSent = EmailService.sendNonMemberFeedback(
					nonmemberfname, nonmemberlname, nonmemberemail,
					nonmemberfeedback);
			if (feedbackSent) {
				request.getSession().setAttribute("feedbacknonmembermessage",
						"Your valuable feedback has been sent. Thank You!!");
				response.sendRedirect("index.jsp");
			} else {
				request.getSession()
						.setAttribute("feedbacknonmembermessage",
								"Your feedback was not sent. Please try sending it again");
				response.sendRedirect("feedback.jsp");

			}
		}

	}
}
