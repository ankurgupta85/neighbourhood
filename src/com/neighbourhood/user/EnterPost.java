package com.neighbourhood.user;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.StringTokenizer;

import com.neighbours.datastore.ConnectionDataStore;

public class EnterPost {

	private static boolean entered = false;
	private static Connection conn = null;
	private static final String DATE_FORMAT_NOW = "MM-dd-yyyy HH:mm:ss";
	private static long last_post_id = 0;

	public static boolean enterNewPost(String username, String post) {
		/*System.out.println("In enterNewPost");
		System.out.println((new Date()).toString());
		*/try {
			// To get current date and time in the format specified
				Calendar cal = Calendar.getInstance();
				SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT_NOW);
				String datetime = sdf.format(cal.getTime());

			conn = ConnectionDataStore.getConn();
			String sql = "select max(post_id) as post_id from parent_updates";
			ResultSet rs = conn.createStatement().executeQuery(sql);
			if (rs.next()) {
				last_post_id = rs.getInt("post_id");
			}
			last_post_id++;
			
			post=parsePost(post);
			
			
			
			sql = "insert into parent_updates values('" + last_post_id + "','"
					+ username + "','" + post + "','" + datetime + "')";
		/*	System.out.println(sql);
		*/	int count = conn.createStatement().executeUpdate(sql);

			if (count == 1) {
				entered = true;
			}
		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			ConnectionDataStore.closeConn(conn);
		}

		return entered;
	}

	public static boolean enterPostReply(String parent_post_id, String username,
			String updateReply) {
		boolean replied = false;
		int next_post_id=0;
		int parent_id=Integer.parseInt(parent_post_id);
		/*System.out.println("In enterNewPost");
		System.out.println((new Date()).toString());
		*/try {
			// To get current date and time in the format specified
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT_NOW);
			String datetime = sdf.format(cal.getTime());

			conn = ConnectionDataStore.getConn();
			String sql = "select max(post_id) as max_post_id from updates";
			ResultSet rs = conn.createStatement().executeQuery(sql);
			if (rs.next()) {
				next_post_id = rs.getInt("max_post_id");
			}
			next_post_id++;
			updateReply=parsePost(updateReply);
			
			sql = "insert into updates values('" + next_post_id + "','"
					+ username + "','" + updateReply + "','" + datetime + "','"+parent_id+"')";
		/*	System.out.println(sql);
		*/	int count = conn.createStatement().executeUpdate(sql);

			if(count ==1)
			{
				replied=true;
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDataStore.closeConn(conn);
		}

		return replied;
	}
	
	
	
	private static String parsePost(String post) throws IOException {

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
