package com.neighbourhood.user;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.neighbourhood.email.EmailService;
import com.neighbourhood.neighbours.Neighbours;
import com.neighbours.datastore.ConnectionDataStore;
import com.neighbours.imageUpload.CreateImageFolder;
import com.neighbours.imageUpload.UpLoadImage;

/**
 * Servlet implementation class NewUser
 */
public class NewUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String fname = "";
	String lname = "";
	String username = "";
	String email = "";
	String password = "";
//	String country = "";
	String zipcode = "";
	Connection conn = null;
	List<String> errorMessage_signup;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public NewUser() {
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
		HttpSession session = request.getSession(true);
		fname = request.getParameter("fname");
		lname = request.getParameter("lname");
		username = request.getParameter("username");
		email = request.getParameter("email");
		password = request.getParameter("password");
	//	country = request.getParameter("country");
		zipcode = request.getParameter("zipcode");
		errorMessage_signup = new ArrayList<String>();

		// Check for validation if javascript is disabled in browser.
		// Only checks if value is null or empty.
		// Creates an errorMessage List to display on front end.

		if (fname != null && !fname.toString().isEmpty()) {
			session.setAttribute("fname", fname.toString());
		} else {
			errorMessage_signup.add("First Name is required");
		}

		if (lname != null && !lname.toString().isEmpty()) {
			session.setAttribute("lname", lname.toString());
		} else {
			errorMessage_signup.add("Last Name is required");
		}

		if (username != null && !username.toString().isEmpty()) {
			session.setAttribute("username", username.toString());
		} else {
			errorMessage_signup.add("UserName is required");
		}

		if (email != null && !email.toString().isEmpty()) {
			// Email ID validation
			String EMAIL_REGEX = "^[\\w-_\\.+]*[\\w-_\\.]\\@([\\w]+\\.)+[\\w]+[\\w]$";
			if (!email.matches(EMAIL_REGEX)) {
				errorMessage_signup.add("E-Mail ID is not valid");
			}
			session.setAttribute("email", email.toString());
		} else {
			errorMessage_signup.add("E mail is required");
		}

		if (password != null && !password.toString().isEmpty()) {
			session.setAttribute("password", password.toString());
		} else {
			errorMessage_signup.add("Password is required");
		}

		
		/*if (country != null && !country.toString().isEmpty()) {
			session.setAttribute("country", country.toString());
		} else {
			errorMessage_signup.add("Country is required");
		}
*/
		if (zipcode != null && !zipcode.toString().isEmpty()) {
			// Zipcode Validation ---> US based
			final String regex = "^\\d{5}(-\\d{4})?$";
			if (!Pattern.matches(regex, zipcode) || Integer.parseInt(zipcode)<=0) {
				errorMessage_signup.add("Zipcode is not valid");
			}
			session.setAttribute("zipcode", zipcode.toString());
		} else {
			errorMessage_signup.add("Zipcode is required");
		}

		session.setAttribute("errorMessage", errorMessage_signup);

		// If any error encountered, return to newuser.jsp page
		if (errorMessage_signup.size() != 0) {
			response.sendRedirect("newuser.jsp");
		}

		// TO DO --> Check if valid address or not

		// Now get connection object if errorMessage Size = 0
		// 1) check if user already exists or not
		// 2) try to submit data to table in database if user does not exist.
		// 3) if user exist redirect him to newuser.jsp with error in
		// errorMessage.
		
		// if user with same username exists
		boolean userExist=false;
		User user=UserInfo.getUserInfoByUsername(username);
		if(user == null)
		{
			// check if user with same email id exists
			
			user=UserInfo.getUserInfoByEmail(email);
			if(user != null)
			{
				userExist=true;
			}
			
			
		}
		else
		{
			userExist=true;
		}
		
		// If user with same email id already exists
			if (userExist) {
				errorMessage_signup.add("User with this information already exists");
				session.setAttribute("errorMessage", errorMessage_signup);

				response.sendRedirect("index.jsp");
			}
			// If user does not exists, add the user into the database and show
			// him/her homepage
			else {
				
				try{
				//check if user email id in inviteSent list 
					// if email id in inviteSent list, delete it
					if(Neighbours.checkInviteSent(email))
					{
						Neighbours.deleteFromInviteList(email);
					}
					
					conn=ConnectionDataStore.getConn();
				String enterUserQuery = "insert into users value('" + fname
						+ "','" + lname + "','" + username + "','" + email
						+ "','" + password + "','" + zipcode + "','"+null+"')";
				Statement insertUser = conn.createStatement();
				int rowsUpdated = insertUser.executeUpdate(enterUserQuery);
				if (rowsUpdated == 1) {

					session.setAttribute("fname", fname);
					session.setAttribute("lname", lname);
					session.setAttribute("username", username);
					session.setAttribute("email", email);
					//session.setAttribute("country", country);
					session.setAttribute("zipcode", zipcode);
					
					// Create new images folder for this user.
					CreateImageFolder.createImageFolder(username);
					session.setAttribute("message", "Welcome to Neighbourhood - "+Neighbours.getFullName(username));
					response.sendRedirect("user.jsp");

					
				} else {
					errorMessage_signup
							.add("There was some error. Please contact admin");
					session.setAttribute("errorMessage", errorMessage_signup);
					response.sendRedirect("index.jsp");
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				ConnectionDataStore.closeConn(conn);
			}

			}

		
		// TO DO -> Send Email with the details of user profile in the
		// format(fname,email,username,password).
		String userInfo = fname + ":" + email + ":" + username + ":" + password;
		// EmailService.sendMail(userInfo);

	}
}
