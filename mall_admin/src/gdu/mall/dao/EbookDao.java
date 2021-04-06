package gdu.mall.dao;

import java.sql.*;
import java.util.ArrayList;

import gdu.mall.util.DBUtil;
import gdu.mall.vo.Ebook;

public class EbookDao {
	
	// 삭제 메서드
	public static void deleteEbookOne(String ebookISBN) throws Exception {
		//1. SQL문
		String sql = "delete from ebook where ebook_isbn = ?";
			
		//2. DB연결 및 SQL 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt + "<-- stmt 디버깅"); // sql문 디버깅
		stmt.setString(1, ebookISBN);
		
		stmt.executeUpdate();
	}
	
	// Summary 수정 메서드
	public static void updateEbookSummary(Ebook ebook) throws Exception {
		//1. SQL문
		String sql = "UPDATE ebook SET ebook_summary = ? where ebook_isbn = ?";
		
		//2. DB 연결 및 SQL 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt + "<-- updateEbookSummary 디버깅"); // sql문 디버깅
		stmt.setString(1, ebook.getEbookSummary());
		stmt.setString(2, ebook.getEbookISBN());
		
		stmt.executeUpdate();
	}
	
	// 이미지 수정 메서드
	public static int updateEbookImg(Ebook ebook) throws Exception {
		//1. SQL문
		String sql = "UPDATE ebook SET ebook_img = ? where ebook_isbn = ?";
		
		// 2. 초기화
		int rowCnt = 0;
			
		// 3. DB 연결 및 SQL 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt + "<-- updateEbookImg 디버깅"); // sql문 디버깅
		stmt.setString(1, ebook.getEbookImg());
		stmt.setString(2, ebook.getEbookISBN());
		rowCnt = stmt.executeUpdate();
		
		// 4. 리턴
		return rowCnt;
	}
	
	// EbookOne 메서드 함수
	public static Ebook selectEbookOne(String ebookISBN) throws Exception {
		// 1. SQL문
		String sql = "SELECT ebook_isbn, category_name, ebook_title, ebook_author, ebook_company, ebook_page_count, ebook_price, ebook_img, ebook_summary, ebook_date, ebook_state FROM ebook WHERE ebook_isbn = ?";
		
		// 2. 초기화
		Ebook ebook = null;
		
		// 3. DB 연결 및 SQL 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt + "<-- stmt 디버깅"); // sql문 디버깅
		stmt.setString(1, ebookISBN);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			ebook = new Ebook();
			ebook.setEbookISBN(rs.getString("ebook_isbn"));
			ebook.setCategoryName(rs.getString("category_name"));
			ebook.setEbookTitle(rs.getString("ebook_title"));
			ebook.setEbookAuthor(rs.getString("ebook_author"));
			ebook.setEbookCompany(rs.getString("ebook_company"));
			ebook.setEbookPageCount(rs.getInt("ebook_page_count"));
			ebook.setEbookPrice(rs.getInt("ebook_price"));
			ebook.setEbookImg(rs.getString("ebook_img"));
			ebook.setEbookSummary(rs.getString("ebook_summary"));
			ebook.setEbookDate(rs.getString("ebook_date"));
			ebook.setEbookState(rs.getString("ebook_state"));
		}
		
		// 4. 리턴
		return ebook;
	}
	
	// 입력 메서드
	public static int insertEbook(Ebook ebook) throws Exception{
		/*
		 * INSERT INTO ebook(
		 * 		ebook_isbn,
		 * 		category_name,
		 * 		ebook_title,
		 * 		ebook_author,
		 * 		ebook_company,
		 * 		ebook_page_count,
		 * 		ebook_price,
		 * 		ebook_summary,
		 * 		ebook_img,
		 * 		ebook_date,
		 * 		ebook_state
		 * ) VALUES (
		 * 		?, ?, ?, ?, ?, ?, ?, ?, 'default.jpg', NOW(), '판매중'
		 * )
		 */
		
		// 1. SQL문
		String sql = "INSERT INTO ebook(ebook_isbn, category_name, ebook_title, ebook_author, ebook_company, ebook_page_count, ebook_price, ebook_summary, ebook_img, ebook_date, ebook_state) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'default.jpg', NOW(), '판매중')";
		
		// 2. 초기화
		int rowCnt = 0;
		
		// 3. DB 연결 및 SQL 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookISBN());
		stmt.setString(2, ebook.getCategoryName());
		stmt.setString(3, ebook.getEbookTitle());
		stmt.setString(4, ebook.getEbookAuthor());
		stmt.setString(5, ebook.getEbookCompany());
		stmt.setInt(6, ebook.getEbookPageCount());
		stmt.setInt(7, ebook.getEbookPrice());
		stmt.setString(8, ebook.getEbookSummary());
		
		rowCnt = stmt.executeUpdate();
		// 4. 리턴
		return rowCnt;
	}
	
	// 총 row 개수 메서드
	public static int totalCount() throws Exception {
		// 1. SQL문, 총 개수 가져온다
		String sql = "select count(*) from ebook";
		
		// 2. 초기화
		int total = 0;
		
		// 3. DB 연결 및 SQL문 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt + " <-- stmt 디버깅"); // sql문 실행 디버깅
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			total = rs.getInt("count(*)");
		}
		
		return total;
	}
	
	// 리스트 메서드
	public static ArrayList<Ebook> selectEbookListByPage(int rowPerPage, int beginRow) throws Exception {
		// 1. SQL문
		String sql = "select category_name categoryName, ebook_isbn ebookISBN,"
				+ "ebook_title ebookTitle, ebook_author ebookAuthor, ebook_date ebookDate, ebook_price ebookPrice"
				+ " from ebook order by ebook_date desc limit ?,?";
		
		// 2. 초기화
		ArrayList<Ebook> list = new ArrayList<>();
		
		// 3. DB 연결 및 SQL문 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		System.out.println(stmt + " <-- stmt 디버깅"); // sql문 실행 디버깅
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) { // 다음 값이 있으면 Ebook 객체를 생성하여 값을 넣어준 뒤 리스트에 저장
			Ebook e = new Ebook();
			e.setCategoryName(rs.getString("categoryName"));
			e.setEbookISBN(rs.getString("ebookISBN"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookAuthor(rs.getString("ebookAuthor"));
			e.setEbookDate(rs.getString("ebookDate"));
			e.setEbookPrice(rs.getInt("ebookPrice"));
			list.add(e);
		}
		
		return list;
	}
	
	// 리스트 메서드
	public static ArrayList<Ebook> selectEbookListByPage(int rowPerPage, int beginRow, String categoryName) throws Exception {

		String sql = "";
		ArrayList<Ebook> list = new ArrayList<>();
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		
		if(categoryName.equals("")) {
			sql = "select category_name categoryName, ebook_isbn ebookISBN, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_date ebookDate, ebook_price ebookPrice from ebook order by ebook_date desc limit ?,?";
			stmt = conn.prepareStatement(sql);
			System.out.println(stmt + " <-- stmt 디버깅"); // sql문 실행 디버깅
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
		} else {
			sql = "select category_name categoryName, ebook_isbn ebookISBN, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_date ebookDate, ebook_price ebookPrice from ebook where category_name = ? order by ebook_date desc limit ?,?";
			stmt = conn.prepareStatement(sql);
			System.out.println(stmt + " <-- stmt 디버깅"); // sql문 실행 디버깅
			stmt.setString(1, categoryName);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
		}

		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) { // 다음 값이 있으면 Ebook 객체를 생성하여 값을 넣어준 뒤 리스트에 저장
			Ebook e = new Ebook();
			e.setCategoryName(rs.getString("categoryName"));
			e.setEbookISBN(rs.getString("ebookISBN"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookAuthor(rs.getString("ebookAuthor"));
			e.setEbookDate(rs.getString("ebookDate"));
			e.setEbookPrice(rs.getInt("ebookPrice"));
			list.add(e);
		}
		
		return list;
	}
	
	// ISBN 중복 체크 하기 위해 ISBN 받아오는 메서드
	public static String selectEbookISBN(String ebookISBN) throws Exception {
		// 1. SQL 문
		String sql = "select ebook_isbn from ebook where ebook_isbn = ?";
		
		// 2. 초기화
		String returnEbookISBN = "";
		
		// 3. DB 연결 및 SQL문 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebookISBN);
		System.out.println(stmt + " <-- stmt 디버깅"); // sql문 실행 디버깅
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			returnEbookISBN = rs.getString("ebook_isbn");
		}
		return returnEbookISBN;
	}
	
	// 상태 업데이트 메서드
	public static void updateEbookState(Ebook ebook) throws Exception {
		// 1. SQL문 생성
		String sql = "UPDATE ebook SET ebook_state = ? where ebook_isbn = ?";
		
		// 2. DB 연결 및 SQL 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt + "<-- updateEbookImg 디버깅"); // sql문 디버깅
		stmt.setString(1, ebook.getEbookState());
		stmt.setString(2, ebook.getEbookISBN());
		
		stmt.executeUpdate();
	}
	
	// bookOne 업데이트 메서드
	public static void updateEbookOne(Ebook ebook) throws Exception {
		// 1. SQL문 생성
		String sql = "UPDATE ebook SET category_Name = ?, ebook_title = ?, ebook_author = ?, ebook_company = ?, ebook_page_count = ?, ebook_price = ? where ebook_isbn = ?";
		
		// 2. DB 연결 및 SQL 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt + "<-- updateEbookImg 디버깅"); // sql문 디버깅
		stmt.setString(1, ebook.getCategoryName());
		stmt.setString(2, ebook.getEbookTitle());
		stmt.setString(3, ebook.getEbookAuthor());
		stmt.setString(4, ebook.getEbookCompany());
		stmt.setInt(5, ebook.getEbookPageCount());
		stmt.setInt(6, ebook.getEbookPrice());
		stmt.setString(7, ebook.getEbookISBN());
		
		stmt.executeUpdate();
	}
}
