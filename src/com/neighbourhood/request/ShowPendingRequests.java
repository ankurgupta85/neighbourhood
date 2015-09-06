package com.neighbourhood.request;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.neighbourhood.status.NeighbourhoodStatus;
import com.neighbourhood.user.User;
import com.neighbourhood.user.UserInfo;
import com.neighbours.datastore.ConnectionDataStore;

public class ShowPendingRequests {

	static Connection conn = null;
	static List<User> pendingRequest = null;

	public static List<User> getPendingRequestToAccept(String username) {
		 pendingRequest = new ArrayList<User>();
	/*	System.out.println("In ShowPendingRequest.getPendingRequest");*/
		try {

			conn = ConnectionDataStore.getConn();
			String findUsersQuery = "select * from neighbours where username2='"
					+ username
					+ "' and Status='"
					+ NeighbourhoodStatus.REQUEST_FOR_NEIGHBOURS + "'";
			/*System.out.println(findUsersQuery);*/
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(findUsersQuery);
			while (rs.next()) {

				String from = rs.getString("username1");
				User user=UserInfo.getUserInfoByUsername(from);
				pendingRequest.add(user);
				

			}

			/*System.out.println(pendingRequest);*/
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDataStore.closeConn(conn);
		}

		return (List<User>) pendingRequest;
	}
	
	
	
	public static int getPendingRequestCount(String username)
	{
		int count=0;
		List<User> pendingRequestMap=getPendingRequestToAccept(username);
		
		count=pendingRequestMap.size();
		return count;
	}

}
