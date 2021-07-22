<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="user.UserDTO"%>
<%@page import="user.UserDAO"%>
<%@page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	// 문의글 답변이 이루어지는 페이지
	// 로그인 세션 유지
	String userid = null;
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
	// 비 로그인 시 접근을 방지 
	if (userid == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	}
	// 게시물 아이디 변수
	String scid = null;
	// 전달받은 게시물 아이디 변수를 넣어줌
	if (session.getAttribute("scid") != null) {
		scid = (String) session.getAttribute("scid");
	}
	// 유저 데이터를 가져올 객체를 생성
	UserDAO userDAO = new UserDAO();
	UserDTO user = userDAO.getuser(userid);
	// 관리자 계정이 아닐 시 접근을 방지
	if (user.getUserAvailable()!=1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('잘못된 접근 입니다.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	}
	%>
	<!-- 답글의 내용을 QnA_AnswerAction.jsp 페이지에 전달 -->
	<form action="QnA_AnswerAction.jsp" medhod="post">
		<div>
			<h4>답글</h4>
			<textarea name="answer" rows="8" cols="80" maxlength="2048" autofocus /></textarea>
		</div>
			<input type="submit" class="confirm" value="확인">
			<button type="button" class="cancle" name="button" onclick="location.href='serviceCenter.jsp'">취소</button>
	</form>
</body>
</html>