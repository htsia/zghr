package com.hr319wg.custom.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class SqlUtil {
	private static Connection connection;
	
	public static Connection getConnect() {
		if(connection==null){
			try {
				Context intitCtx = new InitialContext();
				Context envCtx = (Context) intitCtx.lookup("java:comp/env");
				DataSource ds = (DataSource) envCtx.lookup("hrcaiwu");
				connection = ds.getConnection();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return connection;
	}

	public static int updateData(String sql){
		int result=-1;
		try {
			PreparedStatement pst = getConnect().prepareStatement(sql);
			result= pst.executeUpdate();
			pst.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public static ResultSet getData(String sql){
		try {
			PreparedStatement pst = getConnect().prepareStatement(sql);
			return pst.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
}
