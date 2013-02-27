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
				Object ds = envCtx.lookup("tiancai");
				if(ds==null){
					return null;
				}
				connection = ((DataSource)ds).getConnection();
			} catch (Exception e) {
			}
		}
		return connection;
	}

	public static int updateData(String sql){
		int result=-1;
		try {
			Connection conn=getConnect();
			if(conn==null){
				return result;
			}
			PreparedStatement pst = conn.prepareStatement(sql);
			result= pst.executeUpdate();
			pst.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public static ResultSet getData(String sql){
		try {
			Connection conn=getConnect();
			if(conn==null){
				return null;
			}
			PreparedStatement pst = conn.prepareStatement(sql);
			return pst.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
}
