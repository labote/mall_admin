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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ebookOne</title>
</head>
<body>
	<%
		// 수집
		int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		String ebookISBN = request.getParameter("ebookISBN");
		
		System.out.println("ebookISBN : " + ebookISBN); // ISBN 값 잘 받아오는지 디버깅
		System.out.println("rowPerPage : " + rowPerPage);
		// Dao 안에 있는 selectEbookOne 메서드 호출
		Ebook ebook = EbookDao.selectEbookOne(ebookISBN);
	%>
	<div>
		<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">ebook 홈</a>
	</div>
	<h1>ebookOne</h1>
	
	<table border="1">
		<tr>
			<td>ebookISBN</td>
			<td><%=ebook.getEbookISBN()%></td>
			<td></td>
		</tr>
		<tr>
			<td>categoryName</td>
			<td><%=ebook.getCategoryName()%></td>
			<td></td>
		</tr>
		<tr>
			<td>ebookTitle</td>
			<td><%=ebook.getEbookTitle()%></td>
			<td></td>
		</tr>
		<tr>
			<td>ebookState</td>
			<td><%=ebook.getEbookState()%></td>
			<td><a href="<%=request.getContextPath()%>/ebook/updateEbookStateForm.jsp?ebookISBN=<%=ebook.getEbookISBN()%>&rowPerPage=<%=rowPerPage%>"><button type="button">책 상태 수정</button></a></td>
		</tr>
		<tr>
			<td>ebookAuthor</td>
			<td><%=ebook.getEbookAuthor()%></td>
			<td></td>
		</tr>
		<tr>
			<td>ebookImg</td>
			<td><img src="<%=request.getContextPath()%>/img/<%=ebook.getEbookImg()%>"></td>
			<td><a href="<%=request.getContextPath()%>/ebook/updateEbookImgForm.jsp?ebookISBN=<%=ebook.getEbookISBN()%>&rowPerPage=<%=rowPerPage%>"><button type="button">이미지 수정</button></a></td>
		</tr>
		<tr>
			<td>ebookCompany</td>
			<td><%=ebook.getEbookCompany()%></td>
			<td></td>
		</tr>
		<tr>
			<td>ebookPageCount</td>
			<td><%=ebook.getEbookPageCount()%></td>
			<td></td>
		</tr>
		<tr>
			<td>ebookPrice</td>
			<td><%=ebook.getEbookPrice()%></td>
			<td></td>
		</tr>
		<tr>
			<td>ebookDate</td>
			<td><%=ebook.getEbookDate()%></td>
			<td></td>
		</tr>
		
		<tr>
			<td>ebookSummary</td>
			<td><%=ebook.getEbookSummary()%></td>
			<td><a href="<%=request.getContextPath()%>/ebook/updateEbookSummaryForm.jsp?ebookISBN=<%=ebook.getEbookISBN()%>&rowPerPage=<%=rowPerPage%>"><button type="button">책 요약 수정</button></a></td>
		</tr>
	</table>
	<a href="<%=request.getContextPath()%>/ebook/updateEbookOneForm.jsp?ebookISBN=<%=ebook.getEbookISBN()%>&rowPerPage=<%=rowPerPage%>"><button type="button">전체 수정(이미지 제외)</button></a>
	<a href="<%=request.getContextPath()%>/ebook/deleteEbookOneAction.jsp?ebookISBN=<%=ebook.getEbookISBN()%>&rowPerPage=<%=rowPerPage%>"><button type="button">삭제</button></a>
	<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?rowPerPage=<%=rowPerPage%>"><button type="button">뒤로 가기</button></a>
</body>
</html>