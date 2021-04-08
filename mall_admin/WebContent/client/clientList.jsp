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

	<title>clientList</title>

	<link href="../css/app.css" rel="stylesheet">
</head>

<body>
	<%
		// 현재 페이지를 초기화 후 만약 숫자를 받아온다면 그 숫자로 바꿔준다.
		// 즉, 현재 페이지를 바꿔준다.
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		// 페이지당 행의 수를 초기화 한 후 만약 숫자를 받아온다면 그 숫자로 바꿔준다.
		// 즉, 페이지당 행의 수를 바꿔준다.
		int rowPerPage = 10;
		if(request.getParameter("rowPerPage") != null) {
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		}
		
		String searchWord = "";
		if(request.getParameter("searchWord") != null) {
			searchWord = request.getParameter("searchWord");
		}
		
		// 시작 행
		int beginRow = (currentPage-1) * rowPerPage;
		
		// 전체 데이터의 개수
		int totalRow = ClientDao.totalCount(searchWord);
		System.out.println(totalRow); // totalRow를 잘 받아오는지 디버깅
			
		// list 생성
		ArrayList<Client> list = ClientDao.selectClientListByPage(rowPerPage, beginRow, searchWord);
			
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

					<li class="sidebar-item active">
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
					<li class="sidebar-item">
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
				<form class="d-none d-sm-inline-block" action="<%=request.getContextPath()%>/client/clientList.jsp" method="post">
					<div class="input-group input-group-navbar">
						<input type="hidden" name="rowPerPage" value="<%=rowPerPage%>">
						<input type="text" class="form-control" placeholder="searchWord" aria-label="Search" name="searchWord">
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
							<h3><strong>Client</strong>&nbsp;List</h3>
						</div>
					</div>
					
					<div class="row">
						<div class="col-12 col-xl-6">
							<div class="card flex-fill">
								<div class="card-header">
									<!-- 몇 페이지씩 보여줄 지 결정해주는 페이지 -->
									<form action="<%=request.getContextPath()%>/client/clientList.jsp" method="post">
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
									</form>
								</div>
								<table class="table table-hover my-0">
									<thead>
										<tr>
											<th>clientEmail</th>
											<th>clientDate</th>
											<th>Update</th>
											<th>Delete</th>
										</tr>
									</thead>
									<tbody>
									<%
										for(Client c : list){
						
									%>
										<tr>
											<td><%=c.getClientMail()%></td>
											<td><%=c.getClientDate()%></td>
											<td><a href="<%=request.getContextPath()%>/client/updateClientForm.jsp?clientNo=<%=c.getClientNo()%>"><button type="button" class="btn btn-primary btn-sm">Update</button></a></td>
											<td><a href="<%=request.getContextPath()%>/client/deleteClientAction.jsp?clientNo=<%=c.getClientNo()%>"><button type="button" class="btn btn-primary btn-sm">Delete</button></a></td>
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
									<a href="<%=request.getContextPath()%>/client/clientList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>"><button class="btn btn-primary btn-sm"><i class="align-middle" data-feather="chevrons-left"></i></button></a>
								<%
									}
								
									int lastPage = totalRow / rowPerPage; // 마지막 페이지 초기화
									
									if(totalRow % rowPerPage != 0){ // 나머지가 있으면 한 페이지 추가
										lastPage += 1;
									}
									System.out.println("lastPage : " + lastPage); // 라스트 페이지 잘 나오는지 디버깅
										
									if(currentPage < lastPage){
								%>
									<a href="<%=request.getContextPath()%>/client/clientList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>"><button class="btn btn-primary btn-sm"><i class="align-middle" data-feather="chevrons-right"></i></button></a>
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