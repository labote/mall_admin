<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
/* 	// 레벨이 2보다 작으면 권한이 없으므로 adminIndex 페이지로 돌아간다.
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager==null){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if(manager.managerLevel < 2){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>inserNoticeForm</title>
</head>
<body>
	<%
		int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		ArrayList<String> managerIdList = ManagerDao.managerIdList(); // 매니저 Id를 가져오는 객체 생성 및 초기화
		System.out.println("managerIdListSize : " + managerIdList.size()); // 디버깅
		System.out.println("rowPerPage : " + rowPerPage); // 디버깅
	%>
	<div>
		<a href="<%=request.getContextPath()%>/adminIndex.jsp">관리자 홈</a>
	</div>
	<h1>inserNoticeForm</h1>
	<form action="<%=request.getContextPath()%>/notice/insertNoticeAction.jsp" method="post">
		<input type="hidden" name="rowPerPage" value="<%=rowPerPage%>">
		<table border="1">
			<tr>
				<td>noticeTitle</td>
				<td><input type="text" name="noticeTitle" maxlength="30" required></td>
			</tr>
			<tr>
				<td>noticeContent</td>
				<td><textarea rows="5" cols="80" name="noticeContent"></textarea></td>
			</tr>
			<tr>
				<td>managerId</td>
				<td>
					<select name="managerId" required>
						<option value="">선택</option>
							<%
								for(String mi : managerIdList){
							%>
									<option value="<%=mi%>"><%=mi%></option>
							<%		
								}
							%>
					</select>
				</td>
			</tr>
		</table>
		<button type="submit">공지 등록</button>
		<button type="button" onclick="history.back()">취소</button>
	</form>
</body>
</html>