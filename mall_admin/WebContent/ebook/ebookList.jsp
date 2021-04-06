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
<title>ebookList</title>
</head>
<body>
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include> <!-- include는 프로젝트명 x,  -->
	</div>
	
	<!-- 카테고리별 목록을 볼 수 있는 네비게이션 -->
	<%
		int rowPerPage = 10;
		if(request.getParameter("rowPerPage") != null){
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		}
	%>
	<div>
		<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?rowPerPage=<%=rowPerPage%>">[전체]</a>
	<%
		ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
		// 페이지당 행의 수, 값이 존재하면 그 값으로 초기화
		for(String s : categoryNameList) {
	%>
			<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?categoryName=<%=s%>&rowPerPage=<%=rowPerPage%>">[<%=s%>]</a>
	<%
		}
	%>
	</div>
	
	<h1>ebookList</h1>
	<a href="<%=request.getContextPath()%>/ebook/insertEbookForm.jsp?rowPerPage=<%=rowPerPage%>"><button type="button">ebook 추가</button></a>
	
	<!-- rowPerPage 페이징 -->
	<%
		// 현재 페이지, 값이 존재하면 그 값으로 초기화
		int currentPage = 1;
		if(request.getParameter("currentPage") != null){
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		// 시작 행
		int beginRow = (currentPage - 1 ) * rowPerPage;
		
		// 전체 데이터의 개수
		int totalRow = EbookDao.totalCount();
		System.out.println(totalRow);
		
 		// 카테고리별 목록
		String categoryName ="";
		if(request.getParameter("categoryName") != null){
			categoryName = request.getParameter("categoryName");
		}
		System.out.println("categoryName : " + categoryName);
		 
		// list 생성
		ArrayList<Ebook> list = EbookDao.selectEbookListByPage(rowPerPage, beginRow, categoryName);
	%>
	
	<!-- 몇 페이지씩 보여줄 지 결정해주는 select문 -->
	<form action="<%=request.getContextPath()%>/ebook/ebookList.jsp" method="post">
		<select name="rowPerPage">
			<%
				for(int i=10;i<31;i+=5){
					if(rowPerPage==i){
			%>
						<option value="<%=i%>" selected="selected"><%=i%></option>
			<%			
					} else {
			%>
						<option value="<%=i%>"><%=i%></option>
			<%			
					}
				}
			%>
		</select>
		<button type="submit">보기</button>
	</form>
	
	<table border="1">
		<thead>
			<tr>
				<th>categoryName</th>
				<th>ebookISBN</th>
				<th>ebookTitle</th>
				<th>ebookAuthor</th>
				<th>ebookDate</th>
				<th>ebookPrice</th>			
			</tr>
		</thead>
		<tbody>
			<%
				for(Ebook e : list){
			%>
					<tr>
						<td><%=e.getCategoryName()%></td>
						<td><%=e.getEbookISBN()%></td>
						<!-- ebookTitle 링크화 -->
						<td><a href="<%=request.getContextPath()%>/ebook/ebookOne.jsp?ebookISBN=<%=e.getEbookISBN()%>&rowPerPage=<%=rowPerPage%>"><%=e.getEbookTitle()%></a></td>
						<td><%=e.getEbookAuthor()%></td>
						<td><%=e.getEbookDate()%></td>
						<td><%=e.getEbookPrice()%></td>
					</tr>
			<%		
				}
			%>
		</tbody>
	</table>
	<%
		if(currentPage > 1){
	%>
		<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">이전</a>
	<%
		}
	
		int lastPage = totalRow / rowPerPage; // 마지막 페이지 초기화
		
		if(totalRow % rowPerPage != 0){ // 나머지가 있으면 한 페이지 추가
			lastPage += 1;
		}
		System.out.println("lastPage : " + lastPage); // 라스트 페이지 잘 나오는지 디버깅
			
		if(currentPage < lastPage){
	%>
		<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">다음</a>
	<%
		}
	%>
</body>
</html>