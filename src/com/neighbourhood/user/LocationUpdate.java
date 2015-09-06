package com.neighbourhood.user;

import java.sql.Connection;
import java.sql.ResultSet;

import com.neighbours.datastore.ConnectionDataStore;

public class LocationUpdate {

	private static Connection conn=null;
	public static boolean update(String username,String zipcode)
	{
		boolean updatedLocation=false;
		try
		{
			conn=ConnectionDataStore.getConn();
			String query="update users set zipcode='"+zipcode+"' where username='"+username+"'";
			/*System.out.println(query);*/
			int count=conn.createStatement().executeUpdate(query);
			if(count == 1)
			{
				updatedLocation=true;
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}finally{
			ConnectionDataStore.closeConn(conn);
		}
		
		
		
		
		return updatedLocation;
	}
	
	public static boolean checkZipcode(String username,String zipcode)
	{
		boolean sameLocation=false;
		try
		{
			conn=ConnectionDataStore.getConn();
			String query="select zipcode from users where username='"+username+"'";
		/*	System.out.println(query);*/
			ResultSet rs=conn.createStatement().executeQuery(query);
			if(rs.next())
			{
				String currentZipcode=rs.getString("zipcode");
				if(zipcode.equals(currentZipcode))
				{
					sameLocation=true;
				}
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}finally{
			ConnectionDataStore.closeConn(conn);
		}
		
		
		
		
		return sameLocation;
	}
	
	
	
}
