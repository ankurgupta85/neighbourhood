package com.neighbourhood.request;

import java.sql.Connection;
import java.sql.Statement;

import com.neighbourhood.status.NeighbourhoodStatus;
import com.neighbours.datastore.ConnectionDataStore;

public class NeighbourRequest {

	static Connection conn = null;

	// Called this method when a request is sent from one user to become
	// neighbour
	// This method will add the request to database
	public static boolean addNeighbourRequest(String user1, String user2) {
		// user1= session user
		// user2 = user to which request is sent.
		/*System.out.println("In NeighbourRequest.addNeighbourRequest");*/

		int recordsEntered = 0;
		boolean flag = false;
		try {
			conn = ConnectionDataStore.getConn();
			String insertRequest = "insert into neighbours values('" + user1
					+ "','" + user2 + "','"
					+ NeighbourhoodStatus.REQUEST_FOR_NEIGHBOURS + "')";
			/*System.out.println(insertRequest);*/

			Statement st = conn.createStatement();
			recordsEntered = st.executeUpdate(insertRequest);

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			ConnectionDataStore.closeConn(conn);
		}

		if (recordsEntered == 1) {
			flag = true;
		}

		return flag;

	}
	

	
	
	
}
