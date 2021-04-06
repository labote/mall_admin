<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%
	//레벨이 1보다 작으면 권한이 없으므로 adminIndex 페이지로 돌아간다.
//	Manager manager = (Manager) session.getAttribute("sessionManager");
//	if(manager == null || manager.managerLevel < 1){
//		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
//		return;
//	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>categoryList</title>
</head>
<body>
	<!-- 페이징 x, 검색어 x -->
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include> <!-- include는 프로젝트명 x,  -->
	</div>
	<h1>CategoryList</h1>
	<%
		// list 생성
		ArrayList<Category> list = CategoryDao.CategoryList();
	%>
	
	<a href="<%=request.getContextPath()%>/category/insertCategoryForm.jsp"><button type="button">카테고리 추가</button></a>
	<table border="1">
		<thead>
			<tr>
				<th>categoryName</th>
				<th>categoryWeight(수정)</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Category c : list){
			%>
					<tr>
						<td><%=c.getCategoryName()%></td>
						<td>
							<form action="<%=request.getContextPath()%>/category/updateCategoryAction.jsp" method="post">
								<input type="hidden" name="categoryName" value="<%=c.getCategoryName()%>">
								<select name="categoryWeight">
									<%
										for(int i=0;i<11;i++){
											if(c.getCategoryWeight() == i){
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
								<button type="submit">수정</button>
							</form>
						</td>
						<td><a href="<%=request.getContextPath()%>/category/deleteCategoryAction.jsp?categoryName=<%=c.getCategoryName()%>"><button type="button">삭제</button></a></td>
					</tr>
			<%
				}
			%>
		</tbody>
	</table>
</body>
</html>