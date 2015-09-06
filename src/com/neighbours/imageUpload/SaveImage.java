/**
 * 
 */
package com.neighbours.imageUpload;

import java.sql.Connection;

import com.neighbours.datastore.ConnectionDataStore;

/**
 * @author agupta2
 *
 */
public class SaveImage {

private static Connection conn=null;
	
	public static boolean saveProfilePic(String filename,String username)
	{
		boolean profilePicSaved=false;
		try
		{
			conn=ConnectionDataStore.getConn();
			String query="update users set ProfilePic='"+filename+"' where username='"+username+"'";
			int count=conn.createStatement().executeUpdate(query);
			if(count == 1)
			{
				profilePicSaved=true;
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}finally{
			ConnectionDataStore.closeConn(conn);
		}
		
	
		return profilePicSaved;
	}
	
	
}
