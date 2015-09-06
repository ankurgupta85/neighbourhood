package com.neighbourhood.search;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.neighbourhood.neighbours.Neighbours;
import com.neighbourhood.user.User;
import com.neighbourhood.user.UserInfo;
import com.neighbours.datastore.ConnectionDataStore;

public class SearchNeighbours {

	private static Connection conn = null;
	public static final String USERNAME = "Username";
	public static final String NAME = "Name";
	public static final String ZIPCODE = "Zipcode";
	public static final String EMAIL = "Email";
	

	public static List<User> search(String searchQuery, String attribute) {
		List<User> searchResult = new ArrayList<User>();
		/*System.out.println("In SearchNeighbours");*/
		if (attribute.equals(USERNAME)) {
		searchResult=searchByUsername(searchQuery);

		} else if (attribute.equals(NAME)) {
			searchResult=searchByName(searchQuery);

		} else if (attribute.equals(ZIPCODE)) {
			searchResult=searchByZipCode(searchQuery);
		}else if(attribute.equals(EMAIL))
		{
			searchResult=searchByEmail(searchQuery);
		}

		return (List<User>) searchResult;

	}

	private static List<User> searchByEmail(String searchQuery) {
		List<User> searchList=new ArrayList<User>();
		try
		{
			conn=ConnectionDataStore.getConn();
			String query="select * from users where Email like  '%"+searchQuery+"%'";
			/*System.out.println("In Email: "+query);*/
			ResultSet rs=conn.createStatement().executeQuery(query);
			while(rs.next())
			{
				String user=rs.getString("username");
				User userMatch=UserInfo.getUserInfoByUsername(user);
				searchList.add(userMatch);
			}
			
			
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		finally{
			ConnectionDataStore.closeConn(conn);
		}
	


		return (List<User>) searchList;

		
		
		
		
	}

	public static List<User> searchByName(String searchQuery) {

		List<User> searchList=new ArrayList<User>();
		List<String> alreadyConsidered=new ArrayList<String>();
	/*System.out.println("In Search by Name");*/
		try
		{
			conn=ConnectionDataStore.getConn();
			
			// Need to check for 
			//0) If user entered fullname check for space and then make query.
			//1) Exact word as user entered in first_name and last_name
			//2) Split words and check for each word.
			
			
			String searchQuerycheck[]=searchQuery.split(" ");
		// User entered two words--> Need to check AND combination and OR combination
			if(searchQuerycheck.length > 1)
			{
				
				/*System.out.println("In Full name query");*/
				String firstName=searchQuerycheck[0];
				String lastName=searchQuerycheck[1];
				
				//AND combination
				String query="select * from users where First_Name like'%"+firstName+"%' and Last_Name like '%"+lastName+"%'";
				/*System.out.println(query);*/
				ResultSet rs=conn.createStatement().executeQuery(query);
				while(rs.next())
				{
					String username=rs.getString("username");
					User userMatch=UserInfo.getUserInfoByUsername(username);
					searchList.add(userMatch);
					alreadyConsidered.add(username);
				}
				
				
				query="select * from users where First_Name like '%"+firstName+"%' or Last_Name like '%"+lastName+"%'";
				/*System.out.println(query);*/
				rs=conn.createStatement().executeQuery(query);
				while(rs.next())
				{
					String username=rs.getString("username");
					if(!alreadyConsidered.contains(username))
					{
						User userMatch=UserInfo.getUserInfoByUsername(username);
						alreadyConsidered.add(username);
					}
					
				}
				
				query="select  from users where First_Name like '%"+lastName+"%' or Last_Name like '%"+firstName+"%'";
				/*System.out.println(query);*/
				
				rs=conn.createStatement().executeQuery(query);
				while(rs.next())
				{
					String username=rs.getString("username");
					if(!alreadyConsidered.contains(username))
					{
						User userMatch=UserInfo.getUserInfoByUsername(username);
						alreadyConsidered.add(username);
						
					}
					
				}
				
				
			}
			// User entered only one word --> Need to check for single word in both firstname and lastname columns . 
			else if(searchQuerycheck.length==1)
			{
				
				String query="select * from users where First_Name like '%"+searchQuery+"%' or Last_Name like '%"+searchQuery+"%'";
				/*System.out.println(query);*/
				ResultSet rs=conn.createStatement().executeQuery(query);
				while(rs.next())
				{
					String username=rs.getString("username");
					if(!alreadyConsidered.contains(username))
					{
						User userMatch=UserInfo.getUserInfoByUsername(username);
						alreadyConsidered.add(username);
						searchList.add(userMatch);
						
					}
					
					
				}
				
			}
			
			
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		finally{
			ConnectionDataStore.closeConn(conn);
			alreadyConsidered.clear();
		}
		
		
		return (List<User>) searchList;
	}

	public static List<User> searchByUsername(String searchQuery) {
		List<User> searchList=new ArrayList<User>();
		try
		{
			conn=ConnectionDataStore.getConn();
			String query="select * from users where username like '%"+searchQuery+"%'";
			/*System.out.println("In Username: "+query);*/
			ResultSet rs=conn.createStatement().executeQuery(query);
			while(rs.next())
			{
				String user=rs.getString("username");
				User userMatch=UserInfo.getUserInfoByUsername(user);
				searchList.add(userMatch);
			}
			
			
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		finally{
			ConnectionDataStore.closeConn(conn);
		}
	


		return (List<User>) searchList;
	}

	public static List<User> searchByZipCode(String searchQuery) {
		List<User> searchList=new ArrayList<User>();
		/*System.out.println("In Search by Zipcode");*/

		try
		{
			

			conn=ConnectionDataStore.getConn();
			String query="select * from users where zipcode like '%"+searchQuery+"%'";
			/*System.out.println("In Zipcode: "+query);*/
			ResultSet rs=conn.createStatement().executeQuery(query);
			while(rs.next())
			{
				String user=rs.getString("username");
				User userMatch=UserInfo.getUserInfoByUsername(user);
				searchList.add(userMatch);
			}
			
		
			
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		finally{
			ConnectionDataStore.closeConn(conn);
		}
	
		return (List<User>) searchList;
	}
	
	

}
