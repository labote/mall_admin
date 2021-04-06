<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
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
<title>insertEbookForm</title>
</head>
<body>
	<%
		ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
		int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		
		System.out.println("rowPerPage : " + rowPerPage);
		System.out.println(categoryNameList.size()+ "<--카테고리 이름 리스트 사이즈"); // 디버깅
	%>
	<div>
		<a href="<%=request.getContextPath()%>/adminIndex.jsp">관리자 홈</a>
	</div>
	<h1>insertEbookForm</h1>
	<form action="<%=request.getContextPath()%>/ebook/insertEbookAction.jsp" method="post">
		<input type="hidden" name="rowPerPage" value="<%=rowPerPage%>">
		<table border="1">
			<tr>
				<td>categoryName</td>
				<td>
					<!-- 카테고리 이름 종류별로 선택할 수 있게 for문을 이용하여 받아온 카테고리 이름을 출력 -->
					<select name="categoryName">
						<option value="">선택</option>
						<%
							for(String cn : categoryNameList) {
						%>
								<option value="<%=cn%>"><%=cn%></option>
						<%		
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>ebookISBN</td>
				<td><input type="text" name="ebookISBN"></td>
			</tr>
			<tr>
				<td>ebookTitle</td>
				<td><input type="text" name="ebookTitle"></td>
			</tr>
			<tr>
				<td>ebookAuthor</td>
				<td><input type="text" name="ebookAuthor"></td>
			</tr>
			<tr>
				<td>ebookCompany</td>
				<td><input type="text" name="ebookCompany"></td>
			</tr>
			<tr>
				<td>ebookPageCount</td>
				<td><input type="text" name="ebookPageCount"></td>
			</tr>
			<tr>
				<td>ebookPrice</td>
				<td><input type="text" name="ebookPrice"></td>
			</tr>
			<tr>
				<td>ebookSummary</td>
				<td><textarea rows="5" cols="80" name="ebookSummary"></textarea></td>
			</tr>
		</table>
		<button type="submit">ebook 추가</button>
		<button type="button" onclick="history.back()">취소</button>
	</form>
</body>
</html>