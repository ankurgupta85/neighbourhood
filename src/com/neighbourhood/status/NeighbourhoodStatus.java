package com.neighbourhood.status;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import com.neighbours.datastore.ConnectionDataStore;
import com.sun.corba.se.spi.orbutil.fsm.Guard.Result;

public class NeighbourhoodStatus {

	public final static String NEIGHBOURS = "NEIGHBOURS";
	public final static String NOT_NEIGHBOURS = "NOT_NEIGHBOURS";
	public final static String REQUEST_FOR_NEIGHBOURS = "REQUEST_FOR_NEIGHBOURS";

	private static Connection conn = null;

	public static String getNeighboursStatus(String user1, String user2) {

		/*System.out.println("In NeighbourhoodStatus.getNeighboursStatus");*/
		String status = null;

		if (user1.equals(user2)) {
			status = NEIGHBOURS;
		} else {

			try {
				conn = ConnectionDataStore.getConn();
				Statement st = conn.createStatement();
				String query = "select * from neighbours where (username1='"
						+ user1 + "' and username2='" + user2
						+ "') or (username1='" + user2 + "' and username2='"
						+ user1 + "')";

				/*System.out.println(query);*/
				ResultSet resultSet = st.executeQuery(query);
				if (resultSet.next()) {
					status = resultSet.getString("Status");
				} else {
					status = NOT_NEIGHBOURS;
				}

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				ConnectionDataStore.closeConn(conn);
			}
		}
		return status;

	}
}
