package com.neighbours.datastore;

import java.sql.*;

public class ConnectionDataStore {

	public static Connection getConn() {
		Connection conn = getConnection();
		return conn;
	}

	private static Connection getConnection() {

		Connection conn = null;
		String url = "jdbc:mysql://localhost:3306/";
		String dbName = "neighbours";
		String driver = "com.mysql.jdbc.Driver";
		String userName = "root";
		String password = "ankur";
		try {
			Class.forName(driver).newInstance();
			if(conn==null)
			{
				conn = DriverManager
						.getConnection(url + dbName, userName, password);

			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}

	public static void closeConn(Connection conn) {
		if (conn == null) {
			/*System.out.println("Null Connection object");*/
		} else {
			closeConnection(conn);
		}
	}

	private static void closeConnection(Connection conn) {
		try {
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();

		}
	}
}