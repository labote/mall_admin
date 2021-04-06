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
	
	String categoryName = request.getParameter("categoryName");
	String ebookISBN = request.getParameter("ebookISBN");
	String ebookTitle = request.getParameter("ebookTitle");
	String ebookAuthor = request.getParameter("ebookAuthor");
	String ebookCompany = request.getParameter("ebookCompany");
	int ebookPageCount = Integer.parseInt(request.getParameter("ebookPageCount"));
	int ebookPrice = Integer.parseInt(request.getParameter("ebookPrice"));
	String ebookSummary = request.getParameter("ebookSummary");
	int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	
	// 1-2. 받아오는 값 디버깅
	System.out.println("categoryName : " + categoryName);
	System.out.println("ebookISBN : " + ebookISBN);
	System.out.println("ebookTitle : " + ebookTitle);
	System.out.println("ebookAuthor : " + ebookAuthor);
	System.out.println("ebookCompany : " + ebookCompany);
	System.out.println("ebookPageCount : " + ebookPageCount);
	System.out.println("ebookPrice : " + ebookPrice);
	System.out.println("ebookSummary : " + ebookSummary);
	System.out.println("rowPerPage : " + rowPerPage);
	
	// 2-1. 중복된 ISBN이 있는지 확인해서 중복되어 있다면 다시 원래 사이트 요청
	String returnEbookISBN = EbookDao.selectEbookISBN(ebookISBN);
	System.out.println(returnEbookISBN + " <-- returnEbookISBN");
	if(returnEbookISBN != "") { // ISBN이 존재한다면
		System.out.println("사용중인 ISBN 입니다");
		response.sendRedirect(request.getContextPath()+"/ebook/insertEbookForm.jsp");
		return;
	}
	
	// 2-2. 전처리
	Ebook ebook = new Ebook(); // 객체 선언
	ebook.setCategoryName(categoryName);
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookTitle(ebookTitle);
	ebook.setEbookAuthor(ebookAuthor);
	ebook.setEbookCompany(ebookCompany);
	ebook.setEbookPageCount(ebookPageCount);
	ebook.setEbookPrice(ebookPrice);
	ebook.setEbookSummary(ebookSummary);
	
	// 3. Dao에서 insert 메서드 호출
	EbookDao.insertEbook(ebook);
	response.sendRedirect(request.getContextPath()+"/ebook/ebookList.jsp?rowPerPage="+rowPerPage);
%>