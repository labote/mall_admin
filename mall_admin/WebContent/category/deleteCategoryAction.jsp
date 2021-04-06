<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	//레벨이 1보다 작으면 권한이 없으므로 adminIndex 페이지로 돌아간다.
	Manager manager = (Manager) session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	// 1. 수집코드
	String categoryName = request.getParameter("categoryName");
	System.out.println(categoryName); // 카테고리 이름 잘 받아오는지 디버깅
	
 	// 2. 삭제 메서드 호출
	CategoryDao.deleteCategory(categoryName);
	response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
%>