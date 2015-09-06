package com.neighbourhood.user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.neighbourhood.email.EmailService;

/**
 * Servlet implementation class SendLoginDetails
 */
@WebServlet("/SendLoginDetails")
public class SendLoginDetails extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SendLoginDetails() {
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

		String username = request.getParameter("username");
		String email = request.getParameter("email");

		if ((email == null || email.trim().isEmpty() || email.isEmpty())
				&& (username == null || username.trim().isEmpty()
				|| username.isEmpty())) {

			request.getSession()
					.setAttribute("errorMessage_loginDetails",
							"Please enter either username or email address to get Login details");
			response.sendRedirect("forgotPassword.jsp");
		} else {

			if (email != null) {
				String EMAIL_REGEX = "^[\\w-_\\.+]*[\\w-_\\.]\\@([\\w]+\\.)+[\\w]+[\\w]$";
				if (!email.matches(EMAIL_REGEX)) {
					request.getSession().setAttribute(
							"errorMessage_loginDetails",
							"E-Mail ID is not valid");
					response.sendRedirect("forgotPassword.jsp");
				} else {
					// Email in proper format
					User user = UserInfo.getUserInfoByEmail(email);
					if (user == null) {
						request.getSession()
								.setAttribute(
										"errorMessage_loginDetails",
										"User does not exist with email address : "+email+". Please try again or create a new account");
						response.sendRedirect("index.jsp");

					} else {
						boolean emailSent = EmailService.sendLoginDetails(user);
						if (emailSent) {
							request.getSession()
									.setAttribute("errorMessage_loginDetails",
											"Email has been sent to your email address");
							response.sendRedirect("index.jsp");
						} else {


							request.getSession().setAttribute(
									"errorMessage_loginDetails",
									"Email could not be sent to your email address. Please contact us through feedback so that we can send our account details");
							response.sendRedirect("index.jsp");
						}
					}
				}

			} else if (username != null) {

				// Username in proper format
				User user = UserInfo.getUserInfoByUsername(username);
				if (user == null) {
					request.getSession()
							.setAttribute(
									"errorMessage_loginDetails",
									"User does not exist with this username : "+username+". Please try again or create a new account");
					response.sendRedirect("index.jsp");

				} else {
					boolean emailSent = EmailService.sendLoginDetails(user);
					if (emailSent) {
						request.getSession().setAttribute(
								"errorMessage_loginDetails",
								"Email has been sent to your email address");
						response.sendRedirect("index.jsp");
					} else {
						
						request.getSession().setAttribute(
								"errorMessage_loginDetails",
								"Email could not be sent to your email address. Please contact us through feedback so that we can send our account details");
						response.sendRedirect("index.jsp");

					}
				}
			}

		}

	}

}
