<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>



<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
	// 약관 동의를 담은 변수
	String checkPoint1 = request.getParameter("checkPoint1");
	String checkPoint2 = request.getParameter("checkPoint2");
	String checkPoint3 = request.getParameter("checkPoint3");
	// 약관 동의를 하지 않았을 시
	if (checkPoint1==null || checkPoint2 ==null || checkPoint3 ==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('약관에 모두 동의해 주세요')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
	}
	else {// 동의 했을시 페이지 이동
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'join2.jsp'");
		script.println("</script>");
		script.close();
	}

	
			
	%>
</body>
</html>