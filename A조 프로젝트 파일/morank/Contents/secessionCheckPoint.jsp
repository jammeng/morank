<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	// 회원 탈퇴 동의 값을 변수 생성 후 넣어줌	
	String checkPoint = request.getParameter("checkPoint");
	// 회원 탈퇴 동의 체크를 확인해주는 페이지
	String userid = null;
	if (session.getAttribute("userid") != null) {
		userid = (String) session.getAttribute("userid");
		boolean emailChecked = new UserDAO().getUserEmailChecked(userid); //이메일 인증 안될시
		if (emailChecked == false) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'join3.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
	}	// 비로그인 시 접근 방지
	if (userid == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
		script.close();
	}
	// 값이 없을 시 방지
	if (checkPoint == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('약관에 모두 동의해 주세요')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
	} else {// 값이 있으면 회원탈퇴 페이지 이동
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'secession_mypage_Input.jsp'");
		script.println("</script>");
		script.close();
	}
	%>
</body>
</html>