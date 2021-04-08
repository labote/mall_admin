<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="gdu.mall.util.*" %>
<%@ page import="java.sql.*" %>
<%
	//레벨이 1보다 작으면 권한이 없으므로 adminIndex 페이지로 돌아간다.
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

	<title>InsertEbookForm</title>

	<link href="../css/app.css" rel="stylesheet">
</head>

<body>
	<%
		// 수집
		int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		String ebookISBN = request.getParameter("ebookISBN");
		
		System.out.println("ebookISBN : " + ebookISBN); // ISBN 값 잘 받아오는지 디버깅
		System.out.println("rowPerPage : " + rowPerPage);
		// Dao 안에 있는 selectEbookOne 메서드 호출
		Ebook ebook = EbookDao.selectEbookOne(ebookISBN);
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

					<li class="sidebar-item active">
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
							<h3><strong>Ebook</strong>&nbsp;One</h3>
						</div>
					</div>
					
					<div class="row">
						<div class="col-12 col-xl-6">
							<div class="card flex-fill">
								<div class="card-header">
									<div>
										<table class="table table-hover my-0 table-bordered">
											<tr>
												<td>ebookISBN</td>
												<td><%=ebook.getEbookISBN()%></td>
												<td></td>
											</tr>
											<tr>
												<td>categoryName</td>
												<td><%=ebook.getCategoryName()%></td>
												<td></td>
											</tr>
											<tr>
												<td>ebookTitle</td>
												<td><%=ebook.getEbookTitle()%></td>
												<td></td>
											</tr>
											<tr>
												<td>ebookState</td>
												<td><%=ebook.getEbookState()%></td>
												<td><a href="<%=request.getContextPath()%>/ebook/updateEbookStateForm.jsp?ebookISBN=<%=ebook.getEbookISBN()%>&rowPerPage=<%=rowPerPage%>" class="btn btn-primary btn-sm">Update</a></td>
											</tr>
											<tr>
												<td>ebookAuthor</td>
												<td><%=ebook.getEbookAuthor()%></td>
												<td></td>
											</tr>
											<tr>
												<td>ebookImg</td>
												<td><img src="<%=request.getContextPath()%>/img/<%=ebook.getEbookImg()%>"></td>
												<td><a href="<%=request.getContextPath()%>/ebook/updateEbookImgForm.jsp?ebookISBN=<%=ebook.getEbookISBN()%>&rowPerPage=<%=rowPerPage%>" class="btn btn-primary btn-sm">Update</a></td>
											</tr>
											<tr>
												<td>ebookCompany</td>
												<td><%=ebook.getEbookCompany()%></td>
												<td></td>
											</tr>
											<tr>
												<td>ebookPageCount</td>
												<td><%=ebook.getEbookPageCount()%></td>
												<td></td>
											</tr>
											<tr>
												<td>ebookPrice</td>
												<td><%=ebook.getEbookPrice()%></td>
												<td></td>
											</tr>
											<tr>
												<td>ebookDate</td>
												<td><%=ebook.getEbookDate()%></td>
												<td></td>
											</tr>
											
											<tr>
												<td>ebookSummary</td>
												<td><%=ebook.getEbookSummary()%></td>
												<td><a href="<%=request.getContextPath()%>/ebook/updateEbookSummaryForm.jsp?ebookISBN=<%=ebook.getEbookISBN()%>&rowPerPage=<%=rowPerPage%>" class="btn btn-primary btn-sm">Update</a></td>
											</tr>
										</table>
									</div>
									<br>
									<div>
										<a href="<%=request.getContextPath()%>/ebook/updateEbookOneForm.jsp?ebookISBN=<%=ebook.getEbookISBN()%>&rowPerPage=<%=rowPerPage%>" class="btn btn-primary btn-sm">Update</a>
										<a href="<%=request.getContextPath()%>/ebook/deleteEbookOneAction.jsp?ebookISBN=<%=ebook.getEbookISBN()%>&rowPerPage=<%=rowPerPage%>" class="btn btn-primary btn-sm">Delete</a>
										<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?rowPerPage=<%=rowPerPage%>" class="btn btn-primary btn-sm">Cancel</a>
									</div>
								</div>
							</div>
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