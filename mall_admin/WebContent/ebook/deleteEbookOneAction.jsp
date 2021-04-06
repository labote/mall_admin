<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
 	// 레벨이 1보다 작으면 권한이 없으므로 adminIndex 페이지로 돌아간다.
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager==null){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if(manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} 
	
	// 1. 수집 코드
	String ebookISBN = request.getParameter("ebookISBN");
	int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	System.out.println(ebookISBN);
	
	// 2. Dao에서 삭제 메서드 호출
	EbookDao.deleteEbookOne(ebookISBN);
	response.sendRedirect(request.getContextPath()+"/ebook/ebookList.jsp"+"?rowPerPage="+rowPerPage);
%>