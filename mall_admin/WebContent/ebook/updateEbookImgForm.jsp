<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%
	//레벨이 1보다 작으면 권한이 없으므로 adminIndex 페이지로 돌아간다.
	Manager manager = (Manager) session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateEbookImgForm</title>
</head>
<body>
	<%
		String ebookISBN = request.getParameter("ebookISBN");
		String rowPerPage = request.getParameter("rowPerPage");
		System.out.println("ebookISBN : " + ebookISBN); // 값 디버깅
		System.out.println("rowPerPage : " + rowPerPage); // rowPerPage 확인
	%>
	<h1>updateEbookImgForm</h1>
	<!-- <form action="" method="post" enctype="application/x-www-form-urlencoded"> -->
	<form action="<%=request.getContextPath()%>/ebook/updateEbookImgAction.jsp" method="post" enctype="multipart/form-data">
		<input type="hidden" name="ebookISBN" value="<%=ebookISBN %>">
		<input type="hidden" name="rowPerPage" value="<%=rowPerPage %>">
		<input type="file" name="ebookImg">
		<button type="submit">이미지 수정</button>
	</form>
</body>
</html>