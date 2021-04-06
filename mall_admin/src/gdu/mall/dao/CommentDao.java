package gdu.mall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import gdu.mall.util.DBUtil;
import gdu.mall.vo.Comment;

public class CommentDao {
	
	public static int selectCommentCnt(int noticeNo) throws Exception {
		
		// SQL 문
		String sql = "select count(*) cnt from comment where notice_no = ?";
		
		int rowCnt = 0;

		// DB 연결 및 SQL 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt + "<-- selectCommentCnt 디버깅"); // 디버깅
		stmt.setInt(1, noticeNo);
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			rowCnt = rs.getInt("cnt");
		}
		System.out.println(rowCnt);
		
		return rowCnt;
	}
	
	public static int insertComment(Comment comment) throws Exception {
		
		// SQL문
		String sql = "INSERT INTO comment(comment_content, comment_date, manager_id, comment_no, notice_no) VALUES (?,now(),?,?,?)";
		
		// 선언 및 초기화
		int rowCnt = 0;
		
		// 2. DB 연결 및 SQL 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt + "<-- insert sql 디버깅"); // 디버깅
		stmt.setString(1, comment.getCommentContent());
		stmt.setString(2, comment.getManagerId());
		stmt.setInt(3, comment.getCommentNo());
		stmt.setInt(4, comment.getNoticeNo());
		
		rowCnt = stmt.executeUpdate();;
		
		// 리턴
		return rowCnt;
	}
	
	public static ArrayList<Comment> selectCommentListByNoticeNo(int noticeNo) throws Exception {
		
		// select * from comment where notice_no = ?
		String sql = "select * from comment where notice_no = ?";
		
		// 선언 및 초기화
		ArrayList<Comment> list = new ArrayList<Comment>();
		
		// DB 연결 및 SQL 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt + "<-- sql 디버깅"); // 디버깅
		stmt.setInt(1, noticeNo);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Comment c = new Comment();
			c.setCommentContent(rs.getString("comment_content"));
			c.setCommentDate(rs.getString("comment_date"));
			c.setManagerId(rs.getString("manager_id"));
			c.setCommentNo(rs.getInt("comment_no"));
			c.setNoticeNo(rs.getInt("notice_no"));
			list.add(c);
		}
		
		// 리턴
		return list;
	}
	
	// deleteComment 메서드 오버로딩
	public static void deleteComment(int CommentNo) throws Exception {
		
		// sql 문, delete from comment where commentNo = ?
		String sql = "delete from comment where comment_no = ?";
		
		// 2. DB 연결 및 SQL 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt + "<-- delete sql 디버깅"); // 디버깅
		stmt.setInt(1, CommentNo);
		stmt.executeUpdate();
		
	}
	
	public static void deleteComment(int CommentNo, String managerId) throws Exception { // commentNo, managerId 두 개를 사용
		
		// sql 문, delete from comment where commentNo = ? and managerId = ?
		String sql = "delete from comment where commentNo = ? and managerId = ?";
		
		// 2. DB 연결 및 SQL 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt + "<-- delete sql 디버깅"); // 디버깅
		stmt.setInt(1, CommentNo);
		stmt.setString(2, managerId);
		stmt.executeUpdate();
	}
}
