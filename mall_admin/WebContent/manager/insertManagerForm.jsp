<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>managerInsertForm</title>
</head>
<body>
	<div>
		<a href="<%=request.getContextPath()%>/adminIndex.jsp">관리자 홈</a>
	</div>
	<h1>메니저 등록</h1>
	<form action="<%=request.getContextPath()%>/manager/insertManagerAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>manager_id</td>
				<td><input type="text" name="managerId" pattern="^([a-z0-9_]){6,16}$" placeholder="6~16자, 영문, 숫자" required></td>
			</tr>
			<tr>
				<td>manager_pw</td>
				<td><input type="password" name="managerPw" pattern="^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*()_-+=[]{}~?:;`|/]).{6,50}$" placeholder="영문 대소문자, 숫자, 특수문자를 꼭 포함하여 6~50자"required></td>
			</tr>
			<tr>
				<td>manager_name</td>
				<td><input type="text" name="managerName" pattern="^([a-z0-9_]){6,10}$" placeholder="6~16자, 영문, 숫자" required></td>
			</tr>
		</table>
		<button type="submit">매니저 등록</button>
	</form>
</body>
</html>