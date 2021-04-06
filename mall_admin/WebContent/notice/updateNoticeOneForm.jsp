<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%-- <%
	//레벨이 2보다 작으면 권한이 없으므로 adminIndex 페이지로 돌아간다.
	Manager manager = (Manager) session.getAttribute("sessionManager");
	if(manager == null || manager.managerLevel < 2){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateNoticeOneForm</title>
</head>
<body>
	<%
		int noticeNo = Integer.parseInt(request.getParameter("noticeNo")); // 앞 jsp에서 받아온 noticeNo 호출
		int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		System.out.println("noticeNo : " + noticeNo); // 디버깅
		System.out.println("rowPerPage : " + rowPerPage); // 디버깅
		
		ArrayList<String> managerIdList = ManagerDao.managerIdList(); // 매니저 Id를 가져오는 객체 생성 및 초기화
		System.out.println("managerIdListSize : " + managerIdList.size()); // 디버깅
		
		Notice notice = NoticeDao.selectNoticeOne(noticeNo);
	%>
	<div>
		<a href="<%=request.getContextPath()%>/notice/noticeList.jsp&rowPerPage=<%=rowPerPage%>">notice 홈</a>
	</div>
	<h1>updateNoticeOne</h1>
	
	<form action="<%=request.getContextPath()%>/notice/updateNoticeOneAction.jsp" method="post">
		<input type="hidden" name="noticeNo" value="<%=noticeNo%>">
		<input type="hidden" name="noticeDate" value="<%=notice.getNoticeDate()%>">
		<input type="hidden" name="rowPerPage" value="<%=rowPerPage%>">
		<table border="1">
			<tr>
				<td>noticeNo</td>
				<td><input type="text" placeholder="<%=notice.getNoticeNo() %>" readonly></td>
			</tr>
			<tr>
				<td>noticeTitle</td>
				<td><input type="text" name="noticeTitle" maxlength="30" required></td>
			</tr>
			<tr>
				<td>noticeContent</td>
				<td><input type="text" name="noticeContent" required></td>
			</tr>
			<tr>
				<td>noticeDate</td>
				<td><input type="text" placeholder="<%=notice.getNoticeDate()%>" readonly></td>
			</tr>
			<tr>
				<td>managerId</td>
				<td>
					<!-- 매니저 아이디별로 선택할 수 있게 for문을 이용하여 받아온 매니저 아이디를 출력 -->
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
		<button type="submit">수정</button>
		<a href="<%=request.getContextPath()%>/notice/noticeOne.jsp?rowPerPage=<%=rowPerPage%>&noticeNo=<%=noticeNo%>"><button type="button">취소</button></a>
	</form>
</body>
</html>