<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<!-- 파일을 넘기면 많은일들이 발생하는데 cos.jar을 이용해 그 일들을 간단하게 만들어준다. -->
<!-- DefaultFileRenamePolicy, 중복되는 파일을 알아서 잘 구별해준다. -->
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*"%>
<%
	request.setCharacterEncoding("UTF-8");


	//레벨이 1보다 작으면 권한이 없으므로 adminIndex 페이지로 돌아간다.
	Manager manager = (Manager) session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}

/* 	// 수집 코드
	String ebookISBN = request.getParameter("ebookISBN");
	String ebookImg = request.getParameter("ebookImg");
	
	// 디버깅
	System.out.println(ebookISBN);
	System.out.println(ebookImg); */
	// multipartform으로 넘겨서 일반적인 방법으로 받을 수 없다. null 값 나옴. 
	
	
	String path = application.getRealPath("img");
	// 파일을 다운로드 받을 위치
	// 폴더 위치, 이미지 폴더의 실제 경로를 달라고 요청(톰캣)
	// img라는 폴더의 OS상의 실제 폴더
	
	// String path = "d:/temp";
	
	//디버깅
	System.out.println(path);
	
	int size = 1024 * 1024 * 100; // 100MB
	// 1000* 60 * 60 * 24
	
	// 수집코드
	MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
	String ebookISBN = multi.getParameter("ebookISBN");
	String ebookImg = multi.getFilesystemName("ebookImg");
	int rowPerPage = Integer.parseInt(multi.getParameter("rowPerPage"));
 	
	// 디버깅
	System.out.println(ebookISBN);
	System.out.println(ebookImg);
	System.out.println(rowPerPage);
	
	// 객체 선언
	Ebook ebook = new Ebook();
	
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookImg(ebookImg);
	
	// Dao에서 업데이트 이미지 호출 */
	EbookDao.updateEbookImg(ebook);
	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN="+ebookISBN+"&rowPerPage="+rowPerPage);
%>