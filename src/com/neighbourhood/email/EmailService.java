package com.neighbourhood.email;

import java.io.IOException;
import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.log4j.Logger;

import com.neighbourhood.event.EventInfo;

import com.neighbourhood.neighbours.Neighbours;
import com.neighbourhood.user.User;
import com.neighbourhood.user.UserInfo;

public class EmailService {

	private static boolean mailSent = false;
	
	private static String MAIL_HOST="smtp.gmail.com";
	private static String MAIL_SMTP_PORT="587";
	private static String MAIL_SMTP_AUTH="true";
	private static String MAIL_TLS_ENABLE="true";
	
	

	
	
	// Send Email with the details of user profile in the
	// format(fname,email,username,password).
	public static void sendMail(String user_info) throws IOException {
		
		String[] completeUserInfo = user_info.split(":");
		String userFname = completeUserInfo[0];
		String userEmail = completeUserInfo[1];
		String username = completeUserInfo[2];
		String userPassword = completeUserInfo[3];
		String completeMessage = "Dear " + userFname + ",\n\n";
		completeMessage += "Welcome to Neighbourhood,\n\n\t\t";
		completeMessage += " Neighbourhood team invites you to connect with your neighbours."
				+ "Please find below your login details";
		completeMessage += "\n\n Username:   " + username + "\n Password:   "
				+ userPassword;
		completeMessage += "\n\n Thank You \n Neighbourhood Team";
		String login = "neighbourhoodteam@gmail.com";
		String password = "jaisriram234";
		String subject = "Welcome to Neighbourhood";
		try {
			
			Properties props = getSMTPProperties();
			Authenticator auth = new SMTPAuthenticator(login, password);

			Session session = Session.getInstance(props, auth);

			MimeMessage msg = new MimeMessage(session);
			msg.setText(completeMessage);
			msg.setSubject(subject);
			msg.setFrom(new InternetAddress("Neighbourhood"));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(
					userEmail));
			Transport.send(msg);

		} catch (Exception ex) {
			ex.printStackTrace();
		
		}

	}

	public static void sendPasswordChangeMail(String username,
			String newPassword) throws IOException {

		String completeMessage = "Dear " + Neighbours.getFullName(username)
				+ ",\n\n\t\t";
		completeMessage += " Neighbourhood team wants to inform you that you have changed your password."
				+ "Please find below your login details with new Password";
		completeMessage += "\n\n Username:   " + username + "\n Password:   "
				+ newPassword;
		completeMessage += "\n\n Thank You \n Neighbourhood Team";
		String login = "neighbourhoodteam@gmail.com";
		String password = "jaisriram234";
		String subject = "Welcome to Neighbourhood";
		try {
			
			Properties props = getSMTPProperties();
			Authenticator auth = new SMTPAuthenticator(login, password);

			Session session = Session.getInstance(props, auth);

			MimeMessage msg = new MimeMessage(session);
			msg.setText(completeMessage);
			msg.setSubject(subject);
			msg.setFrom(new InternetAddress("Neighbourhood"));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(
					Neighbours.getEmail(username)));
			Transport.send(msg);

		} catch (Exception ex) {
			ex.printStackTrace();
			
		}

	}

	
	public static void sendEventInviteEmail(EventInfo event,String message,String userName)
	{
		
		
		
		User user= UserInfo.getUserInfoByUsername(userName);
		
			message = "Dear "+ user.getFname()+"\n\n" + message +"\n\n  Thank You \n Neighbourhood Team";
			String login = "neighbourhoodteam@gmail.com";
			String password = "jaisriram234";
			String subject = "Invitation for event - Message from " + Neighbours.getFullName(event.getCreator())
					+ "(Your Neighbour)";
			try {
				
				Properties props = getSMTPProperties();
				Authenticator auth = new SMTPAuthenticator(login, password);

				Session session = Session.getInstance(props, auth);

				MimeMessage msg = new MimeMessage(session);
				msg.setText(message);
				msg.setSubject(subject);
				msg.setFrom(new InternetAddress("Neighbourhood"));
				msg.addRecipient(Message.RecipientType.TO, new InternetAddress(
						user.getEmail()));
				Transport.send(msg);
				mailSent = true;
			} catch (Exception ex) {
				ex.printStackTrace();
				
			}

			
			
			
			
		}
		
		
	

	
	public static void sendEventCancellationEmail(EventInfo event,String message,List<String> userList)
	{
		for(String username : userList)
		{
			User user=UserInfo.getUserInfoByUsername(username);
			message = "Dear "+ user.getFname()+"\n\n" + message +"\n\n  Thank You \n Neighbourhood Team";
			String login = "neighbourhoodteam@gmail.com";
			String password = "jaisriram234";
			String subject = "Event Cancelled - Message from " + Neighbours.getFullName(event.getCreator())
					+ "(Your Neighbour)";
			try {
				
				
				Properties props = getSMTPProperties();
				Authenticator auth = new SMTPAuthenticator(login, password);

				Session session = Session.getInstance(props, auth);

				MimeMessage msg = new MimeMessage(session);
				msg.setText(message);
				msg.setSubject(subject);
				msg.setFrom(new InternetAddress("Neighbourhood"));
				msg.addRecipient(Message.RecipientType.TO, new InternetAddress(
						user.getEmail()));
				Transport.send(msg);
				mailSent = true;
			} catch (Exception ex) {
				ex.printStackTrace();
				
				
				
			}

			
			
			
			
		}
		
		
	}

	
	
	
	public static boolean inviteNeighbour(String username, String email) {

		String fullName = Neighbours.getFullName(username);
		String completeMessage = "Dear Neighbour, \n\n";
		completeMessage += "Welcome to Neighbourhood,\n\n\t\t";
		String fullname = Neighbours.getFullName(username);
		completeMessage += fullname
				+ " asked Neighbourhood team to send you invitation to connect to him using Neighbouhood network. Using Neighbourhood.com you can find your neighbours whom you might not even know and can expand your network without going directly to their place to introduce yourself to them."
				+ "Please click on the link below to sign up and connect to your Neighbours\n\n\t\t";
		completeMessage += "www.neighbourhood.com";
		completeMessage += "\n\n Thank You \n Neighbourhood Team";
		String login = "neighbourhoodteam@gmail.com";
		String password = "jaisriram234";
		String subject = "Welcome to Neighbourhood - Message from " + fullname
				+ "(Your Neighbour)";
		try {
			
			
			Properties props = getSMTPProperties();
			Authenticator auth = new SMTPAuthenticator(login, password);

			Session session = Session.getInstance(props, auth);

			MimeMessage msg = new MimeMessage(session);
			msg.setText(completeMessage);
			msg.setSubject(subject);
			msg.setFrom(new InternetAddress("Neighbourhood"));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(
					email));
			Transport.send(msg);
			mailSent = true;
		} catch (Exception ex) {
			ex.printStackTrace();
			
		}

		return mailSent;

	}

	public static boolean sendMail(String sender, String receiver,
			String message) {
		boolean mailSent = false;

		String senderFullName = Neighbours.getFullName(sender);
		String receiverFullName = Neighbours.getFullName(receiver);
		String receiverEmail = Neighbours.getEmail(receiver);

		String completeMessage = "Dear " + receiverFullName + ", \n\n";

		completeMessage += senderFullName
				+ " sent you a message: \n\n\t"
				+ message
				+ "\n\n\t\t You can login to www.neighbourhood.com to view/reply to message.";

		completeMessage += "\n\n Thank You \n Neighbourhood Team";
		String login = "neighbourhoodteam@gmail.com";
		String password = "jaisriram234";
		String subject = "Personal Message from " + senderFullName
				+ "(Your Neighbour)";
		try {
			Properties props = getSMTPProperties();
			
			Authenticator auth = new SMTPAuthenticator(login, password);

			Session session = Session.getInstance(props, auth);

			MimeMessage msg = new MimeMessage(session);
			msg.setText(completeMessage);
			msg.setSubject(subject);
			msg.setFrom(new InternetAddress("Neighbourhood"));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(
					receiverEmail));

			Transport.send(msg);
			mailSent = true;
		} catch (Exception ex) {
			ex.printStackTrace();
			
		}

		return mailSent;

	}

	public static boolean sendReminder(String username, String email) {

		String fullName = Neighbours.getFullName(username);
		String completeMessage = "Dear Neighbour, \n\n";
		completeMessage += "Welcome to Neighbourhood,\n\n\t\t";
		String fullname = Neighbours.getFullName(username);
		completeMessage += " This is reminder from "
				+ fullName
				+ " requesting you to join his Neighbourhood. Using Neighbourhood you can find your neighbours whom you might not even know and can expand your network without going directly to their place to introduce yourself to them."
				+ "Please click on the link below to sign up and connect to your Neighbours\n\n\t\t";
		completeMessage += "www.neighbourhood.com";
		completeMessage += "\n\n Thank You \n Neighbourhood Team";
		String login = "neighbourhoodteam@gmail.com";
		String password = "jaisriram234";
		String subject = "Welcome to Neighbourhood - Message from " + fullname
				+ "(Your Neighbour)";
		try {
			Properties props = getSMTPProperties();
			Authenticator auth = new SMTPAuthenticator(login, password);
			
			Session session = Session.getInstance(props, auth);

			MimeMessage msg = new MimeMessage(session);
			msg.setText(completeMessage);
			msg.setSubject(subject);
			msg.setFrom(new InternetAddress("Neighbourhood"));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(
					email));
			Transport.send(msg);
			mailSent = true;
		} catch (Exception ex) {
			ex.printStackTrace();
			
		}

		return mailSent;

	}
	

	
	public static boolean sendMemberFeedback(User user, String feedback) {

		
		String fullName = Neighbours.getFullName(user.getUsername());
		String completeMessage = "Dear Neighbourhood Team, \n\n";
		completeMessage += "Feedback from "+fullName+"("+user.getUsername()+"),\n\n\t\t";
		
		completeMessage += " This is feedback from "
				+ fullName
				+ "\n\n\t\t";
		completeMessage += feedback;
		completeMessage += "\n\n Thank You \n"+fullName;
		String login = "neighbourhoodteam@gmail.com";
		String password = "jaisriram234";
		String subject = "Feedback from Neighbourhood User - " + fullName
				+ "("+user.getUsername()+")";
		try {
			Properties props = getSMTPProperties();
			Authenticator auth = new SMTPAuthenticator(login, password);
			
			Session session = Session.getInstance(props, auth);

			MimeMessage msg = new MimeMessage(session);
			msg.setText(completeMessage);
			msg.setSubject(subject);
			msg.setFrom(new InternetAddress(user.getUsername()));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(
					"neighbourhoodteam@gmail.com"));
			Transport.send(msg);
			mailSent = true;
		} catch (Exception ex) {
			ex.printStackTrace();
			
		}

		return mailSent;

	}
	


	public static boolean sendNonMemberFeedback(String nonmemberfname, String nonmemberlname, String nonmemberemail,
			String nonmemberfeedback) {

		
		String fullName = nonmemberfname+" "+nonmemberlname;
		String completeMessage = "Dear Neighbourhood Team, \n\n";
		completeMessage += "Feedback from "+fullName+"("+nonmemberemail+"),\n\n\t\t";
		
		completeMessage += " This is feedback from "
				+ fullName
				+ "\n\n\t\t";
		completeMessage += nonmemberfeedback;
		completeMessage += "\n\n Thank You \n"+fullName;
		String login = "neighbourhoodteam@gmail.com";
		String password = "jaisriram234";
		String subject = "Feedback from Neighbourhood User - " + fullName
				+ "("+nonmemberemail+")";
		try {
			Properties props = getSMTPProperties();
			Authenticator auth = new SMTPAuthenticator(login, password);
			
			Session session = Session.getInstance(props, auth);

			MimeMessage msg = new MimeMessage(session);
			msg.setText(completeMessage);
			msg.setSubject(subject);
			msg.setFrom(new InternetAddress("Neighbourhood"));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(
					"neighbourhoodteam@gmail.com"));
			Transport.send(msg);
			mailSent = true;
		} catch (Exception ex) {
			ex.printStackTrace();
			
		}

		return mailSent;

	}

	
	
	
	
	
	
	public static boolean sendLoginDetails(User user) {

		String username=user.getUsername();
		String email = user.getEmail();
		String fullName = Neighbours.getFullName(username);
		String completeMessage = "Dear "+fullName+", \n\n";
		completeMessage += "Your Login Details,\n\n\t\t";
		completeMessage +=
				"Please fin below your login details as you requested\n\n\t\t Username : "+username+"\n\t\t Password : "+user.getPassword()+"\n\n";
		completeMessage += " Please use these details to login to www.neighbourhood.com";
		completeMessage += "\n\n Thank You \n Neighbourhood Team";
		String login = "neighbourhoodteam@gmail.com";
		String password = "jaisriram234";
		String subject = "Welcome to Neighbourhood - Your login account details";
		try {
			Properties props = getSMTPProperties();
			Authenticator auth = new SMTPAuthenticator(login, password);
			
			Session session = Session.getInstance(props, auth);

			MimeMessage msg = new MimeMessage(session);
			msg.setText(completeMessage);
			msg.setSubject(subject);
			msg.setFrom(new InternetAddress("Neighbourhood"));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(
					email));
			Transport.send(msg);
			mailSent = true;
		} catch (Exception ex) {
			ex.printStackTrace();
			
		}

		return mailSent;

	}



	/*
	 * public static void sendMail(String user_info, String totaxi) { String[]
	 * userinfo = user_info.split(";"); String id = userinfo[0]; String fname =
	 * userinfo[1]; String lname = userinfo[2]; String contact = userinfo[3];
	 * String email = userinfo[4]; String from = userinfo[5]; String to =
	 * userinfo[6]; String airline = userinfo[7]; String flight = userinfo[8];
	 * String date = userinfo[9]; String time = userinfo[10]; String message =
	 * userinfo[11]; String subject = null; String completeMessage =
	 * "Dear Alan, \n";
	 * 
	 * if (message.contains("New")) {
	 * 
	 * subject = "New Reservation confirmed"; completeMessage +=
	 * "\t\tThere is a new registration.";
	 * 
	 * } if (message.contains("Updated")) { subject = "Reservation updated";
	 * completeMessage += "\t\tThere is an update in one of the reservations.";
	 * 
	 * } if (message.contains("Deleted")) { subject = "Reservation deleted";
	 * completeMessage += "\t\tThere is one cancellation.";
	 * 
	 * }
	 * 
	 * completeMessage += "\n\n ID:   " + id + "\n First Name:   " + fname +
	 * "\n Last Name:   " + lname + "\n Contact Name:   " + contact +
	 * "\n E Mail:   " + email + "\n From:   " + from + "\n To:   " + to +
	 * "\n Airline:   " + airline + "\n Flight:   " + flight + "\n Date:   " +
	 * date + "\n Time:   " + time + "\n Message:   " + message;
	 * 
	 * completeMessage += "\n\n Thank You \n Ankur";
	 * 
	 * String login = "alantaxi123@gmail.com"; String password = "AlanTaxi@123";
	 * try { Properties props = new Properties(); props.setProperty("mail.host",
	 * "smtp.gmail.com"); props.setProperty("mail.smtp.port", "587");
	 * props.setProperty("mail.smtp.auth", "true");
	 * props.setProperty("mail.smtp.starttls.enable", "true");
	 * 
	 * Authenticator auth = new SMTPAuthenticator(login, password);
	 * 
	 * Session session = Session.getInstance(props, auth);
	 * 
	 * MimeMessage msg = new MimeMessage(session); msg.setText(completeMessage);
	 * msg.setSubject(subject); msg.setFrom(new InternetAddress("Alan"));
	 * msg.addRecipient(Message.RecipientType.TO, new InternetAddress( totaxi));
	 * Transport.send(msg);
	 * 
	 * } catch (Exception ex) { ex.printStackTrace(); } }
	 */
	private static class SMTPAuthenticator extends Authenticator {

		private PasswordAuthentication authentication;

		public SMTPAuthenticator(String login, String password) {
			authentication = new PasswordAuthentication(login, password);
		}

		protected PasswordAuthentication getPasswordAuthentication() {
			return authentication;
		}
	}
	
	private static Properties getSMTPProperties()
	{
		Properties props = new Properties();
		props.setProperty("mail.host", MAIL_HOST);
		props.setProperty("mail.smtp.port", MAIL_SMTP_PORT);
		props.setProperty("mail.smtp.auth", MAIL_SMTP_AUTH);
		props.setProperty("mail.smtp.starttls.enable", MAIL_TLS_ENABLE);
		return props;
	}

}
