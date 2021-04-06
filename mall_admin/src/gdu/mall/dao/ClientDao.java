package gdu.mall.dao;
import java.sql.*;
import java.util.ArrayList;

import gdu.mall.util.DBUtil;
import gdu.mall.vo.Client;

public class ClientDao {
	
	// 전체 행의 수
	public static int totalCount() throws Exception {
		
		// 1. sql문 - 클라이언트 테이블에서 전체 데이터 개수를 가져온다.
		String sql = "select count(*) from client";
		
		// 2. 초기화
		int totalRow = 0;
		
		// 3. 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt + " <--login() sql"); // stmt 디버깅
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) { // 데이터 값이 존재한다면 총 개수를 입력해준다.
			totalRow = rs.getInt("count(*)");
		}
		
		// 4. 리턴
		return totalRow; // 총 데이터 개수 반환
	}
	
	// 전체 행의 수
	public static int totalCount(String searchWord) throws Exception {
		
	    int totalRow = 0;
	      
	    Connection conn = DBUtil.getConnection();
	    PreparedStatement stmt = null;      
	    String sql ="";
	    
	    if(searchWord.equals("")) {
	    	sql = "SELECT COUNT(*) FROM client";;
	    	stmt = conn.prepareStatement(sql);
	    } else {
	        sql = "SELECT COUNT(*) FROM client WHERE client_mail LIKE ?";
	        stmt = conn.prepareStatement(sql);
	        stmt.setString(1, "%"+searchWord+"%");
	    }

	    System.out.println(stmt + " <--login() sql"); // stmt 디버깅
	    ResultSet rs = stmt.executeQuery();
	      
	    while(rs.next()) { // 데이터 값이 존재한다면 총 개수를 입력해준다.
	        totalRow = rs.getInt("count(*)");
	    }
	     
	    return totalRow; // 총 데이터 개수 반환
	}
	
	// 목록 메서드
	public static ArrayList<Client> selectClientListByPage(int rowPerPage, int beginRow) throws Exception {
		// 1. sql
		/*
		 * SELECT client_mail clientMail, client_date clientDate
		 * FROM client
		 * ORDER BY client_date DESC
		 * LIMIT ?, ?
		 */
		// beginRow(시작)에서 rowPerPage만큼 client_mail과 client_date를 가져오는 SQL문.
		String sql = "select client_mail clientMail, date_format(client_date,'%Y-%m-%d') clientDate from client order by client_date desc limit ?, ?";
		
		// 2. 초기화
		ArrayList<Client> list = new ArrayList<>();
		
		// 3. DB 연결 및 sql문 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		// 4. return
		while(rs.next()) { // 다음 값이 존재한다면 계속해서  
			Client c = new Client();
			/* c.clientNo = rs.getInt(""); */
			/* c.clientPw = rs.getString(""); */
			c.setClientMail(rs.getString("clientMail"));
			c.setClientDate(rs.getString("clientDate"));
			list.add(c);
		}
		return list;
	}

	public static ArrayList<Client> selectClientListByPage(int rowPerPage, int beginRow, String searchWord) throws Exception {
	
		ArrayList<Client> list = new ArrayList<>();
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		String sql = "";
		
		if(searchWord.equals("")) { // 검색어가 없으면
			sql = "select client_no clientNo, client_mail clientMail, date_format(client_date,'%Y-%m-%d') clientDate from client order by client_date desc limit ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
		} else {
			sql = "select client_no clientNo, client_mail clientMail, date_format(client_date,'%Y-%m-%d') clientDate from client where client_mail like ? order by client_date desc limit ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
		}

		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) { // 다음 값이 존재한다면 계속해서  
			Client c = new Client();
			/* c.clientNo = rs.getInt(""); */
			/* c.clientPw = rs.getString(""); */
			c.setClientNo(rs.getInt("clientNo"));
			c.setClientMail(rs.getString("clientMail"));
			c.setClientDate(rs.getString("clientDate"));
			list.add(c);
		}
		return list;
	}
	
	// 삭제 메서드
	public static int deleteClient(int clientNo) throws Exception {
		// 1. sql
		String sql = "DELETE FROM client where client_no = ?";

		// 2. 초기화
		int rowCnt = 0;

		// 3. 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, clientNo);
		System.out.println(stmt + " <--login() sql"); // stmt 디버깅
		
		rowCnt = stmt.executeUpdate();
		
		// 4. 리턴
		return rowCnt;
	}
	
	// 수정 메서드
	 public static int updateClientPw(int clientNo, String clientPw) throws Exception {
		 // 1. sql
		 String sql = "UPDATE client SET client_pw= password(?) WHERE client_no = ?";
		 
		 // 2. 초기화
		 int rowCnt = 0;
		 
		 // 3. 처리
		 Connection conn = DBUtil.getConnection();
		 PreparedStatement stmt = conn.prepareStatement(sql);
		 stmt.setString(1, clientPw);
		 stmt.setInt(2, clientNo);
		 System.out.println(stmt + " <--login() sql"); // 디버깅
		 
		 rowCnt = stmt.executeUpdate();
		 
		 // 4. 리턴
		 return rowCnt;
	 }
}
