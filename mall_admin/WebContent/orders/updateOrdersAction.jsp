<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");

 	// 레벨이 2보다 작으면 권한이 없으므로 adminIndex 페이지로 돌아간다.
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager==null){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if(manager.getManagerLevel() < 2){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	// 수집코드
	int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	int clientNo = Integer.parseInt(request.getParameter("clientNo"));
	String ordersState = request.getParameter("ordersState");
	
	// 디버깅
	System.out.println("rowPerPage : " + rowPerPage);
	System.out.println("clientNo : " + clientNo);
	System.out.println("ordersState : " + ordersState);
	
	// Dao에서 update 함수 호출
	OrdersDao.updateOrdersAction(clientNo, ordersState);
	response.sendRedirect(request.getContextPath()+"/orders/ordersList.jsp?rowPerPage="+rowPerPage);
%>