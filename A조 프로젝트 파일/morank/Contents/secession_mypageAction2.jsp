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
	// 회원 탈퇴가 이루어지는 페이지
	// 세션값을 담을 변수들
	String userid = null;
	String pwd = null;
	String repwd = null;
	String inputUserid = null;
	// 로그인 세션 유지
	if(session.getAttribute("userid") != null) {
		userid = (String)session.getAttribute("userid");
		boolean emailChecked = new UserDAO().getUserEmailChecked(userid); //이메일 인증 안될시
		if(emailChecked==false){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'join3.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
	}
	// 비로그인 시 접근 방지
	if (userid == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
		script.close();
	}
	// 세션 값들을 변수에 넣어줌
	if (session.getAttribute("inputUserid") != null) {
		inputUserid = (String) session.getAttribute("inputUserid");
	}
	if (session.getAttribute("repwd") != null) {
		repwd = (String) session.getAttribute("repwd");
	}
	if (session.getAttribute("pwd") != null) {
		pwd = (String) session.getAttribute("pwd");
	}
	// 입력 사항이 없을 시 방지
	if (pwd == null || repwd==null || inputUserid==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('오류')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
		script.close();
	}
	// 유저정보를 비교할 객체 생성
	UserDAO userDAO = new UserDAO();
	// 로그인 메소드 활용
	int result = userDAO.login(userid, pwd);
	//데이터베이스오류
	if (result == 1) {
		int reslt = userDAO.delectUser(inputUserid);
		if (reslt == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
			script.close();
		} else {// 회원 탈퇴 메소드 실행
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원탈퇴에 성공 하였습니다.')");
			script.println("location.href = 'logoutAction.jsp'");
			script.println("</script>");
			script.close();
		}
		// 비밀번호 틀릴 시
	} else if (result == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		// 아이디 틀릴 시
	} else if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('아이디가 없습니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
	}
	// 데이터베이스 오류
	else if (result == -2) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
	}
	%>
</body>
</html>