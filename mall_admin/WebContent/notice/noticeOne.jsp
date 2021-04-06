<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
<html>
<head>
<meta charset="UTF-8">
<title>noticeOne</title>
</head>
<body>
	<%
		int noticeNo = Integer.parseInt(request.getParameter("noticeNo")); // 앞 jsp에서 넘어온 noticeNo값을 받아온다.
		int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		
		System.out.println(noticeNo); // 받아온 값 디버깅
		System.out.println(rowPerPage);
		
		Notice n = NoticeDao.selectNoticeOne(noticeNo);
	%>
	<div>
		<a href="<%=request.getContextPath()%>/notice/noticeList.jsp?rowPerPage=<%=rowPerPage%>">notice 홈</a>
	</div>
	<h1>noticeOne</h1>
	<table border="1">
		<tr>
			<td>noticeNo</td>
			<td><%=n.getNoticeNo()%></td>
		</tr>
		<tr>
			<td>noticeTitle</td>
			<td><%=n.getNoticeTitle()%></td>
		</tr>
		<tr>
			<td>noticeContent</td>
			<td><textarea rows="5" cols="80"><%=n.getNoticeContent()%></textarea></td>
		</tr>
		<tr>
			<td>noticeDate</td>
			<td><%=n.getNoticeDate()%></td>
		</tr>
		<tr>
			<td>managerId</td>
			<td><%=n.getManagerId()%></td>
		</tr>
	</table>
	<a href="<%=request.getContextPath()%>/notice/updateNoticeOneForm.jsp?rowPerPage=<%=rowPerPage%>&noticeNo=<%=noticeNo%>"><button type="button">전체 수정</button></a>
	<a href="<%=request.getContextPath()%>/notice/deleteNoticeAction.jsp?noticeNo=<%=noticeNo%>&rowPerPage=<%=rowPerPage%>"><button type="button">삭제</button></a>
	<a href="<%=request.getContextPath()%>/notice/noticeList.jsp?rowPerPage=<%=rowPerPage%>"><button type="button">뒤로 가기</button></a>

	<!-- 댓글 -->
	<form action="<%=request.getContextPath()%>/notice/insertCommentAction.jsp" method="post">
		<input type="hidden" name="noticeNo" value="<%=n.getNoticeNo()%>">
		<input type="hidden" name="rowPerPage" value="<%=rowPerPage%>">
		<div>
			<!-- 세션값 사용 -->
			managerID :
			<input type="text" name="managerId" value="<%=manager.getManagerId()%>" readonly="readonly">
		</div>
		<div>
			<textarea name="commentContent" rows="2" cols="80" maxlength="100" required></textarea>
		</div>
		<button type="submit">댓글 입력</button>
	</form>
	
	<!-- 댓글리스트 -->
	<%
		ArrayList<Comment> commentList = CommentDao.selectCommentListByNoticeNo(noticeNo);
	
		for(Comment c : commentList){
	%>
			<table border="1">
				<tr>
					<td><%=c.getCommentDate()%></td>
					<td><%=c.getManagerId()%></td>
					<td><a href="<%=request.getContextPath()%>/notice/deleteCommentAction.jsp?commentNo=<%=c.getCommentNo()%>&managerId=<%=manager.getManagerId()%>&rowPerPage=<%=rowPerPage%>&noticeNo=<%=noticeNo%>"><button>삭제</button></a></td>
				</tr>
				<tr>
					<td colspan="3"><textarea rows="5" cols="60"><%=c.getCommentContent()%></textarea></td>
				</tr>
			</table>
	<%
		}
	%>
</body>
</html>