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
	
	// 수집코드
	int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	String managerId = request.getParameter("managerId");
	
	// 디버깅
	System.out.println("commentNo : " + commentNo); // 디버깅
	System.out.println("managerId : " + managerId); // 디버깅
	System.out.println("rowPerPage : " +rowPerPage);
	System.out.println("noticeNo : " +noticeNo);
	
	// Dao에서 삭제 메서드 호출
	if(manager.getManagerLevel() > 0){ // manager.managerLevel == 2, 유지보수 할때는 확실하게 적는게 좋다
		CommentDao.deleteComment(commentNo);
	} else if(manager.getManagerLevel() == 0){ // manager.managerLevel == 0
		CommentDao.deleteComment(commentNo,managerId);
	}
	
	response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?rowPerPage="+rowPerPage+"&noticeNo="+noticeNo); 
%>