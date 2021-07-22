<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="service.ServiceDAO"%>
<%@ page import="service.ServiceDTO"%>
<%@page import="user.UserDAO"%>

<%

	// 문의 글 작성 이 이루어지는 페이지
	request.setCharacterEncoding("UTF-8");
	// 로그인 세션 유지
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
	}
	// 비로그인시 접근 방지
	if (userid == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인하세요')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
		script.close();
	}
	// 입력 받은 문의글 제목 내용 카테고리를 담아줄 변수
	String scTitle = null;
	String scContent= null;
	String classified=null;
	// 변수에 값을 넣어줌
	if (request.getParameter("scTitle") != null){
		scTitle = request.getParameter("scTitle");
	}
	if (request.getParameter("scContent") != null){
		scContent = request.getParameter("scContent");
	}
	if (request.getParameter("classified") != null){
		classified = request.getParameter("classified");
	}
	// 값이 없을 시를 방지
	if (scTitle == null || scContent == null ){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	}
	// 데이터베이스에 정보글을 전송해줄 객체 생성
	ServiceDAO ServiceDAO = new ServiceDAO();
	// 데이터베이스에 정보글을 정송해줄 메소드 실행
	int result = ServiceDAO.write(new ServiceDTO(0, scTitle, userid, scContent, 1, ServiceDAO.getDate(), 0,0,classified,null));
	if (result == -1){
		// 디비 오류
		PrintWriter outter = response.getWriter();
		outter.println("<script>");
		outter.println("alert('글쓰기에 실패 했습니다.')");
		outter.println("history.back()");
		outter.println("</script>");
	}
	else {// 저장 완료
		PrintWriter outter = response.getWriter();
		outter.println("<script>");
		outter.println("location.href = 'serviceQnA.jsp'");
		outter.println("</script>");
	}
	
	%>
	
	

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
</body>
</html>