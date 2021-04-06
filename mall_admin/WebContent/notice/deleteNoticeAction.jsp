<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%
	// 레벨이 2보다 작으면 권한이 없으므로 adminIndex 페이지로 돌아간다.
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager==null){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if(manager.getManagerLevel() < 2){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	request.setCharacterEncoding("UTF-8");
	// 1. 수집코드
	int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo")); // jsp에서 넘긴 값을 받아온다.
	System.out.println("noticeNo : " + noticeNo); // 디버깅
	System.out.println("rowPerPage : " + rowPerPage); // 디버깅
	
	// 댓글 유무 확인
	int rowCnt = CommentDao.selectCommentCnt(noticeNo);
	if(rowCnt != 0){
		System.out.printf(noticeNo + "번 공지글의 댓글이 " + rowCnt + "개 있습니다");
		response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?rowPerPage="+rowPerPage+"&noticeNo="+noticeNo);
		return;
	}
	// 2. Dao에서 delete 메서드 호출\
	NoticeDao.deleteNotice(noticeNo);
	response.sendRedirect(request.getContextPath()+"/notice/noticeList.jsp?rowPerPage="+rowPerPage); 
%>