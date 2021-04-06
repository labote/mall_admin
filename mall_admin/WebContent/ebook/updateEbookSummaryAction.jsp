<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%
	//레벨이 1보다 작으면 권한이 없으므로 adminIndex 페이지로 돌아간다.
	Manager manager = (Manager) session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>

<%
	request.setCharacterEncoding("UTF-8");

	// 1. 수집 코드
	String ebookISBN = request.getParameter("ebookISBN");
	String ebookSummary = request.getParameter("ebookSummary");
	int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	
	// 디버깅
	System.out.println("ebookISBN : " + ebookISBN);
	System.out.println("ebookSummary : " +ebookSummary);
	System.out.println("rowPerPage : " +rowPerPage);
	
	// 2-2. 전처리
	Ebook ebook = new Ebook(); // 객체 선언
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookSummary(ebookSummary);
	
	// 2. Dao에서 update 메서드 호출
 	EbookDao.updateEbookSummary(ebook);
 	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN="+ebookISBN+"&rowPerPage="+rowPerPage);
%>