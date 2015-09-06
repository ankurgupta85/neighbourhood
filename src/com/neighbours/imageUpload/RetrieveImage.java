package com.neighbours.imageUpload;

import java.io.File;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.neighbours.datastore.ConnectionDataStore;

public class RetrieveImage {

	private static String fullPath="C:\\git\\projects\\Neighbourhood\\Neighbourhood\\WebContent\\images_users\\";
	private static Connection conn=null;
	public static String getProfilePicName(String username)
	{
		String profilePicName=null;
		try
		{
			conn=ConnectionDataStore.getConn();
			String query="select ProfilePic from users where username='"+username+"'";
			ResultSet rs=conn.createStatement().executeQuery(query);
			if(rs!=null && rs.next())
			{
				profilePicName=rs.getString("ProfilePic");
			}
			
			
		}catch(Exception e)
		{
			e.printStackTrace();
			
		}finally{
			ConnectionDataStore.closeConn(conn);
		}
		
		return profilePicName;
	}
	
	
	
	
	
	public static List<String> getAllImagesForUser(String username)
	{
		List<String> imagesNames=new ArrayList<String>();
		
		try
		{
		File f=new File(fullPath+username+"\\");
		boolean directoryFound=false;
		if(f.exists())
		{
			directoryFound=true;
		}
		
		if(directoryFound)
		{
			String modifiedFullPath=fullPath+username+"\\";
			File allImages=new File(modifiedFullPath);
			String[] files=allImages.list();
			for(String file: files)
			{
				if(!imagesNames.contains(file))
				{
					imagesNames.add(file);
				}
			}
			
			
		}
		else
		{
			f.mkdir();
		}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return (ArrayList<String>)imagesNames;
		
	}
	
	public static String getProfileImagePath(String username)
	{
		String absPath=fullPath+username+"\\";
		String defaultImage="defaultNoPic.ico";
		String path="http://localhost:8080/Neighbourhood/images_users/";
		try
		{
		String profilePicName=getProfilePicName(username);
		if(profilePicName == null)
		{//If no profile pic
			profilePicName=defaultImage;
			path+=profilePicName;
		}
		else
		{
			// check if the file is present in the user folder or not
			File userFile=new File(absPath+profilePicName);
			boolean picFound=false;
			if(userFile.exists())
			{
				picFound=true;
			}
			if(picFound)
			{
				path+=username+"/"+profilePicName;
			}
			else
			{
				profilePicName=defaultImage;
				path+=profilePicName;
				
			}
		}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return path;
	}
	
	
	

	public static String getImagePath(String username,String imageName)
	{
		String absPath=fullPath+username+"\\";
		String path="http://localhost:8080/Neighbourhood/images_users/";
		try
		{
			
		
			// check if the file is present in the user folder or not
			File userFile=new File(absPath+imageName);
			boolean picFound=false;
			if(userFile.exists())
			{
				picFound=true;
			}
			
			
			if(picFound)
			{
				path+=username+"/"+imageName;
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return path;
	}

}
