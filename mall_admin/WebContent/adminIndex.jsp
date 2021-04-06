<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminIndex</title>
<link rel="stylesheet" href="./css/bootstrap.min.css">
<%-- 헤드 태그에는 일반적으로 css가 들어감, 부트스트랩 CSS 추가해줌 --%>
<!-- <link rel="stylesheet" href="./css/custom.css"> -->
</head>
<body>
	<h1>adminIndex</h1>
	<!-- 
		- 2가지 화면을 분기
		- 로그인 정보는 Manager자료형 세션변수(sessionManager)를 이용 
		1) 관리자 로그인 폼
		2) 관리자 인증 화면 & 몰 메인페이지
	-->
<%
	if(session.getAttribute("sessionManager") == null) {
%>
		<form action="<%=request.getContextPath()%>/manager/loginManagerAction.jsp" method="post">
			<table border="1">
				<tr>
					<td>ID</td>
					<td><input type="text" name="managerId"></td>
				</tr>
				<tr>
					<td>PW</td>
					<td><input type="password" name="managerPw"></td>
				</tr>
			</table>
			<button type="submit">로그인</button>
			<a href="<%=request.getContextPath()%>/manager/insertManagerForm.jsp">매니저 등록</a>
		</form>
		<h3>승인 대기 중인 매니저</h3>
	<%		
		ArrayList<Manager> list = ManagerDao.selectManagerListByZero();
	%>
		<table border="1">
			<thead>
				<tr>
					<th>managerId</th>
					<th>managerDate</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(Manager m : list){
				%>
						<tr>
							<td><%=m.getManagerId() %></td>
							<td><%=m.getManagerDate().substring(0,10)%></td>
						</tr>
				<%
					}
				%>
			</tbody>
		</table>	

	<%		
	} else {
		Manager manager = (Manager)(session.getAttribute("sessionManager"));
	%>
		<!-- 관리자화면 메뉴(네비게이션) include -->
		<div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include> <!-- include는 프로젝트명 x,  -->
		</div>
		<div>
			<%=manager.getManagerName()%>님 반갑습니다.
			<a href="<%=request.getContextPath()%>/manager/logoutManagerAction.jsp">로그아웃</a>
		</div>
		<%
			ArrayList<Notice> noticeList = NoticeDao.selectNoticeListByPage(5,0,"");
			ArrayList<Manager> managerList = ManagerDao.selectManagerListByPage(5,0);
			ArrayList<Ebook> ebookList = EbookDao.selectEbookListByPage(5,0);
			ArrayList<Client> clientList = ClientDao.selectClientListByPage(5, 0);
			ArrayList<OrdersAndEbookAndClient> oecList = OrdersDao.ordersList(5, 0);
		%>
		<!-- 최근 등록된 공지 5개 -->
		<div>
			<h3>NoticeList<a href="<%=request.getContextPath()%>/notice/noticeList.jsp"> more</a></h3>
			<table border="1">
				<%
					for(Notice n : noticeList){
				%>
						<tr>
							<td><%=n.getNoticeTitle()%></td>
							<td><%=n.getManagerId()%></td>
						</tr>
				<%
					}
				%>
			</table>
		</div>
		<!-- 최근 등록된 매니저 5개 -->
		<div>
			<h3>ManagerList<a href="<%=request.getContextPath()%>/manager/managerList.jsp"> more</a></h3>
			<table border="1">
				<%
					for(Manager m : managerList){
				%>
						<tr>
							<td><%=m.getManagerId()%></td>
							<td><%=m.getManagerName()%></td>
						</tr>
				<%
					}
				%>
			</table>
		</div>
		<!-- 최근 등록된 Ebook 5개 -->
		<div>
			<h3>EbookList<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp"> more</a></h3>
			<table border="1">
				<%
					for(Ebook e : ebookList){
				%>
						<tr>
							<td><%=e.getEbookTitle()%></td>
							<td><%=e.getEbookPrice()%></td>
						</tr>
				<%
					}
				%>
			</table>
		</div>
		<!-- 최근 등록된 고객 5개 -->
		<div>
			<h3>ClientList<a href="<%=request.getContextPath()%>/client/clientList.jsp"> more</a></h3>
			<table border="1">
				<%
					for(Client c : clientList){
				%>
						<tr>
							<td><%=c.getClientMail()%></td>
							<td><%=c.getClientDate()%></td>
						</tr>
				<%
					}
				%>
			</table>
		</div>
		<!-- 최근 등록된 주문 5개 -->
		<div>
			<h3>OrdersList<a href="<%=request.getContextPath()%>/orders/ordersList.jsp"> more</a></h3>
			<table border="1">
				<%
					for(OrdersAndEbookAndClient oec : oecList){
				%>
						<tr>
							<td><%=oec.getOrders().getOrdersNo()%></td>
							<td><%=oec.getEbook().getEbookTitle()%></td>
							<td><%=oec.getClient().getClientMail()%></td>
						</tr>
				<%
					}
				%>
			</table>
		</div>
<%		
	}
%>	
</body>
</html>