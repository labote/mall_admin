<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<a href="<%=request.getContextPath()%>/adminIndex.jsp">[운영자 홈]</a>
	<a href="<%=request.getContextPath()%>/manager/managerList.jsp">[운영자 관리]</a>
	<a href="<%=request.getContextPath()%>/client/clientList.jsp">[고객 관리]</a>
	<a href="<%=request.getContextPath()%>/category/categoryList.jsp">[상품 카테고리 관리]</a>
	<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">[ebook 관리]</a>
	<!-- order 쓰면 오류가 발생함, 명령어(order by)가 존재하기 때문 -->
	<a href="<%=request.getContextPath()%>/orders/ordersList.jsp">[주문 관리]</a>
	<!-- CRUD, 목록과 상세보기까지(List,One) + 수정, 삭제, 읽기는 레벨1이상, CUD - 레벨2이상 -->
	<a href="<%=request.getContextPath()%>/notice/noticeList.jsp">[공지 관리]</a>	
	<a href="<%=request.getContextPath()%>/manager/logoutManagerAction.jsp">[로그아웃]</a>
</div>