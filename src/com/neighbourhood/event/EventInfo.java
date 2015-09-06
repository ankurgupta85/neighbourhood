package com.neighbourhood.event;

import java.sql.Connection;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import com.neighbours.datastore.ConnectionDataStore;

public class EventInfo {
	
	private int event_id;
	private String eventTopic;
	private String eventDescription;
	private String date;
	private String time;
	private String creator;
	

	
	private static final String DATE_FORMAT_NOW = "yyyy/MM/dd";
	private static Calendar cal = Calendar.getInstance();
	private static SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT_NOW);
	private static String datetime = sdf.format(cal.getTime());

	
	
	/**
	 * @return the event_id
	 */
	public int getEvent_id() {
		return event_id;
	}
	/**
	 * @param event_id the event_id to set
	 */
	public void setEvent_id(int event_id) {
		this.event_id = event_id;
	}
	/**
	 * @return the eventTopic
	 */
	public String getEventTopic() {
		return eventTopic;
	}
	/**
	 * @param eventTopic the eventTopic to set
	 */
	public void setEventTopic(String eventTopic) {
		this.eventTopic = eventTopic;
	}
	/**
	 * @return the eventDescription
	 */
	public String getEventDescription() {
		return eventDescription;
	}
	/**
	 * @param eventDescription the eventDescription to set
	 */
	public void setEventDescription(String eventDescription) {
		this.eventDescription = eventDescription;
	}
	/**
	 * @return the date_time
	 */
	public String getDate() {
		return date;
	}
	/**
	 * @param date_time the date_time to set
	 */
	public void setDate(String date) {
		this.date = date;
	}

	/**
	 * @return the date_time
	 */
	public String getTime() {
		return time;
	}
	/**
	 * @param date_time the date_time to set
	 */
	public void setTime(String time) {
		this.time = time;
	}
	
	/**T
	 * @return the creator
	 */
	public String getCreator() {
		return creator;
	}
	/**
	 * @param creator the creator to set
	 */
	public void setCreator(String creator) {
		this.creator = creator;
	}
	

	public static boolean alreadyInvited(String user,int event_id)
	{
		/*System.out.println("In Event Users");*/
		boolean alreadyInvited=false;
		Connection conn=null;
		try{
			conn=ConnectionDataStore.getConn();
			String query="select * from event_users where event_id='"+event_id+"' and user='"+user+"'";
			/*System.out.println(query);*/
			ResultSet rs=conn.createStatement().executeQuery(query);
			if(rs.next())
			{
				alreadyInvited=true;
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}finally{
			ConnectionDataStore.closeConn(conn);
		}
		
		
		return alreadyInvited;
	}
	
	
	
	public static int countPastEvents(String username)
	{			
		int count=0;

			List<EventInfo> allEvents=ShowEvents.getAllEvents(username);
		for(EventInfo event : allEvents)
		{
			
			if(event.getDate().compareTo(datetime) < 0)
			{
				count ++;
			}
		}
		allEvents.clear();
		return count;
		
	}

	public static int countFutureEvents(String username)
	{
		
	

		int count=0;

			
		List<EventInfo> allEvents=ShowEvents.getAllEvents(username);
		for(EventInfo event : allEvents)
		{
			if(event.getDate().compareTo(datetime) > 0)
			{
				count ++;
			}
		}
		
		allEvents.clear();
		return count;
		
		
		
	}
	

	public static int countTodayEvents(String username)
	{
		int count=0;
		
	
		List<EventInfo> allEvents=ShowEvents.getAllEvents(username);
		for(EventInfo event : allEvents)
		{
			if(event.getDate().compareTo(datetime) == 0)
			{
				count ++;
			}
		}

		allEvents.clear();
		return count;
		
		
	}
	
	public static boolean isFutureDate(String date_time)
	{
		if(date_time.compareTo(datetime) > 0)
		{
			return true;
		}
		else
		{
			return false;
		}
		
	}
	
	

	public static boolean isPastDate(String date_time)
	{
		if(date_time.compareTo(datetime) < 0)
		{
			return true;
		}
		else
		{
			return false;
		}
		
	}

}
