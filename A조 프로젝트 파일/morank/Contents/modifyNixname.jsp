<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	// 닉네임 변경이 이루어지는 페이지
	// 유저 객체 생성
	UserDAO userDAO = new UserDAO();
	request.setCharacterEncoding("UTF-8"); //사용자에게 받은 데이터를 변경
	// 유저아이디를 받을 변수
	String userid = null;
	// 닉네임을 받을 변수
	String nixname = null;
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
	// 비로그인시 접근을 방지
	if (userid == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
		script.close();
	}
	// 전달받은 닉네임을 변수에 넣어줌
	if (request.getParameter("nixname") != null){
		nixname = request.getParameter("nixname");
	}

	// 닉네임 값이 있을 시 데이터베이스에 전달하는 메소드 실행 후 인덱스 이동
	if (nixname != null){
		userDAO.modifyNixname(nixname, userid);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('닉네임 변경 완료')");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}

	
	%>
</body>
</html>