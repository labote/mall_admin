<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
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
	
	// 수집 코드 구현
	int clientNo = Integer.parseInt(request.getParameter("clientNo"));
	String clientPw = request.getParameter("clientPw");
	System.out.println(clientNo + "<-- clientNo");
	System.out.println(clientPw + "<-- clientPw");
	
	// dao 수정메서드 호출
	ClientDao.updateClientPw(clientNo, clientPw);

	response.sendRedirect(request.getContextPath()+"/client/clientList.jsp");
%>