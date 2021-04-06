<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
 <%
 	request.setCharacterEncoding("UTF-8");
 
	//레벨이 1보다 작으면 권한이 없으므로 adminIndex 페이지로 돌아간다.
	Manager manager = (Manager) session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	// 수집 코드
	int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String managerId = request.getParameter("managerId");
	String commentContent = request.getParameter("commentContent");
	
	// 디버깅
	System.out.println("noticeNo : " + noticeNo);
	System.out.println("managerId : " + managerId);
	System.out.println("commentContent : " + commentContent);
	System.out.println("rowPerPage : " +rowPerPage);
	
	Comment comment = new Comment();
	comment.setNoticeNo(noticeNo);
	comment.setManagerId(managerId);
	comment.setCommentContent(commentContent);
	
	// Dao.insert 메서드 호출
	CommentDao.insertComment(comment);
	response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?rowPerPage="+rowPerPage+"&noticeNo="+noticeNo); 
%>