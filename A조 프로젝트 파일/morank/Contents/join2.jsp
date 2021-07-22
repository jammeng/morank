<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<title>회원가입 기본정보 입력</title>
<link rel="stylesheet" href="css/join2.css">
</head>
<body>
	<%
	// 회원가입 페이지 (2)
	// 유저 세션 정보를 가져와 로그인 시 접근을 제한 하기위함
	String userid = null;
	if (session.getAttribute("userid") != null) {
		userid = (String) session.getAttribute("userid");
	}
	if (userid != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 된 상태 입니다.')");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
	}
	%>
	<div id="wrapper">
		<div class="logo">
			<a href="index.jsp"><img src="images/모두의랭킹6.png" alt=""></a>
		</div>
		<!-- 입력한 회원 정보를 userRegisterAction.jsp 페이지로 전달해 회원가입 진행 -->
		<form action="userRegisterAction.jsp">
			<div class="button">
				<img src="images/join_button_off.png" alt=""> <img
					src="images/join_button.png" alt=""> <img
					src="images/join_button_off.png" alt=""> <img
					src="images/join_button_off.png" alt="">
			</div>
			<p class="title">기본정보 입력</p>
			<hr>
			<div class="account_info">
				<!-- <h4>아이디</h4> -->
				<span>아이디</span><input type="text" class="id" name="userid" placeholder="아이디"
					maxlength="50"><br>
				<!-- <h4>비밀번호</h4> -->
				<span>비밀번호</span><input type="password" class="password" name="pwd"
					placeholder="비밀번호" maxlength="20"><br>
				<!-- <h4>비밀번호 확인</h4> -->
				<span>비밀번호 확인</span><input type="password" class="password" name="review"
					placeholder="비밀번호 확인" maxlength="20"><br>
				<!-- <h4>이메일</h4> -->
				<span>이메일</span><input type="text" class="password" name="email"
					placeholder="이메일" maxlength="50"><br>
				<!-- <h4>닉네임</h4> -->
				<span>닉네임</span><input type="text" class="nickname" name="nixname"
					placeholder="닉네임" maxlength="20">
			</div>
			<input type="submit" class="confirm" name="" value="확인">
			<button type="button" class="cancle" name="button"
				onclick="location.href='index.jsp'">취소</button>
		</form>
	</div>
	<footer>Changju Co.</footer>
</body>
</html>