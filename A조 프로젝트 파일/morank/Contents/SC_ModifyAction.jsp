<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="service.ServiceDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	// 유저 세션 유지
	request.setCharacterEncoding("UTF-8");
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
	// 비로그인시 접근을 방지
	if (userid == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
		script.close();
	}
	// 게시물 정보를 가져옴
	String scid = null;
	if (session.getAttribute("scid") != null) {
		scid = (String) session.getAttribute("scid");
	}
	// 비정상적인 접근을 방지하기 위함
	if (scid == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('잘못된 접근 입니다.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
		script.close();
	}
	// 전달받은 제목, 내용, 카테고리를 담을 변수
	String scTitle = null;
	String scContent= null;
	String classified=null;
	// 전달받은 제목, 내용, 카테고리를 변수에 넣어줌
	if (request.getParameter("scTitle") != null){
		scTitle = request.getParameter("scTitle");
	}
	if (request.getParameter("scContent") != null){
		scContent = request.getParameter("scContent");
	}
	if (request.getParameter("classified") != null){
		classified = request.getParameter("classified");
	}
	// 입력을 하지 않았을시 방지
	if (scTitle == null || scContent == null ){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	}
	// 문의글 등록을 위한 객체 생성
	ServiceDAO serviceDAO = new ServiceDAO();
	// 데이터베이스에 문의글을 등록 해주는 메소드 실행
	int result = serviceDAO.QnA_modify(scTitle, scContent, serviceDAO.getDate(), classified, scid);
	// 데이터베이스 오류
	if (result == -1){
		PrintWriter outter = response.getWriter();
		outter.println("<script>");
		outter.println("alert('데이터베이스 오류')");
		outter.println("history.back()");
		outter.println("</script>");
	}// 수정완료
	else {
		PrintWriter outter = response.getWriter();
		outter.println("<script>");
		outter.println("alert('수정완료')");
		outter.println("location.href = 'serviceQnA.jsp'");
		outter.println("</script>");
	}
	%>
</body>
</html>