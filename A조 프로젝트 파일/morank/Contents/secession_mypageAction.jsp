<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	//회원탈퇴에 대한 검증이 이루어지는 페이지
	request.setCharacterEncoding("UTF-8"); //사용자에게 받은 데이터를 변경
	//입력 받은 회원
	String userid = null;
	String pwd = null;
	String repwd = null;
	String inputUserid = null;
	//회원 세션 유지
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
	// 비 로그인시 접근 방지
	if (userid == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
		script.close();
	}
	// 입력 받은 비밀번호를 넣어줌
	if (request.getParameter("pwd") != null) {
		pwd = request.getParameter("pwd");
	}
	// 입력 받은 아이디를 넣어줌
	if (request.getParameter("inputUserid") != null) {
		inputUserid = request.getParameter("inputUserid");
	}
	// 입력 받은 비밀번호 확인을 넣어줌
	if (request.getParameter("repwd") != null) {
		repwd = request.getParameter("repwd");
	}

	// 현재 로그인 중인 아이디와 입력한 아이디 또는 비밀번호와 비밀번호 확인 정보가 틀릴 시 방지
	if (!userid.equals(inputUserid) || !pwd.equals(repwd)){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력 정보가 틀립니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
	}
	// 변수에 세션을 넣어주어 secession_mypageAction2.jsp 페이지로 이동
	else {
		session.setAttribute("inputUserid", inputUserid);
		session.setAttribute("repwd", repwd);
		session.setAttribute("pwd", pwd);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'secession_mypageAction2.jsp'");
		script.println("</script>");
		script.close();
	}
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
</body>
</html>