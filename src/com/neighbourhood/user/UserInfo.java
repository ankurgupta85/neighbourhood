package com.neighbourhood.user;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;

import com.neighbourhood.email.EmailService;
import com.neighbours.datastore.ConnectionDataStore;

public class UserInfo {
	
	private static Connection conn;
	
	public static User getUserInfoByUsername(String username)
	{
		User userObj=null;
		try
		{
			conn=ConnectionDataStore.getConn();
			String query="select * from users where username='"+username+"'";
			ResultSet rs=conn.createStatement().executeQuery(query);
			if(rs.next())
			{
				userObj=new User();
				userObj.setFname(rs.getString("First_Name"));
				userObj.setLname(rs.getString("Last_Name"));
			//	userObj.setCountry(rs.getString("Country"));
				userObj.setEmail(rs.getString("Email"));
				userObj.setPassword(rs.getString("Password"));
				userObj.setUsername(username);
				userObj.setZipcode(rs.getString("Zipcode"));
				userObj.setProfilePic(rs.getString("ProfilePic"));
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		finally{
			
			ConnectionDataStore.closeConn(conn);
		}
		
		
		
		
		return userObj;
	}
	
	
	public static boolean changePassword(String userName,String newPassword) throws IOException
	{
		boolean updated=false;
		try
		{
			conn=ConnectionDataStore.getConn();
			String query="update users set password='"+newPassword+"' where username='"+userName+"'";
			int count=conn.createStatement().executeUpdate(query);
			if(count==1)
			{
				updated=true;
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}finally{
			ConnectionDataStore.closeConn(conn);
		}
		
		if(updated)
		{
			EmailService.sendPasswordChangeMail(userName,newPassword);
		}
		
		return updated;
		
	}

	

	public static User getUserInfoByEmail(String email)
	{
		User userObj=null;
		try
		{
			conn=ConnectionDataStore.getConn();
			String query="select * from users where Email='"+email+"'";
			ResultSet rs=conn.createStatement().executeQuery(query);
			if(rs.next())
			{
				userObj=new User();
				userObj.setFname(rs.getString("First_Name"));
				userObj.setLname(rs.getString("Last_Name"));
			//	userObj.setCountry(rs.getString("Country"));
				userObj.setEmail(rs.getString("Email"));
				userObj.setPassword(rs.getString("Password"));
				userObj.setUsername(rs.getString("Username"));
				
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		finally{
			
			ConnectionDataStore.closeConn(conn);
		}
		
		
		
		
		return userObj;
	}
	
}
