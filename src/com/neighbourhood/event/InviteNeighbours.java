package com.neighbourhood.event;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.neighbourhood.email.EmailService;
import com.neighbourhood.neighbours.Neighbours;
import com.neighbours.datastore.ConnectionDataStore;
import com.sun.corba.se.pept.transport.ConnectionCache;

public class InviteNeighbours {

	private static boolean inviteSent=false;
	private static Connection conn=null;
	public static boolean inviteNeighbours(int event_id, List<String> neighbours)
	{
		
		/*System.out.println("In InviteNeighbours");*/
		try
		{
			conn=ConnectionDataStore.getConn();
			for(String neighbourUsername:neighbours)
			{
				
				String query="insert into event_users values('"+event_id+"','"+neighbourUsername+"')";
			/*	System.out.println(query);*/
				int count=conn.createStatement().executeUpdate(query);
				if(count!=1)
				{
					inviteSent=false;
					break;
				}
				else
				{
					inviteSent=true;
					
						EventInfo event = ShowEvents.getEventInfo(event_id);
						String message="You have been invited to event "+event.getEventTopic()+" by "+ Neighbours.getFullName(event.getCreator());
						EmailService.sendEventInviteEmail(event,message,neighbourUsername);
					
						
					
					
				}
			}
			
			
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}finally{
			ConnectionDataStore.closeConn(conn);
		}
		
		
		
		return inviteSent;
	}
	
	
	
	
	
	public static boolean updateInviteNeighbours(int event_id,List<String> newInvites)
	{
		List<String> alreadyInvitedList=ShowEvents.getAlInivites(event_id);
		List<String> insertNewInvites=new ArrayList<String>();
		List<String> deleteInvites=new ArrayList<String>();
		for(String username : newInvites)
		{
			if(alreadyInvitedList.contains(username))
			{
				// no operation needed. Row already exists for the same in database.
				// Remove that username from alreadyInvitedList
				alreadyInvitedList.remove(username);
			}
			else if(!alreadyInvitedList.contains(username))
			{
				// New invite needs to be sent . 
				insertNewInvites.add(username);
				
			}
			
			
			
		}
		
		//Now alreadyInvitedList contains the records to be removed/status change to NotInvited.
		deleteInvites=alreadyInvitedList;
		
		boolean invitesNew=false;
		
		//Perform operation for new invites
		if(insertNewInvites.size()>0)
		{
			 invitesNew = performOperation(event_id, insertNewInvites, "insert");
		}
		
		boolean invitesDeleted=false;
		if(deleteInvites.size()>0)
		{
			invitesDeleted = performOperation(event_id, deleteInvites, "delete");
		}
		
		
		/*System.out.println("Update Invite Neighbours");*/
	/*	deleteAllInvites(event_id);
		try
		{			
			conn=ConnectionDataStore.getConn();
			for(String user:newInvites)
			{
				String query="insert into event_users values('"+event_id+"','"+user+"')";
				System.out.println(query);
				int count=conn.createStatement().executeUpdate(query);
				if(count!=1)
				{
					updatedInvites=false;
					break;
				}
			}
			
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}finally{
			ConnectionDataStore.closeConn(conn);
		}
		
		return updatedInvites;
		
		
	*/	
		
		if(insertNewInvites.size()>0 && deleteInvites.size()>0)
			return invitesNew && invitesDeleted;
		if(insertNewInvites.size()==0 && deleteInvites.size()>0)
			return invitesDeleted;
		if(insertNewInvites.size()>0 && deleteInvites.size()==0)
			return invitesNew;
		
		
		return true;
		
		
	}
	
	
	
	public static void deleteAllInvites(int event_id)
	{
		try{
			conn=ConnectionDataStore.getConn();
			String query="delete from event_users where event_id='"+event_id+"'";
			/*System.out.println(query);*/
			conn.createStatement().executeUpdate(query);
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}finally{
			ConnectionDataStore.closeConn(conn);
		}
		
	}
	
	
	private static boolean performOperation(int event_id,List<String> list,String operation)
	{
		
	String query="";
	boolean status=false;
	
	try{
		conn=ConnectionDataStore.getConn();
		if(operation.equals("insert"))
		{
			for(String username: list)
			{
			
			query="insert into event_users values('"+event_id+"','"+username+"')";
			/*System.out.println(query);*/
			int count = conn.createStatement().executeUpdate(query);
			if(count ==1)
				status=true;
			}
		}
		else if(operation.equals("delete"))
		{
			for(String username: list)
			{
			
			query="delete from event_users where event_id='"+event_id+"' and user='"+username+"'";
			/*System.out.println(query);*/
			
			int count = conn.createStatement().executeUpdate(query);
			if(count ==1)
				status=true;
			}
		}

		
	}catch(Exception e)
	{
		e.printStackTrace();
	}finally{
		ConnectionDataStore.closeConn(conn);
	}
			
		
	return status;
	}
	
	
		
}

