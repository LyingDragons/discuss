package com.forum.utils;

import java.sql.Connection;
import java.sql.SQLException;

import javax.sql.DataSource;

import com.mchange.v2.c3p0.ComboPooledDataSource;

public class C3P0Utils {
	private static DataSource  dataSource=null;
	
	public static Connection getConnection() {
		 dataSource =new ComboPooledDataSource();
		Connection coon = null;
		try {
			 coon=dataSource.getConnection();
			System.out.println(coon);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return coon;
		
	}
	
	public static DataSource getDataSource() {
		 dataSource =new ComboPooledDataSource();
		return dataSource;
	}
	public static void main(String[] args) {
		C3P0Utils.getConnection();
		C3P0Utils.getDataSource();
	}
	
	
	
	
	
	
	
	
}
