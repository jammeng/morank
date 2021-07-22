<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	//로그아웃을 담당하는 페이지
	//모든 세션을 닫아줌
	session.invalidate();
	%>

	<script>
		location.href = "index.jsp";
	</script>

</body>
</html>