package gdu.mall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import gdu.mall.util.DBUtil;
import gdu.mall.vo.Manager;

public class ManagerDao {
	
	// 승인 대기중인 매니저 목록
	public static ArrayList<Manager> selectManagerListByZero() throws Exception {
		// 1. sql
		String sql = "SELECT manager_id managerId, manager_date managerDate from manager where manager_level = 0";

		// 2. 객체 생성
		ArrayList<Manager> list = new ArrayList<>();

		// 3. 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();

		// 4. 리턴
		while (rs.next()) {
			Manager m = new Manager();
			m.setManagerId(rs.getString("managerId"));
			m.setManagerDate(rs.getString("managerDate"));
			list.add(m);
		}

		return list;
	}
	
	// 전체 행의 수
	public static int totalCount() throws Exception {
			
		// 1. sql문 - 클라이언트 테이블에서 전체 데이터 개수를 가져온다.
		String sql = "select count(*) from manager";
		
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
	public static int totalCount(String searchId) throws Exception {
			
		String sql = "";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		int totalRow = 0;
		
		if(searchId.equals("")) {
			sql = "select count(*) from manager";
			stmt = conn.prepareStatement(sql);
			System.out.println(stmt + " <--login() sql"); // stmt 디버깅
		} else {
			sql = "select count(*) from manager where manager_id = ?";
			stmt = conn.prepareStatement(sql);
			System.out.println(stmt + " <--login() sql"); // stmt 디버깅
			stmt.setString(1, searchId);
		}
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) { // 데이터 값이 존재한다면 총 개수를 입력해준다.
			totalRow = rs.getInt("count(*)");
		}
		
		// 4. 리턴
		return totalRow; // 총 데이터 개수 반환
	}
	
	// 수정 메서드
	public static int updateManagerLevel(int managerNo, int managerLevel) throws Exception {
		// 1. sql
		String sql = "UPDATE manager SET manager_level= ? WHERE manager_no = ?";
		 
		// 2. 초기화
		int rowCnt = 0;
		 
		// 3. 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, managerLevel);
		stmt.setInt(2, managerNo);
		System.out.println(stmt + " <--login() sql"); // 디버깅
		
		rowCnt = stmt.executeUpdate();
		
		// 4. 리턴
		return rowCnt;
	}

	// 삭제 메서드
	public static int deleteManager(int managerNo) throws Exception {
		// 1. sql
		String sql = "DELETE FROM manager where manager_no = ?";

		// 2. 초기화
		int rowCnt = 0;

		// 3. 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, managerNo);
		System.out.println(stmt + " <--login() sql"); // 디버깅
		
		rowCnt = stmt.executeUpdate();
		
		// 4. 리턴
		return rowCnt;
	}

	// 목록 메서드
	public static ArrayList<Manager> selectManagerList() throws Exception {
		// 1. sql
		String sql = "SELECT manager_no managerNo, manager_id managerId, manager_name managerName, manager_date managerDate, manager_level managerLevel from manager order by manager_level desc, manager_date asc";

		// 2. 객체 생성
		ArrayList<Manager> list = new ArrayList<>();

		// 3. 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();

		// 4. 리턴
		while (rs.next()) {
			Manager m = new Manager();
			m.setManagerNo(rs.getInt("managerNo"));
			m.setManagerId(rs.getString("managerId"));
			m.setManagerName(rs.getString("managerName"));
			m.setManagerDate(rs.getString("managerDate"));
			m.setManagerLevel(rs.getInt("managerLevel"));
			list.add(m);
		}

		return list;
	}
	
	// 목록 메서드
	public static ArrayList<Manager> selectManagerListByPage(int rowPerPage, int beginRow) throws Exception {
		// 1. sql
		String sql = "SELECT manager_no managerNo, manager_id managerId, manager_name managerName, manager_date managerDate, manager_level managerLevel from manager order by manager_level desc, manager_date asc limit ?,?";

		// 2. 객체 생성
		ArrayList<Manager> list = new ArrayList<>();

		// 3. 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt + "<-- stmt 디버깅"); // sql문 실행 디버깅
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();

		// 4. 리턴
		while (rs.next()) {
			Manager m = new Manager();
			m.setManagerNo(rs.getInt("managerNo"));
			m.setManagerId(rs.getString("managerId"));
			m.setManagerName(rs.getString("managerName"));
			m.setManagerDate(rs.getString("managerDate"));
			m.setManagerLevel(rs.getInt("managerLevel"));
			list.add(m);
		}

		return list;
	}
	
	// 목록 메서드
	public static ArrayList<Manager> selectManagerListByPage(int rowPerPage, int beginRow, String searchId) throws Exception {

		ArrayList<Manager> list = new ArrayList<>();
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		String sql = "";
		
		if(searchId.equals("")) {
			sql = "SELECT manager_no managerNo, manager_id managerId, manager_name managerName, manager_date managerDate, manager_level managerLevel from manager order by manager_level desc, manager_date desc limit ?,?";
			stmt = conn.prepareStatement(sql);
			System.out.println(stmt + "<-- stmt 디버깅"); // sql문 실행 디버깅
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
		} else {
			sql = "SELECT manager_no managerNo, manager_id managerId, manager_name managerName, manager_date managerDate, manager_level managerLevel from manager where manager_id = ? order by manager_level desc, manager_date desc limit ?,?";
			stmt = conn.prepareStatement(sql);
			System.out.println(stmt + "<-- stmt 디버깅"); // sql문 실행 디버깅
			stmt.setString(1, searchId);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
		}
			ResultSet rs = stmt.executeQuery();
			
			while (rs.next()) {
			Manager m = new Manager();
			m.setManagerNo(rs.getInt("managerNo"));
			m.setManagerId(rs.getString("managerId"));
			m.setManagerName(rs.getString("managerName"));
			m.setManagerDate(rs.getString("managerDate"));
			m.setManagerLevel(rs.getInt("managerLevel"));
			list.add(m);
		}

		return list;
	}

	// 입력 메서드
	public static int insertManager(String managerId, String managerPw, String managerName) throws Exception {
		// 1. sql
		String sql = "INSERT INTO manager(manager_id, manager_pw, manager_name, manager_date, manager_level) values(?,?,?,now(),0)";

		// 2. 초기화
		int rowCnt = 0; // 입력 성공시 1, 실패 0

		// 3. 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		stmt.setString(2, managerPw);
		stmt.setString(3, managerName);
		System.out.println(stmt + " <--login() sql"); // 디버깅
		
		rowCnt = stmt.executeUpdate();

		// 4. 리턴
		return rowCnt;
	}

	// id 사용가능여부
	public static String selectManagerId(String managerId) throws Exception {
		// 1. sql문
		String sql = "SELECT manager_id FROM manager WHERE manager_id = ?";
		
		// 2. 리턴타입 초기화
		String returnManagerId = null;

		// 3. DB 처리
		Connection conn = DBUtil.getConnection();

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		System.out.println(stmt + " <--login() sql"); // 디버깅
		
		ResultSet rs = stmt.executeQuery();
		
		if (rs.next()) {
			returnManagerId = rs.getString("manager_id");
		}
		return returnManagerId;
	}

	// 로그인 메서드
	public static Manager login(String managerId, String managerPw) throws Exception {
		String sql = "SELECT manager_id, manager_name, manager_level FROM manager WHERE manager_id=? AND manager_pw=? AND manager_level>0";
		Manager manager = null;

		Connection conn = DBUtil.getConnection(); // DB 처리

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		stmt.setString(2, managerPw);
		System.out.println(stmt + " <--login() sql"); // 디버깅
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			manager = new Manager();
			manager.setManagerId(rs.getString("manager_id"));
			manager.setManagerName(rs.getString("manager_name"));
			manager.setManagerLevel(rs.getInt("manager_level"));
		}
		return manager;
	}
	
	// 카테고리 네임 리스트 메서드
	public static ArrayList<String> managerIdList() throws Exception {
		// 1. sql 문
		String sql = "select manager_id managerId from manager order by manager_level desc";
		
		// 2. list 객체 생성
		ArrayList<String> list = new ArrayList<>();
		
		// 3. DB 연결 및 SQL문 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt + " <-- sql 디버깅"); // sql 디버깅
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			String cn = rs.getString("managerId");
			list.add(cn);
		}
		
		return list;
	}
}