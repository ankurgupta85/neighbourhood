package com.neighbourhood.message;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.neighbourhood.user.RetrieveMessage;
import com.neighbours.datastore.ConnectionDataStore;

public class MessageInfo {

	private int messageID;
	private String sender;
	private String receiver;
	private String message;
	private String status;
	private String date_time;
	private String messageTopic;
	private int prev_messageID;
	public static final String MESSAGE_STATUS_READ = "READ";
	public static final String MESSAGE_STATUS_UNREAD = "UNREAD";

	public String getDate_time() {
		return date_time;
	}

	public void setDate_time(String date_time) {
		this.date_time = date_time;
	}

	public int getMessageID() {
		return messageID;
	}

	public void setMessageID(int messageID) {
		this.messageID = messageID;
	}

	public int getPrevMessageID() {
		return prev_messageID;
	}

	public void setPrevMessageID(int prevmessageID) {
		this.prev_messageID = prevmessageID;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getMessageTopic() {
		return messageTopic;
	}

	public void setMessageTopic(String messageTopic) {
		this.messageTopic = messageTopic;
	}

	// Update message status from UNREAD to READ for all the children of
	// message_id where receiver = current user
	public static boolean updateMessageStatus(int message_id, String username) {
		Connection conn = null;
		boolean statusUpdated = false;
		try {
			conn = ConnectionDataStore.getConn();
			String query = "select * from messages where prev_message_id='"
					+ message_id + "' or message_id='" + message_id + "'";
			ResultSet rs = conn.createStatement().executeQuery(query);
			/*System.out.println(query);*/
			while (rs.next()) {

				int currMessageID = rs.getInt("message_id");
				if (rs.getString("receiver").equals(username)) {

					String sql = "update messages set status='"
							+ MESSAGE_STATUS_READ + "' where message_id='"
							+ currMessageID + "' or prev_message_id='"
							+ currMessageID + "'";
					/*System.out.println(sql);*/
					int count = conn.createStatement().executeUpdate(sql);

					if (count == 1) {
						statusUpdated = true;
					} else {
						statusUpdated = false;
						break;
					}

				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDataStore.closeConn(conn);
		}

		return statusUpdated;
	}
	

	
	public static List<MessageInfo> getUnreadMessages(String username)
	{
		List<MessageInfo> allUnreadMessages=new ArrayList<MessageInfo>();
		List<Integer> checkParsedMessages= new ArrayList<Integer>();
		Map<Integer,String> allMessages=RetrieveMessage.getMessages(username);
		Iterator iter=allMessages.entrySet().iterator();
		while(iter.hasNext())
		{
			Map.Entry<Integer, String> message = (Map.Entry<Integer, String>) iter
					.next();
			
			if(message.getValue().equals(MESSAGE_STATUS_UNREAD))
			{
				if(!checkParsedMessages.contains(message.getKey()))
						{
					MessageInfo messageInfo=RetrieveMessage.getMessage(message.getKey());
					allUnreadMessages.add(messageInfo);
					
					
					
						}
			}
			
		}
		checkParsedMessages.clear();
		
		return (ArrayList<MessageInfo>) allUnreadMessages;
	}


	public static List<MessageInfo> getReadMessages(String username)
	{
		List<MessageInfo> allReadMessages=new ArrayList<MessageInfo>();
		List<Integer> checkParsedMessages= new ArrayList<Integer>();
		Map<Integer,String> allMessages=RetrieveMessage.getMessages(username);
		Iterator iter=allMessages.entrySet().iterator();
		while(iter.hasNext())
		{
			Map.Entry<Integer, String> message = (Map.Entry<Integer, String>) iter
					.next();
			
			if(message.getValue().equals(MESSAGE_STATUS_READ))
			{
				if(!checkParsedMessages.contains(message.getKey()))
						{
					MessageInfo messageInfo=RetrieveMessage.getMessage(message.getKey());
					allReadMessages.add(messageInfo);
					
					
					
						}
			}
			
		}
		
		checkParsedMessages.clear();
		return (ArrayList<MessageInfo>) allReadMessages;
	}
	
	
	public static int countUnreadMessages(String username)
	{
		int count=0;
		
		List<MessageInfo> messages=getUnreadMessages(username);
		count=messages.size();
		return count;
	}

	public static int countReadMessages(String username)
	{
		int count=0;
		
		List<MessageInfo> messages=getReadMessages(username);
		count=messages.size();
		return count;
	}
}
