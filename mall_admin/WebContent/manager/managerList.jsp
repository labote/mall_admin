<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	// 레벨이 2보다 작으면 권한이 없으므로 adminIndex 페이지로 돌아간다.
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
<title>managerList</title>
</head>
<body>
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include> <!-- include는 프로젝트명 x,  -->
	</div>
<%
	// 현재 페이지를 초기화, 만약 받아오는 페이지가 있다면 그 숫자를 넣어준다.
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("currentPage : " + currentPage);
	
	// 페이지당 나오는 행의 수를 초기화, 만약 행의 개수가 달라진다면 그 숫자를 넣어준다.
	int rowPerPage = 10;
	if(request.getParameter("rowPerPage") != null){
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	
	String searchId = "";
	if(request.getParameter("searchId") != null){
		searchId = request.getParameter("searchId");
	}
	
	// 시작 행
	int beginRow = (currentPage-1) * rowPerPage;
	
	// 전체 데이터의 개수
	int totalRow = ManagerDao.totalCount(searchId);
	System.out.println("totalRow : " + totalRow); // totalRow를 잘 받아오는지 디버깅
	
	// 리스트 생성
	ArrayList<Manager> list = ManagerDao.selectManagerListByPage(rowPerPage, beginRow, searchId);
%>
	<h1>managerList</h1>
	<!-- 몇 페이지씩 보여줄 것인지 결정해주는 폼 -->
	<form action="<%=request.getContextPath()%>/manager/managerList.jsp" method="post">
		<select name="rowPerPage">
			<%
				for(int i=10; i<31; i+=5){
					if(rowPerPage == i){
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
				<th>managerNo</th>
				<th>managerId</th>
				<th>managerName</th>
				<th>managerDate</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Manager m : list){
			%>
					<tr>
						<td><%=m.getManagerNo()%></td>
						<td><%=m.getManagerId()%></td>
						<td><%=m.getManagerName()%></td>
						<td><%=m.getManagerDate()%></td>
						<td>
							<form action="<%=request.getContextPath()%>/manager/updateManagerLevelAction.jsp" method="post">
								<input type="hidden" name="managerNo" value="<%=m.getManagerNo()%>">
								<select name="managerLevel">
									<%
										for(int i=0; i<3; i++){
											if(m.getManagerLevel() == i){
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
								<button type="submit">수정</button>
							</form>
						</td>
						<td>
							<%-- <a href="<%=request.getContextPath()%>/manager/deleteManagerAction.jsp?managerNo=<%=m.managerNo%>"><button type="button">삭제</button></a> --%>
							<button onclick = "location.href = '../manager/deleteManagerAction.jsp?managerNo=<%=m.getManagerNo()%>'"  type="button">삭제</button>
						</td>
					</tr>
			<%			
				}
			%>
		</tbody>
	</table>
	<%
		if(currentPage > 1){
	%>
		<a href="<%=request.getContextPath()%>/manager/managerList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&searchId=<%=searchId%>">이전</a>
	<%
		}
	
		int lastPage = totalRow / rowPerPage; // 마지막 페이지 초기화
		
		if(totalRow % rowPerPage != 0){ // 나머지가 있으면 한 페이지 추가
			lastPage += 1;
		}
		System.out.println("lastPage : " + lastPage); // 라스트 페이지 잘 나오는지 디버깅
			
		if(currentPage < lastPage){
	%>
		<a href="<%=request.getContextPath()%>/manager/managerList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&searchId=<%=searchId%>">다음</a>
	<%
		}
	%>
	<form action="<%=request.getContextPath()%>/manager/managerList.jsp" method="post">
		<input type="hidden" name="rowPerPage" value="<%=rowPerPage%>">
		<div>
			managerId : 
			<input type="text" name="searchId">
			<button type="submit">검색</button>
		</div>
	</form>
</body>
</html>