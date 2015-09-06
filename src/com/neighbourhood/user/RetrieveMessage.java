package com.neighbourhood.user;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.neighbourhood.message.MessageInfo;
import com.neighbours.datastore.ConnectionDataStore;

public class RetrieveMessage {

	private static Map<Integer, String> messageMap = new HashMap<Integer, String>();
	private static Connection conn = null;
	private static List<Integer> messageParsed = new ArrayList<Integer>();

	public static HashMap<Integer, String> getMessages(String user) {

		/*System.out.println("In Retrieve Messages");*/
		try {
			conn = ConnectionDataStore.getConn();
			// First get all messages started by current user

			// first check all the messsages that user sent
			// if user sends message and at the end the last child is unread and
			// receiver = user, mark main message as unread else read

			String query = "select * from messages where prev_message_id='" + 0
					+ "' and (sender='" + user + "' or receiver='"+user+"')";
			/*System.out.println(query);*/
			ResultSet rs = conn.createStatement().executeQuery(query);
			while (rs.next()) {
				int currMessageID = rs.getInt("message_id");
				/*System.out.println(currMessageID);*/
				List<MessageInfo> currMessageChildList = (ArrayList<MessageInfo>) getMessageList(currMessageID);
				/*System.out.println(currMessageChildList.size());
				*/boolean messageUnread = false;
				for (MessageInfo message : currMessageChildList) {

				/*	System.out.println("Message ID " + message.getMessageID()
							+ "   MEssage Status   " + message.getStatus()
							+ "  Message Receiver  " + message.getReceiver());
				*/	// Current message receiver
					if (message.getReceiver().equals(user)
							&& message.getStatus().equals(
									MessageInfo.MESSAGE_STATUS_UNREAD)) {

/*						System.out.println("In "+ messageMap);
*/						messageMap.put(currMessageID,
								MessageInfo.MESSAGE_STATUS_UNREAD);
						messageUnread = true;
						break;

					}

				}

				if (!messageUnread) {
					messageMap.put(currMessageID,
							MessageInfo.MESSAGE_STATUS_READ);
				}
				/*System.out.println(messageMap);
*/
			}
			

			
		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			ConnectionDataStore.closeConn(conn);

		}

		return (HashMap<Integer, String>) messageMap;

	}

	
	private static List<Integer> getchildMessageList(int prev_message_id) {
		Connection conn = null;
		List<Integer> arrayList = new ArrayList<Integer>();
		try {
			conn = ConnectionDataStore.getConn();
			String query = "select * from messages where prev_message_id='"
					+ prev_message_id + "'";
			ResultSet rs = conn.createStatement().executeQuery(query);
			while (rs.next()) {
				if (!arrayList.contains(rs.getInt("message_id"))) {
					arrayList.add(rs.getInt("message_id"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			ConnectionDataStore.closeConn(conn);

		}
		return (ArrayList<Integer>) arrayList;

	}

	public static MessageInfo getMessage(int message_id) {
		MessageInfo message = null;

		try {
			conn = ConnectionDataStore.getConn();
			String query = "select * from messages where message_id='"
					+ message_id + "'";
			ResultSet rs = conn.createStatement().executeQuery(query);
			if (rs.next()) {
				message = new MessageInfo();
				message.setMessageID(rs.getInt("message_id"));
				message.setSender(rs.getString("sender"));
				message.setReceiver(rs.getString("receiver"));
				message.setMessage(rs.getString("message"));
				message.setStatus(rs.getString("status"));
				message.setDate_time(rs.getString("date_time"));
				message.setMessageTopic(rs.getString("messageTopic"));
				message.setPrevMessageID(rs.getInt("prev_message_id"));

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDataStore.closeConn(conn);
		}

		return message;
	}

	public static List<MessageInfo> getMessageList(int message_id) {
		List<MessageInfo> messageList = new ArrayList<MessageInfo>();
		try {

			conn = ConnectionDataStore.getConn();
			String query = "select * from messages where message_id='"
					+ message_id + "' or prev_message_id='" + message_id
					+ "' order by date_time desc";
/*			System.out.println(query);
*/			ResultSet rs = conn.createStatement().executeQuery(query);
			while (rs.next()) {
				MessageInfo message = new MessageInfo();
				message.setMessageID(rs.getInt("message_id"));
				message.setSender(rs.getString("sender"));
				message.setReceiver(rs.getString("receiver"));
				message.setMessage(rs.getString("message"));
				message.setStatus(rs.getString("status"));
				message.setDate_time(rs.getString("date_time"));
				message.setMessageTopic(rs.getString("messageTopic"));
				message.setPrevMessageID(rs.getInt("prev_message_id"));
				messageList.add(message);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDataStore.closeConn(conn);
		}

		return (ArrayList<MessageInfo>) messageList;
	}
	

}
