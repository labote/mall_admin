<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="Responsive Admin &amp; Dashboard Template based on Bootstrap 5">
	<meta name="author" content="AdminKit">
	<meta name="keywords" content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">

	<link rel="shortcut icon" href="img/icons/icon-48x48.png" />

	<title>adminIndex</title>

	<link href="css/app.css" rel="stylesheet">
</head>

<body>
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

					<li class="sidebar-item active">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/adminIndex.jsp">
           				<i class="align-middle" data-feather="sliders"></i> <span class="align-middle">Index</span>
         		    </a>
					</li>
			<%
				if(session.getAttribute("sessionManager") != null) {
			%>
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
			<%
				}
			%>
				<!-- <div class="sidebar-cta">
					<div class="sidebar-cta-content">
						<strong class="d-inline-block mb-2">Upgrade to Pro</strong>
						<div class="mb-3 text-sm">
							Are you looking for more components? Check out our premium version.
						</div>
						<a href="https://adminkit.io/pricing" target="_blank" class="btn btn-primary btn-block">Upgrade to Pro</a>
					</div>
				</div> -->
			</div>
		</nav>

		<div class="main">
			<nav class="navbar navbar-expand navbar-light navbar-bg">
				<a class="sidebar-toggle d-flex">
         			 <i class="hamburger align-self-center"></i>
       			</a>

				<div class="navbar-collapse collapse">
					<ul class="navbar-nav navbar-align">
						<%
							if(session.getAttribute("sessionManager") != null){
								Manager manager = (Manager)(session.getAttribute("sessionManager"));
						%>
						
							<li class="nav-item dropdown">
								<a class="nav-link dropdown-toggle d-none d-sm-inline-block" href="#" data-toggle="dropdown">
					            	<span class="text-dark"><%=manager.getManagerLevel()%>레벨&nbsp;<%=manager.getManagerId()%>님</span>
					            </a>
								<div class="dropdown-menu dropdown-menu-right">
									<a class="dropdown-item" href="<%=request.getContextPath()%>/manager/logoutManagerAction.jsp">Log out</a>
								</div>
							</li>
						<%	
							}
						%>
					</ul>
				</div>
			</nav>
		<%
			if(session.getAttribute("sessionManager") == null) {
		%>
				<main class="content">
					<div class="container-fluid p-0">
	
						<div class="row mb-2 mb-xl-3">
							<div class="col-auto d-none d-sm-block">
								<h3><strong>Waiting for</strong> approval</h3>
							</div>
						</div>
						<%		
							ArrayList<Manager> list = ManagerDao.selectManagerListByZero();
						%>
						
						<div class="row">
							<div class="col-12 col-md-6 col-xxl-3 d-flex order-2 order-xxl-3">
								<div class="card flex-fill">
									<div class="card-header">
	
										<h5 class="card-title mb-0">Please wait for approval</h5>
									</div>
									<table class="table table-hover my-0">
										<thead>
											<tr>
												<th>Name</th>
												<th> Date</th>
											</tr>
										</thead>
										<tbody>
											<%
												for(Manager m : list) {
											%>
													<tr>
														<td class="d-none d-xl-table-cell"><%=m.getManagerId() %></td>
														<td class="d-none d-xl-table-cell"><%=m.getManagerDate().substring(0,10)%></td>
													</tr>
											<%		
												}
											%>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						
						<h1 class="h3 mb-3">Please login if you want to manage data</h1>
	
						<div class="row">
							<div class="col-12 col-md-6 col-xxl-3 d-flex order-2 order-xxl-3">
								<div class="card">
									<div class="card-header">
										<h5 class="card-title">Please enter Id and Pw</h5>
									</div>
									<div class="card-body">
										<form action="<%=request.getContextPath()%>/manager/loginManagerAction.jsp" method="post">
											<div class="mb-3">
												<label class="form-label">Enter Id</label>
												<input type="text" class="form-control" placeholder="Id" name="managerId">
											</div>
											<div class="mb-3">
												<label class="form-label">Enter Password</label>
												<input type="password" class="form-control" placeholder="Password" name="managerPw">
											</div>
	
											<button type="submit" class="btn btn-primary btn-sm">Submit</button>
											<a href="<%=request.getContextPath()%>/manager/insertManagerForm.jsp">&nbsp;register</a>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</main>
		<%
			} else {
				Manager manager = (Manager)(session.getAttribute("sessionManager"));
				
				ArrayList<Notice> noticeList = NoticeDao.selectNoticeListByPage(5,0,"");
				ArrayList<Manager> managerList = ManagerDao.selectManagerListByPage(5,0);
				ArrayList<Ebook> ebookList = EbookDao.selectEbookListByPage(5,0);
				ArrayList<Client> clientList = ClientDao.selectClientListByPage(5, 0);
				ArrayList<OrdersAndEbookAndClient> oecList = OrdersDao.ordersList(5, 0);
		%>
				<main class="content">
					<div class="container-fluid p-0">
	
						<div class="row mb-2 mb-xl-3">
							<div class="col-auto d-none d-sm-block">
								<h3><strong>Welcome</strong>&nbsp;<%=manager.getManagerName()%></h3>
							</div>
						</div>
						
						<div class="row">
							<div class="col-12 col-md-6 col-xxl-3 d-flex order-2 order-xxl-3">
								<div class="card flex-fill">
									<div class="card-header">
	
										<h5 class="card-title mb-0">NoticeList&nbsp;<a href="<%=request.getContextPath()%>/notice/noticeList.jsp"><i class="align-middle" data-feather="edit-2"></i></a></h5>
									</div>
									<table class="table table-hover my-0">
										<thead>
											<tr>
												<th>NoticeTitle</th>
												<th>ManagerId</th>
											</tr>
										</thead>
										<tbody>
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
										</tbody>
									</table>
								</div>
							</div>
							<div class="col-12 col-md-6 col-xxl-3 d-flex order-2 order-xxl-3">
								<div class="card flex-fill">
									<div class="card-header">
	
										<h5 class="card-title mb-0">ManagerList&nbsp;<a href="<%=request.getContextPath()%>/manager/managerList.jsp"><i class="align-middle" data-feather="edit-2"></i></a></h5>
									</div>
									<table class="table table-hover my-0">
										<thead>
											<tr>
												<th>ManagerId</th>
												<th>ManagerName</th>
											</tr>
										</thead>
										<tbody>
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
										</tbody>
									</table>
								</div>
							</div>
							<div class="col-12 col-md-6 col-xxl-3 d-flex order-2 order-xxl-3">
								<div class="card flex-fill">
									<div class="card-header">
	
										<h5 class="card-title mb-0">EbookList&nbsp;<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp"><i class="align-middle" data-feather="edit-2"></i></a></h5>
									</div>
									<table class="table table-hover my-0">
										<thead>
											<tr>
												<th>EbookTitle</th>
												<th>EbookPrice</th>
											</tr>
										</thead>
										<tbody>
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
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-12 col-md-6 col-xxl-3 d-flex order-2 order-xxl-3">
								<div class="card flex-fill">
									<div class="card-header">
	
										<h5 class="card-title mb-0">ClientList&nbsp;<a href="<%=request.getContextPath()%>/client/clientList.jsp"><i class="align-middle" data-feather="edit-2"></i></a></h5>
									</div>
									<table class="table table-hover my-0">
										<thead>
											<tr>
												<th>ClientEmail</th>
												<th>Date</th>
											</tr>
										</thead>
										<tbody>
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
										</tbody>
									</table>
								</div>
							</div>
							<div class="col-12 col-md-6 col-xxl-3 d-flex order-2 order-xxl-3">
								<div class="card flex-fill">
									<div class="card-header">
	
										<h5 class="card-title mb-0">OrdersList&nbsp;<a href="<%=request.getContextPath()%>/orders/ordersList.jsp"><i class="align-middle" data-feather="edit-2"></i></a></h5>
									</div>
									<table class="table table-hover my-0">
										<thead>
											<tr>
												<th>OrdersNo</th>
												<th>BookTitle</th>
												<th>ClientEmail</th>
											</tr>
										</thead>
										<tbody>
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
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</main>
		<%
			}
		%>
			<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF">
				Copyright &copy; 2021 홍민성 All Rights Reserved.
			</footer>
		</div>
	</div>

	<script src="js/app.js"></script>

	<script>
		document.addEventListener("DOMContentLoaded", function() {
			var ctx = document.getElementById("chartjs-dashboard-line").getContext("2d");
			var gradient = ctx.createLinearGradient(0, 0, 0, 225);
			gradient.addColorStop(0, "rgba(215, 227, 244, 1)");
			gradient.addColorStop(1, "rgba(215, 227, 244, 0)");
			// Line chart
			new Chart(document.getElementById("chartjs-dashboard-line"), {
				type: "line",
				data: {
					labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
					datasets: [{
						label: "Sales ($)",
						fill: true,
						backgroundColor: gradient,
						borderColor: window.theme.primary,
						data: [
							2115,
							1562,
							1584,
							1892,
							1587,
							1923,
							2566,
							2448,
							2805,
							3438,
							2917,
							3327
						]
					}]
				},
				options: {
					maintainAspectRatio: false,
					legend: {
						display: false
					},
					tooltips: {
						intersect: false
					},
					hover: {
						intersect: true
					},
					plugins: {
						filler: {
							propagate: false
						}
					},
					scales: {
						xAxes: [{
							reverse: true,
							gridLines: {
								color: "rgba(0,0,0,0.0)"
							}
						}],
						yAxes: [{
							ticks: {
								stepSize: 1000
							},
							display: true,
							borderDash: [3, 3],
							gridLines: {
								color: "rgba(0,0,0,0.0)"
							}
						}]
					}
				}
			});
		});
	</script>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			// Pie chart
			new Chart(document.getElementById("chartjs-dashboard-pie"), {
				type: "pie",
				data: {
					labels: ["Chrome", "Firefox", "IE"],
					datasets: [{
						data: [4306, 3801, 1689],
						backgroundColor: [
							window.theme.primary,
							window.theme.warning,
							window.theme.danger
						],
						borderWidth: 5
					}]
				},
				options: {
					responsive: !window.MSInputMethodContext,
					maintainAspectRatio: false,
					legend: {
						display: false
					},
					cutoutPercentage: 75
				}
			});
		});
	</script>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			// Bar chart
			new Chart(document.getElementById("chartjs-dashboard-bar"), {
				type: "bar",
				data: {
					labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
					datasets: [{
						label: "This year",
						backgroundColor: window.theme.primary,
						borderColor: window.theme.primary,
						hoverBackgroundColor: window.theme.primary,
						hoverBorderColor: window.theme.primary,
						data: [54, 67, 41, 55, 62, 45, 55, 73, 60, 76, 48, 79],
						barPercentage: .75,
						categoryPercentage: .5
					}]
				},
				options: {
					maintainAspectRatio: false,
					legend: {
						display: false
					},
					scales: {
						yAxes: [{
							gridLines: {
								display: false
							},
							stacked: false,
							ticks: {
								stepSize: 20
							}
						}],
						xAxes: [{
							stacked: false,
							gridLines: {
								color: "transparent"
							}
						}]
					}
				}
			});
		});
	</script>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			var markers = [{
					coords: [31.230391, 121.473701],
					name: "Shanghai"
				},
				{
					coords: [28.704060, 77.102493],
					name: "Delhi"
				},
				{
					coords: [6.524379, 3.379206],
					name: "Lagos"
				},
				{
					coords: [35.689487, 139.691711],
					name: "Tokyo"
				},
				{
					coords: [23.129110, 113.264381],
					name: "Guangzhou"
				},
				{
					coords: [40.7127837, -74.0059413],
					name: "New York"
				},
				{
					coords: [34.052235, -118.243683],
					name: "Los Angeles"
				},
				{
					coords: [41.878113, -87.629799],
					name: "Chicago"
				},
				{
					coords: [51.507351, -0.127758],
					name: "London"
				},
				{
					coords: [40.416775, -3.703790],
					name: "Madrid "
				}
			];
			var map = new JsVectorMap({
				map: "world",
				selector: "#world_map",
				zoomButtons: true,
				markers: markers,
				markerStyle: {
					initial: {
						r: 9,
						strokeWidth: 7,
						stokeOpacity: .4,
						fill: window.theme.primary
					},
					hover: {
						fill: window.theme.primary,
						stroke: window.theme.primary
					}
				}
			});
			window.addEventListener("resize", () => {
				map.updateSize();
			});
		});
	</script>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			document.getElementById("datetimepicker-dashboard").flatpickr({
				inline: true,
				prevArrow: "<span class=\"fas fa-chevron-left\" title=\"Previous month\"></span>",
				nextArrow: "<span class=\"fas fa-chevron-right\" title=\"Next month\"></span>",
			});
		});
	</script>

</body>

</html>