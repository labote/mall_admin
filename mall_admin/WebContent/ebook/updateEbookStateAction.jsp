<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%
 	// 관리자 인증 코드
	//레벨이 1보다 작으면 권한이 없으므로 adminIndex 페이지로 돌아간다.
	Manager manager = (Manager) session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} 
	// 1. 수집코드
	request.setCharacterEncoding("UTF-8");
	
	String ebookISBN = request.getParameter("ebookISBN");
	String ebookState = request.getParameter("ebookState");
	int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	
	// 받아온 값 디버깅
	System.out.println(ebookISBN); 
	System.out.println(ebookState);
	System.out.println("rowPerPage : " +rowPerPage);
	
	// Ebook 객체 생성 및 전처리
	Ebook ebook = new Ebook();
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookState(ebookState);
	
	// 2. Dao에서 수정 메서드 호출
	EbookDao.updateEbookState(ebook);
	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN="+ebookISBN+"&rowPerPage="+rowPerPage);
%>