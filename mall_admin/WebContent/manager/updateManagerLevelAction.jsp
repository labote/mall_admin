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
	request.setCharacterEncoding("UTF-8");
	int managerNo = Integer.parseInt(request.getParameter("managerNo"));
	int managerLevel = Integer.parseInt(request.getParameter("managerLevel"));
	System.out.println(managerNo + "<-- managerNo"); // 디버깅
	System.out.println(managerLevel + "<-- managerLevel"); // 디버깅
	
	// dao 수정메서드 호출
	ManagerDao.updateManagerLevel(managerNo, managerLevel);
	response.sendRedirect(request.getContextPath()+"/manager/managerList.jsp");
%>