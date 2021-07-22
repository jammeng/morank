<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="service.ServiceDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	// 관리자가 문의글 답변을 작성할 때 데이터베이스에 내용을 저장하는 페이지
	request.setCharacterEncoding("UTF-8");
	// 유저정보 세션 유지
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
	// 비 로그인시 접근시을 방지
	if (userid == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('잘못된 접근 입니다.)");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
		script.close();
	}
	// 유저 정보를 불러올 객체 생성
	UserDAO userDAO = new UserDAO();
	// 유저 정보를 자바빈즈에 넣어줌
	UserDTO user = userDAO.getuser(userid);
	// 관리자 계정이 아닐 시을 방지
	if (user.getUserAvailable()!=1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('잘못된 접근 입니다.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
		script.close();
	}
	// 게시물 정보를 가져옴
	String scid = null;
	if (session.getAttribute("scid") != null) {
		scid = (String) session.getAttribute("scid");
	}
	// 입력 받은 답변을 담아줌
	String answer = null;
	
	if (request.getParameter("answer") != null){
		answer = request.getParameter("answer");
	}
	// 게시물 객체를 생성
	ServiceDAO service = new  ServiceDAO();
	// 게시물의 아이디와 답변을 데이터베이스에 전달해주는 메소드 실행
	int result = service.answer(answer, scid);
	// 데이터베이스 오류
	if (result == -1){
		PrintWriter outter = response.getWriter();
		outter.println("<script>");
		outter.println("alert('데이터베이스 오류')");
		outter.println("history.back()");
		outter.println("</script>");
	}
	// 완료
	else {
		PrintWriter outter = response.getWriter();
		outter.println("<script>");
		outter.println("alert('답변 완료')");
		outter.println("location.href = 'serviceQnA.jsp'");
		outter.println("</script>");
	}
	%>
</body>
</html>