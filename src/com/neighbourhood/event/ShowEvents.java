package com.neighbourhood.event;

import java.sql.Connection;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import com.neighbours.datastore.ConnectionDataStore;
import com.sun.corba.se.pept.transport.ConnectionCache;

public class ShowEvents {
	
	private static final String DATE_FORMAT_NOW = "yyyy/MM/dd";
	private static Calendar cal = Calendar.getInstance();
	private static SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT_NOW);
	private static String datetime = sdf.format(cal.getTime());

	private static List<EventInfo> eventList = new ArrayList<EventInfo>();
	private static Connection conn = null;

	public static List<EventInfo> getAllEvents(String username) {
		/*System.out.println("In ShowEvents");*/
		List<Integer> alreadyConsideredEventID = new ArrayList<Integer>();
		try {
			conn = ConnectionDataStore.getConn();

			// Get events created by user
			String query = "select * from event where creator='" + username
					+ "' order by date";

			/*System.out.println(query);*/
			ResultSet rs = conn.createStatement().executeQuery(query);
			while (rs.next()) {
				if (!alreadyConsideredEventID.contains(rs.getInt("event_id"))) {
					alreadyConsideredEventID.add(rs.getInt("event_id"));
					EventInfo event = new EventInfo();
					event.setEvent_id(rs.getInt("event_id"));
					event.setEventTopic(rs.getString("topic"));
					event.setEventDescription(rs.getString("eventDescription"));
					event.setCreator(rs.getString("creator"));
					event.setDate(rs.getString("date"));
					event.setTime(rs.getString("time"));
					eventList.add(event);

				}
			}

			// get Events not created by user but invited
			query = "select event_id from event_users where user='" + username
					+ "'";
			/*System.out.println(query);*/
			rs = conn.createStatement().executeQuery(query);
			while (rs.next()) {
				int id = rs.getInt("event_id");
				if(!alreadyConsideredEventID.contains(id))
				{

				String sql = "select  * from event where event_id='" + id + "'";

				ResultSet rs1 = conn.createStatement().executeQuery(sql);
				if (rs1.next()) {

					EventInfo event = new EventInfo();
					event.setEvent_id(rs1.getInt("event_id"));
					event.setEventTopic(rs1.getString("topic"));
					event.setEventDescription(rs1.getString("eventDescription"));
					event.setCreator(rs1.getString("creator"));
					event.setDate(rs1.getString("date"));
					event.setTime(rs1.getString("time"));
					eventList.add(event);
				}
			}

		}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			alreadyConsideredEventID.clear();
			ConnectionDataStore.closeConn(conn);
		}
		
		return (ArrayList<EventInfo>) eventList;
	}

	public static EventInfo getEventInfo(int event_id) {
		EventInfo event = null;
		try {
			conn = ConnectionDataStore.getConn();
			String sql = "select  * from event where event_id='" + event_id
					+ "'";
			ResultSet rs = conn.createStatement().executeQuery(sql);
			if (rs.next()) {
				event = new EventInfo();
				event.setCreator(rs.getString("creator"));
				event.setDate(rs.getString("date"));
				event.setTime(rs.getString("time"));
				event.setEvent_id(rs.getInt("event_id"));
				event.setEventDescription(rs.getString("eventDescription"));
				event.setEventTopic(rs.getString("topic"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDataStore.closeConn(conn);
		}

		return event;
	}

	public static List<String> getAlInivites(int event_id) {
		List<String> userList = new ArrayList<String>();
		try {
			conn = ConnectionDataStore.getConn();
			String sql = "select * from event_users where event_id='"
					+ event_id + "'";
			/*System.out.println(sql);*/
			ResultSet rs = conn.createStatement().executeQuery(sql);
			while (rs.next()) {
				String user = rs.getString("user");
				if (!userList.contains(user)) {
					userList.add(user);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDataStore.closeConn(conn);
		}
		return (ArrayList<String>) userList;
	}
	
	
	
	
	public static List<EventInfo> getPastEvents(String username)
	{
		
		List<EventInfo> pastEventsList=new ArrayList<EventInfo>();
		List<EventInfo> allEvents=getAllEvents(username);
		
		for(EventInfo event : allEvents)
		{
			if(event.getDate().compareTo(datetime) < 0)
				pastEventsList.add(event);
			
			
		}
		
		
		allEvents.clear();
		
		
		return (ArrayList<EventInfo>)pastEventsList;
		
	}
 

	public static List<EventInfo> getTodayEvents(String username)
	{
		
		List<EventInfo> todayEventsList=new ArrayList<EventInfo>();
		List<EventInfo> allEvents=getAllEvents(username);
		
		for(EventInfo event : allEvents)
		{
			if(event.getDate().compareTo(datetime) == 0)
				todayEventsList.add(event);
			
			
		}
		
		
		allEvents.clear();
		
		
		return (ArrayList<EventInfo>)todayEventsList;
		
	}
	

	public static List<EventInfo> getFutureEvents(String username)
	{
		
		List<EventInfo> futureEventsList=new ArrayList<EventInfo>();
		List<EventInfo> allEvents=getAllEvents(username);
		
		for(EventInfo event : allEvents)
		{
			if(event.getDate().compareTo(datetime) > 0)
				futureEventsList.add(event);
			
			
		}
		
		
		allEvents.clear();
		
		
		return (ArrayList<EventInfo>)futureEventsList;
		
	}
}
