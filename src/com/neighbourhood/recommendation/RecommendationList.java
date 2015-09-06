package com.neighbourhood.recommendation;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.neighbourhood.status.NeighbourhoodStatus;
import com.neighbourhood.user.User;
import com.neighbourhood.user.UserInfo;
import com.neighbours.datastore.ConnectionDataStore;

public class RecommendationList {

	private static List<User> recommendationList = null;
	private static Connection conn = null;

	public static List<User> getRecommendation(String username,int zipCode) {

		recommendationList=new ArrayList<User>();
	/*	System.out.println("In RecommendationList.getRecommendation");*/
		try {
			conn = ConnectionDataStore.getConn();
			String findExactQuery = "select username from users where zipcode='"
					+ zipCode + "'";
		/*	System.out.println(findExactQuery);*/
			Statement st = conn.createStatement();
			ResultSet result = st.executeQuery(findExactQuery);
			while (result != null && result.next()) {
				String userFound=result.getString("username");
				if(NeighbourhoodStatus.getNeighboursStatus(username, userFound).equals(NeighbourhoodStatus.NOT_NEIGHBOURS))
				{
					User user=UserInfo.getUserInfoByUsername(userFound);
					recommendationList.add(user);
					
				}
				
				
			}
			String findNearQuery = "select username from users where zipcode='"
					+ (zipCode + 1) + "' or zipcode ='" + (zipCode - 1) + "'";
			/*System.out.println(findNearQuery);*/
			result = st.executeQuery(findNearQuery);
			while (result != null && result.next()) {
				String userFound=result.getString("username");
				if(NeighbourhoodStatus.getNeighboursStatus(username, userFound).equals(NeighbourhoodStatus.NOT_NEIGHBOURS))
				{
					User user=UserInfo.getUserInfoByUsername(userFound);
					recommendationList.add(user);
					
				}
				
			}


		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDataStore.closeConn(conn);
		}

		/*System.out.println(recommendationList);*/

		return (ArrayList<User>) recommendationList;
	}

	// Return the updated list by checking if the person is already in neighbour
	// table with the session username
	// check if the username in the map exist in the neighbour table with
	// session set username
	public static Map<String, String> updateRecommendationList(
			Map<String, String> recommendationListParameter, String username) {
		Map<String, String> updatedList = new HashMap<String, String>();
		/*System.out.println("In RecommendationList.updateRecommendation");*/
		String status = null;
		try {

			Iterator iterUpdatedList = recommendationListParameter.entrySet()
					.iterator();
			while (iterUpdatedList.hasNext()) {
				Map.Entry<String, String> userInfo = (Map.Entry<String, String>) iterUpdatedList
						.next();
				status = NeighbourhoodStatus.getNeighboursStatus(userInfo
						.getKey().toString(), username);
				if (!status.equals(NeighbourhoodStatus.REQUEST_FOR_NEIGHBOURS)
						&& !status.equals(NeighbourhoodStatus.NEIGHBOURS)) {

					updatedList.put(userInfo.getKey().toString(), userInfo
							.getValue().toString());
				}

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDataStore.closeConn(conn);
		}

		return (HashMap<String, String>) updatedList;
	}

}
