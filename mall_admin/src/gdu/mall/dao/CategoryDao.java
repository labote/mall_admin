package gdu.mall.dao;

import java.sql.*;
import java.util.ArrayList;

import gdu.mall.util.DBUtil;
import gdu.mall.vo.*;

public class CategoryDao {
	
	// 카테고리 네임 리스트 메서드
	public static ArrayList<String> categoryNameList() throws Exception {
		// 1. sql 문
		String sql = "select category_name categoryName from category order by category_weight desc";
		
		// 2. list 초기화
		ArrayList<String> list = new ArrayList<>();
		
		// 3. DB 연결 및 SQL문 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt + " <-- sql 디버깅"); // sql 디버깅
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			String cn = rs.getString("category_name");
			list.add(cn);
		}
		
		return list;
	}
	
	// 리스트 메서드
	public static ArrayList<Category> CategoryList() throws Exception {
		// 1. sql 문
		String sql = "select * from category order by category_weight desc";
		
		// 2. list 초기화
		ArrayList<Category> list = new ArrayList<>();
		
		// 3. DB 연결 및 SQL문 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Category c = new Category();
			c.setCategoryName(rs.getString("category_name"));
			c.setCategoryWeight(rs.getInt("category_weight"));
			list.add(c);
		}
		
		return list;
	}
	
	// 삭제 메서드
	public static void deleteCategory(String categoryName) throws Exception {
		// 1. sql 문
		String sql = "DELETE FROM category WHERE category_name =?";
		 
		// 2. DB 연결 및 SQL문 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		System.out.println(stmt + "<-- stmt 디버깅"); // stmt 디버깅
		stmt.executeUpdate();
	}
	 
	// 삽입 메서드
	public static void insertCategory(String categoryName, int categoryWeight) throws Exception {
		// 1. sql 문
		String sql = "INSERT INTO category(category_name, category_weight, category_date) values(?,?,now())";
		
		// 2. DB 연결 및 SQL문 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		stmt.setInt(2, categoryWeight);
		System.out.println(stmt + " <-- insert sql 디버깅"); // insert sql문 디버깅
		
		stmt.executeUpdate();
	}
	
	// 수정 메서드
	public static void updateCategory(String categoryName, int categoryWeight) throws Exception {
		// 1. sql
		String sql = "UPDATE category SET category_weight = ? WHERE category_Name = ?";
		
		// 2. DB 연결 및 SQL문 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryWeight);
		stmt.setString(2, categoryName);
		System.out.println(stmt + " <-- update sql 디버깅"); // update sql문 디버깅
		
		stmt.executeUpdate();
	}
}