<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.util.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateClientForm</title>
</head>
<body>
<%
	int clientNo = Integer.parseInt(request.getParameter("clientNo"));
	System.out.println(clientNo); // 디버깅
	
	// sql문
	String sql = "select client_mail clientMail, date_format(client_date,'%Y-%m-%d') clientDate from client where client_no = ?";
	
	// DB 연결 및 SQL 실행
	Connection conn = DBUtil.getConnection();
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, clientNo);
	System.out.println(stmt + " <--login() sql"); // sql문 실행 디버깅
	
	ResultSet rs = stmt.executeQuery();
	
	String clientEmail = null;
	String clientDate = null;
	
	if(rs.next()){
		clientEmail = rs.getString("clientMail");
		clientDate = rs.getString("clientDate");
	}
	
	System.out.println("clientEmail : "+clientEmail); // 이메일 잘 가져오는지 디버깅
	System.out.println("clientDate : "+clientDate); // 날짜 잘 가져오는지 디버깅
%>
	<h1>비밀번호 수정</h1>
	<form action="<%=request.getContextPath()%>/client/updateClientAction.jsp?clientNo=<%=clientNo%>" method="post">
		<table border="1">
			<thead>
				<tr>
					<th>clientEmail</th>
					<th>clientDate</th>
					<th>clientPw</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><%=clientEmail %></td>
					<td><%=clientDate %></td>
					<td><input type="password" name="clientPw" placeholder="변경할 비밀번호 입력"></td>
				</tr>
			</tbody>
		</table>
		<button type="submit">수정</button>
		<button type="button" onclick="history.back()">취소</button>
	</form>
</body>
</html>