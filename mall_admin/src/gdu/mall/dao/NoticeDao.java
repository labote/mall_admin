package gdu.mall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import gdu.mall.util.DBUtil;
import gdu.mall.vo.Notice;

public class NoticeDao {
	
	// 수정 메서드
	public static void updateNoticeOne(Notice notice) throws Exception {
		// 1. SQL문
		String sql = "UPDATE notice SET notice_title = ?, notice_content = ?, notice_date = ?, manager_id = ? WHERE notice_no = ?";
		
		// 2. DB 연결 및 SQL 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setString(3, notice.getNoticeDate());
		stmt.setString(4, notice.getManagerId());
		stmt.setInt(5, notice.getNoticeNo());
		
		stmt.executeUpdate();
	}
	
	// 입력 메서드
	public static void insertNotice(Notice notice) throws Exception {
		// 1. SQL문
		String sql = "INSERT INTO notice(notice_title, notice_content, notice_date, manager_id) VALUES (?, ?, NOW(), ?)";
		
		// 2. DB 연결 및 SQL 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setString(3, notice.getManagerId());
		
		stmt.executeUpdate();
	}
	
	// noticeOne select 메서드
	public static Notice selectNoticeOne(int noticeNo) throws Exception {
		// 1. SQL문 생성
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, date_format(notice_date, '%Y-%m-%d') noticeDate, manager_id managerId FROM notice where notice_no = ?";
		
		// 2. 객체 생성
		Notice notice = null;
		
		// 3. DB 연결 및 SQL 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt + "<-- stmt 디버깅"); // sql문 디버깅
		stmt.setInt(1, noticeNo);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			notice = new Notice();
			notice.setNoticeNo(rs.getInt("noticeNo"));
			notice.setNoticeTitle(rs.getString("noticeTitle"));
			notice.setNoticeContent(rs.getString("noticeContent"));
			notice.setNoticeDate(rs.getString("noticeDate"));
			notice.setManagerId(rs.getString("managerId"));
		}
		
		return notice;
	}
	
	// 리스트 메서드
	public static ArrayList<Notice> selectNoticeListByPage(int rowPerPage, int beginRow, String searchNotice) throws Exception {
		
		// 객체 선언, DB연결, sql문 선언
		ArrayList<Notice> list = new ArrayList<>();
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		
		String sql = ""; 
				
		if(searchNotice.equals("")) { // 검색어가 없으면
			sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, date_format(notice_date,'%Y-%m-%d') noticeDate, manager_id managerId from notice limit ?, ?"; 
			stmt = conn.prepareStatement(sql); 
			stmt.setInt(1, beginRow); 
			stmt.setInt(2,rowPerPage);
			 
		} else {
			sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, date_format(notice_date,'%Y-%m-%d') noticeDate, manager_id managerId from notice where notice_title like ? limit ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchNotice+"%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
		}
		System.out.println(stmt + "<-- List sql 디버깅"); // 디버깅
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeTitle(rs.getString("noticeTitle"));
			n.setNoticeContent(rs.getString("noticeContent"));
			n.setNoticeDate(rs.getString("noticeDate"));
			n.setManagerId(rs.getString("managerId"));
			list.add(n);
		}
		
		return list;
	}
	
	// 전체 행의 개수 메서드
	public static int totalCount(String searchTitle) throws Exception {
		
		// 객체 선언, DB연결, sql문 선언
		String sql = "";
		int rowCnt = 0;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		
		if(searchTitle.equals("")) {
			sql = "SELECT count(*) from notice";
			stmt = conn.prepareStatement(sql);
		} else {
			sql = "SELECT count(*) from notice where notice_title = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, searchTitle);
		}
		
		System.out.println(stmt + "<-- List sql 디버깅"); // 디버깅
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			rowCnt = rs.getInt("count(*)");
		}
		
		return rowCnt;
	}
	
	// delete 메서드
	public static void deleteNotice(int noticeNo) throws Exception {
		// 1. SQL문
		String sql = "delete from notice where notice_no = ?";
		
		// 2. DB 연결 및 SQL 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt + "<-- List sql 디버깅"); // 디버깅
		stmt.setInt(1, noticeNo);
		stmt.executeUpdate();
	}
}
