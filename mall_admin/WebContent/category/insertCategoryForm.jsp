<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%
	//레벨이 1보다 작으면 권한이 없으므로 adminIndex 페이지로 돌아간다.
	Manager manager = (Manager) session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertCategory</title>
</head>
<body>
	<div>
		<a href="<%=request.getContextPath()%>/adminIndex.jsp">관리자 홈</a>
	</div>
	<h1>카테고리 등록</h1>
	<form action="<%=request.getContextPath()%>/category/insertCategoryAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>categoryName</td>
				<td><input type="text" name ="categoryName"></td>
			</tr>
			<tr>
				<td>categoryWeight</td>
				<td>
					<select name="categoryWeight">
						<%
							for(int i=0;i<11;i++){
						%>
								<option value="<%=i%>"><%=i%></option>
						<%		
							}
						%>
					</select>
				</td>
			</tr>
		</table>
		<button type="submit">카테고리 등록</button>
		<button type="button" onclick="history.back()">취소</button>
	</form>
</body>
</html>