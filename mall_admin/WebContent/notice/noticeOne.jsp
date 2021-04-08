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
		int noticeNo = Integer.parseInt(request.getParameter("noticeNo")); // 앞 jsp에서 넘어온 noticeNo값을 받아온다.
		int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		
		System.out.println(noticeNo); // 받아온 값 디버깅
		System.out.println(rowPerPage);
		
		Notice n = NoticeDao.selectNoticeOne(noticeNo);
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
				<div class="navbar-collapse collapse">
					<ul class="navbar-nav navbar-align">
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle d-none d-sm-inline-block" href="#" data-toggle="dropdown">
					           	<span class="text-dark"><%=manager.getManagerLevel()%>레벨&nbsp;<%=manager.getManagerId()%>님</span>
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
							<h3><strong>Notice</strong>&nbsp;One</h3>
						</div>
					</div>
					
					<div class="row">
						<div class="col-12 col-xl-6">
							<div class="card flex-fill">
								<div class="card-header">
									<table class="table table-hover my-0 table-bordered">
										<tr>
											<td>noticeNo</td>
											<td><%=n.getNoticeNo()%></td>
										</tr>
										<tr>
											<td>noticeTitle</td>
											<td><%=n.getNoticeTitle()%></td>
										</tr>
										<tr>
											<td>noticeContent</td>
											<td><textarea rows="5" cols="60"><%=n.getNoticeContent()%></textarea></td>
										</tr>
										<tr>
											<td>noticeDate</td>
											<td><%=n.getNoticeDate()%></td>
										</tr>
										<tr>
											<td>managerId</td>
											<td><%=n.getManagerId()%></td>
										</tr>
									</table>
								</div>
								<div class="card-body">
									<a href="<%=request.getContextPath()%>/notice/updateNoticeOneForm.jsp?rowPerPage=<%=rowPerPage%>&noticeNo=<%=noticeNo%>" class="btn btn-primary btn-sm">Update</a>
									<a href="<%=request.getContextPath()%>/notice/deleteNoticeAction.jsp?noticeNo=<%=noticeNo%>&rowPerPage=<%=rowPerPage%>" class="btn btn-primary btn-sm">Delete</a>
									<a href="<%=request.getContextPath()%>/notice/noticeList.jsp?rowPerPage=<%=rowPerPage%>" class="btn btn-primary btn-sm">Cancel</a>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-12 col-xl-6">
							<div class="card">
								<div class="card-header">
									<h5 class="card-title">Comment</h5>
								</div>
								<div class="card-body">
									<form action="<%=request.getContextPath()%>/notice/insertCommentAction.jsp" method="post">
										<input type="hidden" name="noticeNo" value="<%=n.getNoticeNo()%>">
										<input type="hidden" name="rowPerPage" value="<%=rowPerPage%>">
										<div class="mb-3">
											<label class="form-label">ID : </label>
											<input type="text" name="managerId" value="<%=manager.getManagerId()%>" readonly="readonly">
										</div>
										<div class="mb-3">
											<textarea name="commentContent" rows="2" cols="60" maxlength="100" required></textarea>
										</div>
										<button type="submit" class="btn btn-primary btn-sm">Submit</button>
									</form>
								</div>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-12 col-xl-6">
							<div class="card flex-fill">
								<%
									ArrayList<Comment> commentList = CommentDao.selectCommentListByNoticeNo(noticeNo);
						
									for(Comment c : commentList){
								%>
								<table class="table table-hover my-0 table-bordered">
									<tr>
										<td><%=c.getCommentDate()%></td>
										<td><%=c.getManagerId()%></td>
										<td><a href="<%=request.getContextPath()%>/notice/deleteCommentAction.jsp?commentNo=<%=c.getCommentNo()%>&managerId=<%=manager.getManagerId()%>&rowPerPage=<%=rowPerPage%>&noticeNo=<%=noticeNo%>" class="btn btn-primary btn-sm">Delete</a></td>
									</tr>
									<tr>
										<td colspan="3"><textarea rows="2" cols="60"><%=c.getCommentContent()%></textarea></td>
									</tr>
								</table>
								<%
									}
								%>
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