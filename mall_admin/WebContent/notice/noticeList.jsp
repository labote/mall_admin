<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	// 레벨이 1보다 작으면 권한이 없으므로 adminIndex 페이지로 돌아간다.
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager==null){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if(manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>noticeList</title>
</head>
<body>
	<%
		// 현재 페이지
		int currentPage = 1; // 현재 페이지 초기화
		if(request.getParameter("currentPage") != null) { // 현재 페이지 값이 존재한다면 가져온다
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		// 페이지당 행의 개수
		int rowPerPage = 10; // 페이지당 행의 개수 초기화
		if(request.getParameter("rowPerPage") != null) { // 행의 개수 값이 존재한다면 가져온다.
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		}
		
		// 공지 찾기
		String searchTitle = ""; // 찾고자 하는 공지 초기화
		if(request.getParameter("searchTitle") != null) { // 행의 개수 값이 존재한다면 가져온다.
			searchTitle = request.getParameter("searchTitle");
		}
		
		// 시작 행
		int beginRow = (currentPage-1) * rowPerPage;
				
		// 전체 데이터의 개수
		int totalRow = NoticeDao.totalCount(searchTitle);
		System.out.println("totalRow : " + totalRow); // totalRow를 잘 받아오는지 디버깅
				
		// list 생성
		ArrayList<Notice> list = NoticeDao.selectNoticeListByPage(rowPerPage, beginRow, searchTitle);
		
	%>
	<!-- 관리자 화면 메뉴(네비게이션) include -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include> <!-- include는 프로젝트명 x -->
	</div>
	<h1>noticeList</h1>
	<a href="<%=request.getContextPath()%>/notice/insertNoticeForm.jsp?rowPerPage=<%=rowPerPage%>"><button type="button">공지 쓰기</button></a>
	
	<!-- 몇 페이지씩 보여줄것인지 설정 -->
	<form action="<%=request.getContextPath()%>/notice/noticeList.jsp" method="post">
		<select name="rowPerPage">
			<%
				for(int i=10;i<31;i+=5){
					if(rowPerPage == i){
			%>
						<option value="<%=i%>"selected="selected"><%=i%></option>			
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
				<th>noticeNo</th>
				<th>noticeTitle</th>
				<th>noticeContent</th>
				<th>noticeDate</th>
				<th>managerId</th>
			</tr>
		</thead>
 		<tbody>
			<% 
				for(Notice n : list) {
			%>
					<tr>
						<td><%=n.getNoticeNo()%></td>
						<td><a href="<%=request.getContextPath()%>/notice/noticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>&rowPerPage=<%=rowPerPage%>"><%=n.getNoticeTitle()%></a></td>
						<td><%=n.getNoticeTitle()%></td>
						<td><%=n.getNoticeDate()%></td>
						<td><%=n.getManagerId()%></td>
					</tr>
			<%		
				}
			%>
		</tbody>
	</table>
	<%
		if(currentPage > 1){
	%>
		<a href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">이전</a>
	<%
		}
	
		int lastPage = totalRow / rowPerPage; // 마지막 페이지 초기화
		
		if(totalRow % rowPerPage != 0){ // 나머지가 있으면 한 페이지 추가
			lastPage += 1;
		}
		System.out.println("lastPage : " + lastPage); // 라스트 페이지 잘 나오는지 디버깅
			
		if(currentPage < lastPage){
	%>
		<a href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">다음</a>
	<%
		}
	%>
	<form action="<%=request.getContextPath()%>/notice/noticeList.jsp" method="post">
		<input type="hidden" name="rowPerPage" value="<%=rowPerPage%>">
		<div>
			noticeTitle :
			<input type="text" name="searchTitle">
			<button type="submit">검색</button>
		</div>
	</form>
</body>
</html>