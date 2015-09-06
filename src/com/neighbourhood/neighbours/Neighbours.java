package com.neighbourhood.neighbours;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.neighbourhood.post.Post;
import com.neighbourhood.status.NeighbourhoodStatus;
import com.neighbourhood.user.User;
import com.neighbourhood.user.UserInfo;
import com.neighbours.datastore.ConnectionDataStore;

public class Neighbours {

	private static Connection conn = null;

	public static List<User> getNeighboursList(String username) {
		List<User> neighboursList = new ArrayList<User>();
		List<String> checkNeighbourID = new ArrayList<String>();
		try {
			conn = ConnectionDataStore.getConn();
			String query = "select * from neighbours where username1='"
					+ username + "' and status='"
					+ NeighbourhoodStatus.NEIGHBOURS + "'";
			ResultSet rs1 = conn.createStatement().executeQuery(query);
			if (rs1 != null && !rs1.isClosed())
				while (rs1.next()) {
					String neighbourid = rs1.getString("username2");
					User user = UserInfo.getUserInfoByUsername(neighbourid);
					neighboursList.add(user);
					checkNeighbourID.add(neighbourid);
				}

			query = "select * from neighbours where username2='" + username
					+ "' and status='" + NeighbourhoodStatus.NEIGHBOURS + "'";
			if (conn.isClosed()) {
				conn = ConnectionDataStore.getConn();
			}
			ResultSet rs = conn.createStatement().executeQuery(query);
			if (rs != null && !rs.isClosed())
				while (rs.next()) {
					String neighbourid = rs.getString("username1");
					if (!checkNeighbourID.contains(neighbourid)) {
						User user = UserInfo.getUserInfoByUsername(neighbourid);
						neighboursList.add(user);
					}
				}
			rs.close();
			rs1.close();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			ConnectionDataStore.closeConn(conn);
			checkNeighbourID.clear();

		}

		return (List<User>) neighboursList;
	}

	public static String getFullName(String userid) {
		String fullname = "";
		try {
			conn = ConnectionDataStore.getConn();

			String query = "select First_name,Last_name from users where username='"
					+ userid + "'";
			ResultSet rs = conn.createStatement().executeQuery(query);
			if (rs != null && rs.next()) {
				fullname += rs.getString("First_name").toString() + " "
						+ rs.getString("Last_name").toString();
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDataStore.closeConn(conn);
		}

		return fullname;
	}

	public static String getZipcode(String userid) {
		String zipcode = "";
		try {
			conn = ConnectionDataStore.getConn();

			String query = "select ZipCode from users where username='"
					+ userid + "'";
			ResultSet rs = conn.createStatement().executeQuery(query);
			if (rs.next()) {
				zipcode = rs.getString("ZipCode");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDataStore.closeConn(conn);
		}

		return zipcode;
	}

	public static String getEmail(String userid) {
		String email = "";
		try {
			conn = ConnectionDataStore.getConn();

			String query = "select Email from users where username='" + userid
					+ "'";
			ResultSet rs = conn.createStatement().executeQuery(query);
			if (rs.next()) {
				email = rs.getString("Email");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDataStore.closeConn(conn);
		}

		return email;
	}

	public static int getNeighboursListSize(String userid) {

		List<User> list = getNeighboursList(userid);

		return list.size();
	}

	public static List<String> getUpdatesFromNeighbours(String username) {
		List<String> updatesList = new ArrayList<String>();
		try {
			conn = ConnectionDataStore.getConn();
			String query = "select * from parent_updates order by date_time desc";
			/* System.out.println(query); */
			ResultSet rs = conn.createStatement().executeQuery(query);
			while (rs.next()) {

				String user = rs.getString("username");
				String status = NeighbourhoodStatus.getNeighboursStatus(
						username, user);

				if (status.equals(NeighbourhoodStatus.NEIGHBOURS)
						&& !Neighbours.isBlocked(username, user)) {
					String post = rs.getString("post");
					int post_id = rs.getInt("post_id");
					String datetime = rs.getString("date_time");
					String[] date_time = datetime.split(" ");
					String date = date_time[0];
					String time = date_time[1];
					// Creating record with delimiter as ~
					String record = post_id + "~" + user + "~" + post + "~"
							+ date + "~" + time;
					/* System.out.println(record); */
					updatesList.add(record);

				} else {
					continue;
				}

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDataStore.closeConn(conn);
		}

		return (ArrayList<String>) updatesList;
	}

	public static List<Post> getChildList(String username, String post_id) {
		List<Post> childPost = new ArrayList<Post>();

		try {
			conn = ConnectionDataStore.getConn();
			String query = "select * from updates where parent_id='" + post_id
					+ "' order by date_time";
			/* System.out.println(query); */
			ResultSet rs = conn.createStatement().executeQuery(query);
			while (rs.next()) {
				if (!Neighbours.isBlocked(username, rs.getString("username"))) {
					Post post = new Post();
					post.setDate_time(rs.getString("date_time"));
					post.setPost(rs.getString("post"));
					post.setUsername(rs.getString("username"));
					childPost.add(post);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDataStore.closeConn(conn);

		}

		return (ArrayList<Post>) childPost;

	}

	public static boolean checkUserByEmail(String email) {
		boolean userExist = false;
		try {
			conn = ConnectionDataStore.getConn();
			String query = "select * from users where email='" + email + "'";
			/* System.out.println("In checkuserByEmail "+query); */
			ResultSet rs = conn.createStatement().executeQuery(query);
			if (rs.next()) {
				userExist = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDataStore.closeConn(conn);
		}
		return userExist;

	}

	public static boolean checkInviteSent(String email) {
		boolean inviteSent = false;
		try {
			conn = ConnectionDataStore.getConn();
			String query = "select * from invitesent where email='" + email
					+ "'";
			/* System.out.println("In checkuserByEmail "+query); */
			ResultSet rs = conn.createStatement().executeQuery(query);
			if (rs.next()) {
				inviteSent = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDataStore.closeConn(conn);
		}
		return inviteSent;

	}

	public static boolean addToInviteList(String email) {
		boolean inviteAdded = false;
		try {
			conn = ConnectionDataStore.getConn();
			String query = "insert into invitesent values('" + email + "')";
			/* System.out.println("In checkuserByEmail "+query); */
			int count = conn.createStatement().executeUpdate(query);
			if (count == 1) {
				inviteAdded = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDataStore.closeConn(conn);
		}
		return inviteAdded;

	}

	public static void deleteFromInviteList(String email) {

		try {
			if (checkInviteSent(email)) {
				conn = ConnectionDataStore.getConn();

				String query = "delete from invitesent where email='" + email
						+ "'";
				/* System.out.println("In checkuserByEmail "+query); */
				conn.createStatement().executeUpdate(query);

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDataStore.closeConn(conn);
		}

	}

	public static boolean removeNeighbours(String user1, String user2) {
		// user1= session user
		// user2 = user to which request is sent.
		/* System.out.println("In NeighbourRequest.removeNeighbourRequest"); */

		int recordsDeleted = 0;
		boolean flag = false;
		try {
			conn = ConnectionDataStore.getConn();
			String removeRequest = "delete from neighbours where (username1 ='"
					+ user1 + "' or username2 = '" + user1
					+ "') and (username1='" + user2 + "' or username2='"
					+ user2 + "')";
			System.out.println(removeRequest);

			Statement st = conn.createStatement();
			recordsDeleted = st.executeUpdate(removeRequest);

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			ConnectionDataStore.closeConn(conn);
		}

		if (recordsDeleted == 1) {
			flag = true;
		}

		return flag;

	}

	public static boolean blockUpdates(String blocked_by, String blocked_user) {

		int count = 0;
		boolean block_done = false;
		try {
			conn = ConnectionDataStore.getConn();
			String block_query = "insert into block_updates values('"
					+ blocked_by + "','" + blocked_user + "')";
			Statement st = conn.createStatement();
			count = st.executeUpdate(block_query);
			if (count == 1) {
				block_done = true;
			}
		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			ConnectionDataStore.closeConn(conn);
		}

		

		return block_done;

	}

	public static boolean unblockUpdates(String unblocked_by,
			String unblocked_user) {

		int count = 0;
		boolean unblock_done = false;
		try {
			conn = ConnectionDataStore.getConn();
			String block_query = "delete from block_updates where blocked_by = '"
					+ unblocked_by
					+ "' and blocked_user ='"
					+ unblocked_user
					+ "'";
			Statement st = conn.createStatement();
			count = st.executeUpdate(block_query);

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			ConnectionDataStore.closeConn(conn);
		}

		if (count == 1) {
			unblock_done = true;
		}

		return unblock_done;

	}

	public static boolean isBlocked(String blocked_by, String blocked_user) {

		boolean isblocked = false;

		try {
			conn = ConnectionDataStore.getConn();
			String is_block_query = "select * from block_updates where blocked_by = '"
					+ blocked_by + "' and blocked_user ='" + blocked_user + "'";
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(is_block_query);
			if (rs != null && rs.next()) {
				isblocked = true;
			}

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			ConnectionDataStore.closeConn(conn);
		}

		return isblocked;
	}

}
