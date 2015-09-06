package com.neighbourhood.request;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.neighbourhood.status.NeighbourhoodStatus;
import com.neighbourhood.user.User;
import com.neighbours.datastore.ConnectionDataStore;

public class Request {

	private static boolean accepted = false;
	private static boolean rejected = false;
	private static Connection conn = null;
	private static boolean cancelled = false;

	// To Accept request sent to session user
	public static boolean acceptedRequest(String user1, String user2) {
		// user1 = User who is login into system
		// user2 = User who sent the request

		/*System.out.println("In Request.acceptedRequest");*/

		try {
			conn = ConnectionDataStore.getConn();
			String query = "update neighbours set status='"
					+ NeighbourhoodStatus.NEIGHBOURS + "' where username1='"
					+ user2 + "' and username2='" + user1 + "'";
			/*System.out.println(query);*/
			int count = conn.createStatement().executeUpdate(query);

			if (count == 1) {
				accepted = true;

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDataStore.closeConn(conn);
		}
		return accepted;

	}

	// To Reject request sent to session user
	public static boolean rejectedRequest(String user1, String user2) {
		try {

			/*System.out.println("In Request.rejectedRequest");*/
			conn = ConnectionDataStore.getConn();
			String status = "";
			int count = 0;
			String query = "select * from neighbours where username1='" + user2
					+ "' and username2='" + user1 + "'";
			ResultSet result = conn.createStatement().executeQuery(query);
			if (result.next()) {
				status = result.getString("Status");
				if (status.equals(NeighbourhoodStatus.REQUEST_FOR_NEIGHBOURS)) {
					query = "delete from neighbours where username1='" + user2
							+ "' and username2='" + user1 + "'";
					count = conn.createStatement().executeUpdate(query);

				}

			}

			if (count == 1) {
				rejected = true;

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDataStore.closeConn(conn);
		}
		return rejected;

	}

	// To show session user the requests he sent
	public static List<User> showSentRequest(String username) {

		/*System.out.println("In Request.showSentRequest");*/
		List<User> sentRequest = new ArrayList<User>();

		try {
			conn = ConnectionDataStore.getConn();
			String query = "select * from neighbours where username1='"
					+ username + "' and status='"
					+ NeighbourhoodStatus.REQUEST_FOR_NEIGHBOURS + "'";
			ResultSet rs = conn.createStatement().executeQuery(query);
			while (rs.next()) {
				String otherUser = rs.getString("username2");
				String queryFullName = "select * from users where username='"
						+ otherUser + "'";
				ResultSet rs1 = conn.createStatement().executeQuery(
						queryFullName);
				if (rs1.next()) {
				
					User user=new User();
					user.setFname(rs1.getString("First_Name"));
					user.setLname(rs1.getString("Last_Name"));
					user.setUsername(otherUser);
							
					sentRequest.add(user);
					
					
				}

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDataStore.closeConn(conn);
		}

		return (ArrayList<User>) sentRequest;

	}

	// To cancel request sent by user
	public static boolean cancelRequest(String user1, String user2) {
		try {

			/*System.out.println("In Request.cancelRequest");*/
			conn = ConnectionDataStore.getConn();
			String status = "";
			int count = 0;
			String query = "select * from neighbours where username1='" + user1
					+ "' and username2='" + user2 + "'";
			ResultSet result = conn.createStatement().executeQuery(query);
			if (result.next()) {
				status = result.getString("Status");
				if (status.equals(NeighbourhoodStatus.REQUEST_FOR_NEIGHBOURS)) {
					query = "delete from neighbours where username1='" + user1
							+ "' and username2='" + user2 + "'";
					count = conn.createStatement().executeUpdate(query);

				}

			}

			if (count == 1) {
				cancelled = true;

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDataStore.closeConn(conn);
		}
		return cancelled;

	}

	public static Map<String, String> updateShowSentRequest(
			Map<String, String> showSentRequest,
			Map<String, String> updatedShowSentRequest) {

		Iterator iterator = updatedShowSentRequest.entrySet().iterator();
		while (iterator.hasNext()) {
			Map.Entry<String, String> userNeighbourInfo = (Map.Entry<String, String>) iterator
					.next();
			String username = userNeighbourInfo.getKey().toString();
			String fullname = userNeighbourInfo.getValue().toString();

			if (showSentRequest != null) {

				if (!showSentRequest.containsKey(username)) {
					showSentRequest.put(username, fullname);
				}
			} else {
				showSentRequest = new HashMap<String, String>();
				showSentRequest.put(username, fullname);
			}
		}
		return (HashMap<String, String>) showSentRequest;
	}

}
