<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
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
<title>updateEbookOneForm</title>
</head>
<body>
	<%
		// 수집
		String ebookISBN = request.getParameter("ebookISBN");
		String rowPerPage = request.getParameter("rowPerPage");
		ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
		
		System.out.println(ebookISBN); // ISBN 값 잘 받아오는지 디버깅
		System.out.println(rowPerPage); // rowPerPage 값 잘 받아오는지 디버깅
		System.out.println(categoryNameList.size()+ "<--카테고리 이름 리스트 사이즈"); // 디버깅
		// Dao 안에 있는 selectEbookOne 메서드 호출
		Ebook ebook = EbookDao.selectEbookOne(ebookISBN);
	%>
	<div>
		<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">ebook 홈</a>
	</div>
	<h1>updateEbookOneForm</h1>
	
	<form action="<%=request.getContextPath()%>/ebook/updateEbookOneAction.jsp" method="post">
		<input type="hidden" name = "ebookISBN" value="<%=ebookISBN%>">
		<input type="hidden" name = "rowPerPage" value="<%=rowPerPage%>">
		<table border="1">
			<tr>
				<td>ebookISBN</td>
				<td><input type="text" placeholder="<%=ebook.getEbookISBN()%>" readonly></td>
			</tr>
			<tr>
				<td>categoryName</td>
				<td>
					<!-- 카테고리 이름 종류별로 선택할 수 있게 for문을 이용하여 받아온 카테고리 이름을 출력 -->
					<select name="categoryName" required>
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
				<td>ebookTitle</td>
				<td><input type="text" name="ebookTitle" required></td>
			</tr>
			<tr>
				<td>ebookState</td>
				<td><input type="text" name="ebookState"  placeholder="<%=ebook.getEbookState()%>" readonly></td>
			</tr>
			<tr>
				<td>ebookAuthor</td>
				<td><input type="text" name="ebookAuthor" required></td>
			</tr>
			<tr>
				<td>ebookImg</td>
				<td><img src="<%=request.getContextPath()%>/img/<%=ebook.getEbookImg()%>"></td>
			</tr>
			<tr>
				<td>ebookCompany</td>
				<td><input type="text" name="ebookCompany" required></td>
			</tr>
			<tr>
				<td>ebookPageCount</td>
				<td><input type="text" name="ebookPageCount" required></td>
			</tr>
			<tr>
				<td>ebookPrice</td>
				<td><input type="text" name="ebookPrice" required></td>
			</tr>
			<tr>
				<td>ebookDate</td>
				<td><input type="text" name="ebookDate" placeholder="<%=ebook.getEbookDate()%>" readonly></td>
			</tr>
			<tr>
				<td>ebookSummary</td>
				<td><input type="text" name="ebookSummary" placeholder="<%=ebook.getEbookSummary()%>" readonly></td>
			</tr>
		</table>
		<button type="submit">수정</button>
		<button type="button" onclick="history.back()">취소</button>
	</form>
</body>
</html>