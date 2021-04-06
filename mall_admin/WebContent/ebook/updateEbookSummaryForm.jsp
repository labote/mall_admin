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
<title>updateEbookSummaryForm</title>
</head>
<body>
	<%
		String ebookISBN = request.getParameter("ebookISBN");
		String rowPerPage = request.getParameter("rowPerPage");
		System.out.println("ebookISBN : " + ebookISBN); // ebookISBN 값 확인
		System.out.println("rowPerPage : " + rowPerPage);
	%>
	
	<div>
		<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">ebook 홈</a>
	</div>
	
	<h1>updateEbookSummaryForm</h1>
	<form action="<%=request.getContextPath()%>/ebook/updateEbookSummaryAction.jsp" method="post">
		<input type="hidden" name = "ebookISBN" value="<%=ebookISBN%>">
		<input type="hidden" name = "rowPerPage" value="<%=rowPerPage%>">
		<table border="1">
			<tr>
				<td>ebookSummary</td>
				<td><input type="text" name="ebookSummary"></td>
			</tr>
		</table>
		<button type="submit">책 요약 수정</button>
		<button type="button" onclick="history.back()">취소</button>
	</form>
</body>
</html>