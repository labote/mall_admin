<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*"%>

<%
	request.setCharacterEncoding("UTF-8");

	// 1-1\. 수집 코드
	int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	String managerId = request.getParameter("managerId");
	
	// 1-2. 디버깅
	System.out.println("noticeTitle : " + noticeTitle);
	System.out.println("noticeContent : " + noticeContent);
	System.out.println("managerId : " +managerId);
	System.out.println("rowPerPage : " +rowPerPage);
	
	// 2-1. 전처리
	Notice notice = new Notice();
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	notice.setManagerId(managerId);

	// 2-2. 디버깅
	System.out.println("notice.noticeTitle : " + notice.getNoticeTitle());
	System.out.println("notice.noticeContent : " + notice.getNoticeContent());
	System.out.println("notice.managerId : " + notice.getManagerId());
	
	// 3. Dao에서 insert 메서드 호출
 	NoticeDao.insertNotice(notice);
	response.sendRedirect(request.getContextPath()+"/notice/noticeList.jsp?rowPerPage="+rowPerPage); 
%>