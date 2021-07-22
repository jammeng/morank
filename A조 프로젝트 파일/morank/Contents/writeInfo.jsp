<%@page import="user.UserDTO"%>
<%@page import="user.UserDAO"%>
<%@page import="java.io.PrintWriter"%>
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
	// 검색정보를 저장할 관리자 페이지
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
	}// 비 로그인 시 방지
	if (userid == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
		script.close();
	}
	// 회원 정보를 가져올 객체 생성
	UserDAO userDAO = new UserDAO();
	UserDTO user = userDAO.getuser(userid);
	// 잘못된 접근을 방지하기 위함
	if (user.getUserAvailable() != 1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('잘못된 접근 입니다.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
		script.close();
	}
	%>
	<!-- 카테고리 정보를 WriteinfoAction.jsp 페이지로 전달해줌 -->
	<form action="WriteinfoAction.jsp" medhod="post">
		<div>
			<h4>카테고리(대)</h4>
			<input type="text" class="id" name=BigC_id placeholder="카테고리(대)" maxlength="10">
			<h4>카테고리(소)</h4>
			<input type="text" class="id" name="SmallC_id" placeholder="카테고리(소" maxlength="10">
			<h4>정보제목</h4>
			<input type="text" class="id" name="info_name" placeholder="정보제목" maxlength="20">
			<h4>키워드(쓸때 키워드 앞에 띄어쓰기=#)</h4>
			<textarea name="keyword" rows="8" cols="80" maxlength="400" autofocus /></textarea>
			<h4>제작사</h4>
			<input type="text" class="id" name="producer" placeholder="제작사" maxlength="50">
			<h4>정보내용</h4>
			<textarea name="info_content" rows="8" cols="80" maxlength="4000" autofocus /></textarea>
		</div>
		<input type="submit" class="confirm" value="확인">
		<button type="button" class="cancle" name="button"
			onclick="location.href='search.jsp'">취소</button>
	</form>
</body>
</html>