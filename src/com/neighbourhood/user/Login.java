package com.neighbourhood.user;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;




import com.neighbours.datastore.ConnectionDataStore;

/**
 * Servlet implementation class Login
 */
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	String username = "";
	String password = "";
	Connection conn = null;
	List<String> errorMessage;
	
	
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Login() {
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
		
		/*loginLogger.info("Inside Login Servlet");*/
		HttpSession session = request.getSession(true);
		username = request.getParameter("login_username");
		password = request.getParameter("login_password");
		errorMessage = new ArrayList<String>();
		if (username != null && !username.toString().isEmpty()) {
			session.setAttribute("username", username.toString());
		} else {
			errorMessage.add("UserName is required");
		}

		if (password != null && !password.toString().isEmpty()) {
			session.setAttribute("password", password.toString());
		} else {
			errorMessage.add("Password is required");
		}

		session.setAttribute("errorMessage", errorMessage);

		// If any error encountered, return to index.jsp page
		if (errorMessage.size() != 0) {
			/*loginLogger.error("Error Message List: "+errorMessage);*/
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
			rd.forward(request, response);
		}

		// Now get connection object if errorMessage Size = 0
		// 1) check if user already exists or not
		// 2) try to retrieve whole data of user from db if user exist.
		// 3) if user exist redirect him to user.jsp
		// 4) if user does not exist, redirect him to index.jsp with proper
		// error message

		try {

			User user = UserInfo.getUserInfoByUsername(username);
			if (user == null || !(user.getPassword().equals(password))) {
				errorMessage.add("Invalid login credentials");
				session.setAttribute("errorMessage", errorMessage);
				response.sendRedirect("index.jsp");
			} else {
				if (user.getPassword().equals(password)) {
					/*loginLogger.info("Valid user with username "+username);*/
					session.setAttribute("fname", user.getFname());
					session.setAttribute("lname", user.getLname());
					session.setAttribute("username", user.getUsername());
					session.setAttribute("email", user.getEmail());
			//		session.setAttribute("country", user.getCountry());
					session.setAttribute("zipcode", user.getZipcode());
					session.setAttribute(
							"message",
							"Welcome back " + user.getFname() + " "
									+ user.getLname());
					/* response.sendRedirect("user.jsp"); */
					response.sendRedirect("user.jsp");

				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			ConnectionDataStore.closeConn(conn);
			/*loginLogger.info("Exiting Login Servlet");*/
		}

	}

}
