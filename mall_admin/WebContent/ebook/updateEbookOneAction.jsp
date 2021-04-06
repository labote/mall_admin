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
	String categoryName = request.getParameter("categoryName");
	String ebookTitle = request.getParameter("ebookTitle");
	String ebookAuthor = request.getParameter("ebookAuthor");
	String ebookCompany = request.getParameter("ebookCompany");
	int ebookPageCount = Integer.parseInt(request.getParameter("ebookPageCount"));
	int ebookPrice = Integer.parseInt(request.getParameter("ebookPrice"));
	int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	
	// 받아온 값 디버깅
	System.out.println("ebookISBN : " + ebookISBN); 
	System.out.println("categoryName : " + categoryName);
	System.out.println("ebookTitle : " + ebookTitle); 
	System.out.println("ebookAuthor : " + ebookAuthor);
	System.out.println("ebookCompany : " + ebookCompany); 
	System.out.println("ebookPageCount : " + ebookPageCount); 
	System.out.println("ebookPrice : " + ebookPrice); 
	System.out.println("rowPerPage : " + rowPerPage);
	
/*  	//중복된 ISBN이 있는지 확인해서 중복되어 있다면 다시 원래 사이트 요청
	String returnEbookISBN = EbookDao.selectEbookISBN(ebookISBN);
	System.out.println(returnEbookISBN + " <-- returnEbookISBN");
	if(returnEbookISBN != "") { // ISBN이 존재한다면
		System.out.println("사용중인 ISBN 입니다");
		response.sendRedirect(request.getContextPath()+"/ebook/insertEbookForm.jsp");
		return;
	}
	 */
	 
	// Ebook 객체 생성 및 전처리
	Ebook ebook = new Ebook();
	ebook.setEbookISBN(ebookISBN);
	ebook.setCategoryName(categoryName);
	ebook.setEbookTitle(ebookTitle);
	ebook.setEbookAuthor(ebookAuthor);
	ebook.setEbookCompany(ebookCompany);
	ebook.setEbookPageCount(ebookPageCount);
	ebook.setEbookPrice(ebookPrice);
	
	// 2. Dao에서 수정 메서드 호출
	EbookDao.updateEbookOne(ebook);
	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN="+ebookISBN+"&rowPerPage="+rowPerPage);
%>