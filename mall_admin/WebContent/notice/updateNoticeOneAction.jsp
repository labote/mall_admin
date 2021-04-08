<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	// 레벨이 2보다 작으면 권한이 없으므로 adminIndex 페이지로 돌아간다.
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager==null){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if(manager.getManagerLevel() < 2){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	// 1-1. 수집 코드
	int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo")); // 앞 jsp에서 받아온 값 저장
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	String noticeDate = request.getParameter("noticeDate");
	String managerId = request.getParameter("managerId");
	
	// 1-2. 디버깅
	System.out.println(rowPerPage); // 디버깅
	System.out.println(noticeNo); // 디버깅
	System.out.println(noticeTitle); // 디버깅
	System.out.println(noticeContent); // 디버깅
	System.out.println(noticeDate); // 디버깅
	System.out.println(managerId); // 디버깅
	
	// 2-1. 객체 생성 및 전처리
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	notice.setNoticeDate(noticeDate);
	notice.setManagerId(managerId);
	
 	// 2-2. Dao에서 업데이트 메서드 호출
	NoticeDao.updateNoticeOne(notice);
	response.sendRedirect(request.getContextPath()+"/notice/noticeList.jsp?rowPerPage="+rowPerPage);
%>