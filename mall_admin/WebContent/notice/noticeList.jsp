<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	// 레벨이 1보다 작으면 권한이 없으므로 adminIndex 페이지로 돌아간다.
	Manager manager = (Manager) session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="Responsive Admin &amp; Dashboard Template based on Bootstrap 5">
	<meta name="author" content="AdminKit">
	<meta name="keywords" content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">

	<link rel="shortcut icon" href="../img/icons/icon-48x48.png" />

	<title>noticeList</title>

	<link href="../css/app.css" rel="stylesheet">
</head>

<body>
	<%
		// 현재 페이지
		int currentPage = 1; // 현재 페이지 초기화
		if(request.getParameter("currentPage") != null) { // 현재 페이지 값이 존재한다면 가져온다
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		// 페이지당 행의 개수
		int rowPerPage = 10; // 페이지당 행의 개수 초기화
		if(request.getParameter("rowPerPage") != null) { // 행의 개수 값이 존재한다면 가져온다.
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		}
		
		// 공지 찾기
		String searchTitle = ""; // 찾고자 하는 공지 초기화
		if(request.getParameter("searchTitle") != null) { // 행의 개수 값이 존재한다면 가져온다.
			searchTitle = request.getParameter("searchTitle");
		}
		
		// 시작 행
		int beginRow = (currentPage-1) * rowPerPage;
				
		// 전체 데이터의 개수
		int totalRow = NoticeDao.totalCount(searchTitle);
		System.out.println("totalRow : " + totalRow); // totalRow를 잘 받아오는지 디버깅
				
		// list 생성
		ArrayList<Notice> list = NoticeDao.selectNoticeListByPage(rowPerPage, beginRow, searchTitle);
		
	%>
	
	<div class="wrapper">
		<nav id="sidebar" class="sidebar">
			<div class="sidebar-content js-simplebar">
				<a class="sidebar-brand" href="<%=request.getContextPath()%>/adminIndex.jsp">
          <span class="align-middle">Mall Management</span>
        </a>

				<ul class="sidebar-nav">
					<li class="sidebar-header">
						Pages
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/adminIndex.jsp">
           				<i class="align-middle" data-feather="sliders"></i> <span class="align-middle">Index</span>
         		    </a>
					</li>
					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/manager/managerList.jsp">
			              <i class="align-middle" data-feather="settings"></i> <span class="align-middle">Manager</span>
			            </a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/client/clientList.jsp">
			              <i class="align-middle" data-feather="user"></i> <span class="align-middle">Client</span>
			            </a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/category/categoryList.jsp">
			              <i class="align-middle" data-feather="credit-card"></i> <span class="align-middle">Category</span>
			            </a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/ebook/ebookList.jsp">
			              <i class="align-middle" data-feather="book"></i> <span class="align-middle">Ebook</span>
			            </a>
					</li>
					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/orders/ordersList.jsp">
			              <i class="align-middle" data-feather="package"></i> <span class="align-middle">Orders</span>
			            </a>
					</li>
					<li class="sidebar-item active">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp">
			              <i class="align-middle" data-feather="database"></i> <span class="align-middle">Notice</span>
			            </a>
					</li>
					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/manager/logoutManagerAction.jsp">
			              <i class="align-middle" data-feather="log-out"></i> <span class="align-middle" style="color:red;">Logout</span>
			            </a>
					</li>
				</ul>
			</div>
		</nav>

		<div class="main">
			<nav class="navbar navbar-expand navbar-light navbar-bg">
				<a class="sidebar-toggle d-flex">
         			 <i class="hamburger align-self-center"></i>
       			</a>
				<form class="d-none d-sm-inline-block" action="<%=request.getContextPath()%>/notice/noticeList.jsp" method="post">
					<div class="input-group input-group-navbar">
						<input type="hidden" name="rowPerPage" value="<%=rowPerPage%>">
						<input type="text" class="form-control" placeholder="searchTitle" aria-label="SearchTitle" name="searchTitle">
						<button class="btn" type="submit">
			            	<i class="align-middle" data-feather="search"></i>
			            </button>
					</div>
				</form>
				<div class="navbar-collapse collapse">
					<ul class="navbar-nav navbar-align">
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle d-none d-sm-inline-block" href="#" data-toggle="dropdown">
					           	<span class="text-dark">level<%=manager.getManagerLevel()%>&nbsp;<%=manager.getManagerId()%></span>
					        </a>
							<div class="dropdown-menu dropdown-menu-right">
								<a class="dropdown-item" href="<%=request.getContextPath()%>/manager/logoutManagerAction.jsp">Log out</a>
							</div>
						</li>
					</ul>
				</div>
			</nav>
			<main class="content">
				<div class="container-fluid p-0">
					<div class="row mb-2 mb-xl-3">
						<div class="col-auto d-none d-sm-block">
							<h3><strong>Notice</strong>&nbsp;List</h3>
						</div>
					</div>
					
					<div class="row">
						<div class="col-12 col-xl-6">
							<div class="card flex-fill">
								<div class="card-header">
									<!-- 몇 페이지씩 보여줄 지 결정해주는 페이지 -->
									<form action="<%=request.getContextPath()%>/notice/noticeList.jsp" method="post">
										<select name="rowPerPage">
											<%
												for(int i=10; i<31; i+=5){
													if(rowPerPage == i){
											%>
														<option value="<%=i%>" selected="selected"><%=i%></option>
											<%			
													} else {
											%>
														<option value="<%=i%>"><%=i%></option>
											<%			
													}
												}
											%>
										</select>
										<button type="submit" class="btn btn-primary btn-sm">보기</button>
										<a href="<%=request.getContextPath()%>/notice/insertNoticeForm.jsp?rowPerPage=<%=rowPerPage%>"><button type="button" class="btn btn-primary btn-sm float-right">공지 쓰기</button></a>
									</form>
								</div>
								<table class="table table-hover my-0 table-bordered">
									<thead>
										<tr>
											<th>noticeNo</th>
											<th>noticeTitle</th>
											<th>noticeContent</th>
											<th>noticeDate</th>
											<th>managerId</th>
										</tr>
									</thead>
									<tbody>
										<% 
											for(Notice n : list) {
										%>
												<tr>
													<td><%=n.getNoticeNo()%></td>
													<td><a href="<%=request.getContextPath()%>/notice/noticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>&rowPerPage=<%=rowPerPage%>"><%=n.getNoticeTitle()%></a></td>
													<td><%=n.getNoticeTitle()%></td>
													<td><%=n.getNoticeDate()%></td>
													<td><%=n.getManagerId()%></td>
												</tr>
										<%		
											}
										%>
									</tbody>
								</table>
							</div>
								<%
									if(currentPage > 1){
								%>
									<a href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>"><button class="btn btn-primary btn-sm"><i class="align-middle" data-feather="chevrons-left"></i></button></a>
								<%
									}
								
									int lastPage = totalRow / rowPerPage; // 마지막 페이지 초기화
									
									if(totalRow % rowPerPage != 0){ // 나머지가 있으면 한 페이지 추가
										lastPage += 1;
									}
									System.out.println("lastPage : " + lastPage); // 라스트 페이지 잘 나오는지 디버깅
										
									if(currentPage < lastPage){
								%>
									<a href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>"><button class="btn btn-primary btn-sm"><i class="align-middle" data-feather="chevrons-right"></i></button></a>
								<%
									}
								%>
						</div>
					</div>
				</div>
			</main>

			<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF">
				Copyright &copy; 2021 홍민성 All Rights Reserved.
			</footer>
		</div>
	</div>


	<script src="../js/app.js"></script>

</body>

</html>