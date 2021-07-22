<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="service.ServiceDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	// 게시물 삭제가 이루어지는 페이지
	request.setCharacterEncoding("UTF-8");
	// 아이디 세션 유지
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
	// 게시물 아이디를 가져옴
	String scid = null;
	if (session.getAttribute("scid") != null) {
		scid = (String) session.getAttribute("scid");
	}
	// 비로그인시 접근을 방지하기 위함
	if (userid == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
		script.close();
	}
	// 비정상적인 접근 시
	if (scid == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('잘못된 접근 입니다.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
		script.close();
	}
	// 게시물 객체 생성
	ServiceDAO serviceDAO = new ServiceDAO();
	// 데이터를 삭제해주는 메소드를 실행
	int result = serviceDAO.delectQnA(userid, scid);
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		PrintWriter outter = response.getWriter();
		outter.println("<script>");
		outter.println("alert('삭제 성공')");
		outter.println("location.href = 'serviceQnA.jsp'");
		outter.println("</script>");
	}
	%>

</body>
</html>