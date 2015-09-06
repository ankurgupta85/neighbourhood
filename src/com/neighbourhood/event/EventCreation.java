package com.neighbourhood.event;

import java.awt.Event;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.List;
import java.util.StringTokenizer;

import com.neighbourhood.email.EmailService;
import com.neighbourhood.neighbours.Neighbours;
import com.neighbours.datastore.ConnectionDataStore;

public class EventCreation {

	
	private static int event_id=0;
	private static Connection conn=null;
	public static int createEvent(String username, String eventTopic,
			String eventDescription, String date_time_event) {

/*		System.out.println("In EventCreation");*/
		try
		{
			
			conn=ConnectionDataStore.getConn();
			String query="select max(event_id) as event_id from event";
			ResultSet rs=conn.createStatement().executeQuery(query);
			String date=date_time_event.split(" ")[0];
			String time=date_time_event.split(" ")[1];
			if(rs.next())
			{
				event_id=rs.getInt("event_id");
			}
			event_id++;
			eventDescription=parseDescription(eventDescription);
			
			query="insert into event values('"+event_id+"','"+eventTopic+"','"+eventDescription+"','"+date+"','"+username+"','"+time+"')";
			/*System.out.println(query);*/
			int count=conn.createStatement().executeUpdate(query);
			
			if(count!=1)
			{
				event_id=-1;
			}
			
			
			
			
		}catch(Exception e)
		{
			e.printStackTrace();
			
		}finally{
			ConnectionDataStore.closeConn(conn);
		}
		
		
		return event_id;
	}

	
	public static boolean updateEvent(int event_id, String username, String eventTopic,String eventDescription, String date_time)
	{
		
		boolean eventUpdated=false;
		try
		{
			conn=ConnectionDataStore.getConn();
			String date=date_time.split(" ")[0];
			String time=date_time.split(" ")[1];
			
			eventDescription=parseDescription(eventDescription);
			
			String query="update event set creator='"+username+"', topic='"+eventTopic+"',eventDescription='"+eventDescription+"', date='"+date+"', time='"+time+"' where event_id='"+event_id+"'";
			/*System.out.println(query);*/
			int count=conn.createStatement().executeUpdate(query);
			if(count==1)
			{
				eventUpdated=true;
			}
		}catch(Exception e )
		{
			e.printStackTrace();
		}finally{
			ConnectionDataStore.closeConn(conn);
		}
		
		
		
		return eventUpdated;
		
	}
	
	public static boolean deleteEvent(int event_id)
	{
		boolean deletedEvent=false;
		try
		{
			InviteNeighbours.deleteAllInvites(event_id);
			EventInfo event= ShowEvents.getEventInfo(event_id);
			int count=ShowEvents.getAlInivites(event_id).size();
			if(count==0)
			{
			String query="delete from event where event_id='"+event_id+"'";
				/*System.out.println(query);*/
				int deleted=conn.createStatement().executeUpdate(query);
				if(deleted==1)
				{
					deletedEvent=true;
				
					String message="Event "+event.getEventTopic()+"  has been cancelled by "+ Neighbours.getFullName(event.getCreator());
					//EmailService.sendEventCancellationEmail(event,message,userList);
					
				}
			}
			
		}catch(Exception e)
		{
			
		}finally{
			ConnectionDataStore.closeConn(conn);
		}
		
		
		
		return deletedEvent;
	}
	
	
	private static String parseDescription(String post) throws IOException {

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
