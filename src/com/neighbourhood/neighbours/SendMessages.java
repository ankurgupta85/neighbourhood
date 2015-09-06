package com.neighbourhood.neighbours;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.StringTokenizer;

import com.neighbourhood.email.EmailService;
import com.neighbourhood.message.MessageInfo;
import com.neighbours.datastore.ConnectionDataStore;

public class SendMessages {

	private static Connection conn = null;

	private static final String DATE_FORMAT_NOW = "MM-dd-yyyy HH:mm:ss";

	public static boolean sendMessage(String sender, String receiver,
			String message, String messageTopic) {
		boolean messageSent = false;

		/* System.out.println("In SendMessages"); */
		try {
			int message_id = 0;
			conn = ConnectionDataStore.getConn();
			String query = "select max(message_id) as message_id from messages";
			/* System.out.println(query); */
			ResultSet rs = conn.createStatement().executeQuery(query);
			if (rs.next()) {
				message_id = rs.getInt("message_id");
			}

			// To get current date and time in the format specified
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT_NOW);
			String datetime = sdf.format(cal.getTime());
			message=parseMessage(message);
			query = "insert into messages values('" + (message_id + 1) + "','"
					+ message + "','" + sender + "','" + receiver + "','"
					+ MessageInfo.MESSAGE_STATUS_UNREAD + "','" + datetime
					+ "','" + messageTopic + "','" + 0 + "')";
			/* System.out.println(query); */
			int count = conn.createStatement().executeUpdate(query);
			if (count == 1) {
				messageSent = true;

				// TODO... Decide if we need to send email to receiver?
				/*
				 * boolean
				 * mailSent=EmailService.sendMail(sender,receiver,message);
				 * if(!mailSent) {
				 * System.out.println("Some problem in sending email"); }
				 */

			}

		} catch (Exception e) {

			e.printStackTrace();

		} finally {
			ConnectionDataStore.closeConn(conn);
		}

		return messageSent;
	}

	public static boolean sendReply(String sender, String receiver,
			String message, String messageTopic, int message_id) {
		boolean messageSent = false;

		/* System.out.println("In SendMessages.sendReply"); */
		try {
			int reply_id = 0;
			conn = ConnectionDataStore.getConn();
			String query = "select max(message_id) as message_id from messages";
			/* System.out.println(query); */
			ResultSet rs = conn.createStatement().executeQuery(query);
			if (rs.next()) {
				reply_id = rs.getInt("message_id");
			}

			// To get current date and time in the format specified
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT_NOW);
			String datetime = sdf.format(cal.getTime());
			message=parseMessage(message);
			query = "insert into messages values('" + (reply_id + 1) + "','"
					+ message + "','" + sender + "','" + receiver + "','"
					+ MessageInfo.MESSAGE_STATUS_UNREAD + "','" + datetime
					+ "','" + messageTopic + "','" + message_id + "')";
			/* System.out.println(query); */
			int count = conn.createStatement().executeUpdate(query);
			if (count == 1) {
				messageSent = true;

				// TODO... Decide if we need to send email to receiver?
				/*
				 * boolean
				 * mailSent=EmailService.sendMail(sender,receiver,message);
				 * if(!mailSent) {
				 * System.out.println("Some problem in sending email"); }
				 */

			}

		} catch (Exception e) {

			e.printStackTrace();

		} finally {
			ConnectionDataStore.closeConn(conn);
		}

		return messageSent;
	}

	private static String parseMessage(String post) throws IOException {

		String newPost = "";
		try {
			if (post.contains("http") || post.contains("https")
					|| post.contains("www")) {

				StringTokenizer tokens = new StringTokenizer(post);
				while (tokens.hasMoreTokens()) {
					String currentToken = tokens.nextToken();
					if (currentToken.startsWith("http")
							|| currentToken.startsWith("https")) {

						if (validateURL(currentToken))
							currentToken = "<a href=" + currentToken + " target=_blank >"+currentToken+"</a>";

					} else if (currentToken.startsWith("www")) {

						String protocol=getValidProtocol(currentToken);
								if(protocol!=null)
								{
									currentToken = "<a href="+protocol+"://"+currentToken+" target=_blank >"+currentToken+"</a>";
								}
							
					}

					newPost = newPost + " " + currentToken;

				}

			} else {
				newPost = newPost + " " + post;
			}
		} catch (Exception e) {
			newPost = post;
		}

		return newPost;

	}

	private static boolean validateURL(String url) throws IOException {
		boolean valid = false;

		URL abc = new URL(url);

		try {
			System.out.println(abc.getProtocol());
			HttpURLConnection conn = (HttpURLConnection) abc.openConnection();

			int code = conn.getResponseCode();
			System.out.println("Code " + code);
			if (code == 200)
				valid = true;
			else
				valid = false;

		} catch (Exception e) {
			valid = false;
		}

		return valid;
	}
	
	
	private static String getValidProtocol(String urlWithoutProtocol) throws IOException
	{
		String protocol=null;
		
		// Check with HTTP
		try
		{
			URL url=new URL("http://"+urlWithoutProtocol);
			HttpURLConnection conn=(HttpURLConnection) url.openConnection();
			if(conn.getResponseCode()==200)
			{
				protocol = "http";
			}
			else
			{	
				// Check with https if no exception
				url=new URL("https://"+urlWithoutProtocol);
				conn=(HttpURLConnection) url.openConnection();
				if(conn.getResponseCode()==200)
				{
					protocol = "https";
				}	
			}
			
			
		}catch (Exception e)
		{
			//Check with https

			URL url=new URL("https://"+urlWithoutProtocol);
			HttpURLConnection conn=(HttpURLConnection) url.openConnection();
			if(conn.getResponseCode()==200)
			{
				protocol = "https";
			}	
		}
		
			
		
		
		
		return protocol;
	}
}
