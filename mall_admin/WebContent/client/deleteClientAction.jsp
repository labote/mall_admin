<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
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
	System.out.println(clientNo + "<-- clientNo");
	
	// dao 삭제메서드 호출
	ClientDao.deleteClient(clientNo);
	response.sendRedirect(request.getContextPath()+"/client/clientList.jsp");
%>