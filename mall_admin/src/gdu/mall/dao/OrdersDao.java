package gdu.mall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import gdu.mall.util.DBUtil;
import gdu.mall.vo.Client;
import gdu.mall.vo.Ebook;
import gdu.mall.vo.Orders;
import gdu.mall.vo.OrdersAndEbookAndClient;

public class OrdersDao {
	
	public static ArrayList<OrdersAndEbookAndClient> ordersList(int rowPerPage, int beginRow) throws Exception {
		// orders 리스트 X --> orders join ebook join client
		// OrdersAndEbookAndClient
		/*	
		  	SELECT
			o.orders_no ordersNo,
			o.ebook_no ebookNo,
			e.ebook_title ebookTitle,
			o.client_no clientNo,
			c.client_mail clientMail,
			o.orders_date ordersDate,
			o.orders_state ordersState
			FROM orders o INNER JOIN ebook e INNER JOIN client c
			ON o.ebook_no = e.ebook_no AND o.client_no = c.client_no
			order by o.orders_no desc
		*/
		
		// SQL문
		String sql = "SELECT o.orders_no ordersNo, o.ebook_no ebookNo, e.ebook_title ebookTitle, o.client_no clientNo, c.client_mail clientMail, o.orders_date ordersDate, o.orders_state ordersState FROM orders o INNER JOIN ebook e INNER JOIN client c ON o.ebook_no = e.ebook_no AND o.client_no = c.client_no order by o.orders_no desc limit ?, ?";
		
		// 리스트 객체 생성
		ArrayList<OrdersAndEbookAndClient> list = new ArrayList<>();
		
		// DB 연결 및 SQL 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			OrdersAndEbookAndClient oec = new OrdersAndEbookAndClient();
			
			Orders o = new Orders();
			o.setOrdersNo(rs.getInt("ordersNo"));
			o.setEbookNo(rs.getInt("ebookNo"));
			o.setClientNo(rs.getInt("clientNo"));
			o.setOrdersDate(rs.getString("ordersDate"));
			o.setOrdersState(rs.getString("ordersState"));
			oec.setOrders(o);
			
			Ebook e = new Ebook();
			e.setEbookTitle(rs.getString("ebooktitle"));
			oec.setEbook(e);
			
			
			Client c = new Client();
			c.setClientMail(rs.getString("clientMail"));
			oec.setClient(c);
			
			list.add(oec);
		}
		
		return list;
	}
	
	public static ArrayList<OrdersAndEbookAndClient> ordersList(int rowPerPage, int beginRow, int clientNo) throws Exception {
		// orders 리스트 X --> orders join ebook join client
		// OrdersAndEbookAndClient
		/*	
		  	SELECT
			o.orders_no ordersNo,
			o.ebook_no ebookNo,
			e.ebook_title ebookTitle,
			o.client_no clientNo,
			c.client_mail clientMail,
			o.orders_date ordersDate,
			o.orders_state ordersState
			FROM orders o INNER JOIN ebook e INNER JOIN client c
			ON o.ebook_no = e.ebook_no AND o.client_no = c.client_no
			order by o.orders_no desc
		*/
		
		
		// SQL문
		//String sql = "SELECT o.orders_no ordersNo, o.ebook_no ebookNo, e.ebook_title ebookTitle, o.client_no clientNo, c.client_mail clientMail, o.orders_date ordersDate, o.orders_state ordersState FROM orders o INNER JOIN ebook e INNER JOIN client c ON o.ebook_no = e.ebook_no AND o.client_no = c.client_no order by o.orders_no desc limit ?, ?";
		
		ArrayList<OrdersAndEbookAndClient> list = new ArrayList<>();
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		String sql = "";
		
		if(clientNo==0) {
			sql = "SELECT o.orders_no ordersNo, o.ebook_no ebookNo, e.ebook_title ebookTitle, o.client_no clientNo, c.client_mail clientMail, o.orders_date ordersDate, o.orders_state ordersState FROM orders o INNER JOIN ebook e INNER JOIN client c ON o.ebook_no = e.ebook_no AND o.client_no = c.client_no order by o.orders_no desc limit ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
		} else {
			sql = "SELECT o.orders_no ordersNo, o.ebook_no ebookNo, e.ebook_title ebookTitle, o.client_no clientNo, c.client_mail clientMail, o.orders_date ordersDate, o.orders_state ordersState FROM orders o INNER JOIN ebook e INNER JOIN client c ON o.ebook_no = e.ebook_no AND o.client_no = c.client_no where o.client_no = ? order by o.orders_no desc limit ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, clientNo);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
		}
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			OrdersAndEbookAndClient oec = new OrdersAndEbookAndClient();
			
			Orders o = new Orders();
			o.setOrdersNo(rs.getInt("ordersNo"));
			o.setEbookNo(rs.getInt("ebookNo"));
			o.setClientNo(rs.getInt("clientNo"));
			o.setOrdersDate(rs.getString("ordersDate"));
			o.setOrdersState(rs.getString("ordersState"));
			oec.setOrders(o);
			
			Ebook e = new Ebook();
			e.setEbookTitle(rs.getString("ebooktitle"));
			oec.setEbook(e);
			
			
			Client c = new Client();
			c.setClientMail(rs.getString("clientMail"));
			oec.setClient(c);
			
			list.add(oec);
		}
		
		return list;
	}
	
	// 총 행의 개수
	public static int totalCount(int clientNo) throws Exception {
		
		// sql문
		// select count(*) cnt from orders o INNER JOIN ebook e INNER JOIN client c ON o.ebook_no = e.ebook_no AND o.client_no = c.client_no order by o.orders_no desc
		String sql = "select count(*) cnt from orders";
		
		// 초기화
		int rowCnt = 0;
		
		// DB 연결 및 SQL 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			rowCnt = rs.getInt("cnt");
		}
		
		return rowCnt;
	}
	
	// update 메서드
	public static void updateOrdersAction(int clientNo, String ordersState) throws Exception {
		// sql문
		String sql = "UPDATE orders SET orders_state = ? WHERE client_no = ?";
		
		// DB 연결 및 SQL 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ordersState);
		stmt.setInt(2, clientNo);
		
		stmt.executeUpdate();
	}
}
