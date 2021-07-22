<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import="java.io.PrintWriter" %>
<%
	// 이전페이지에서 전달받은 아이디 정보와 비밀번호 정보를 담을 변수
	request.setCharacterEncoding("UTF-8"); //사용자에게 받은 데이터를 변경
	String userid=null;
	String pwd=null;
	// 아이디와 비밀번호를 저장
	if (request.getParameter("userid") != null){
		userid = request.getParameter("userid");
	}
	if (request.getParameter("pwd") != null){
		pwd = request.getParameter("pwd");
	}
	
	// 아이디와 비밀번호를 입력하지 않았을 시 리턴
	if (userid==null || pwd==null ){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	}
	//로그인을 하기위한 유저 객체를 생성
	UserDAO userDAO = new UserDAO();
	//로그인 메소드에 유저아이디와 비밀번호를 넣어 데이터베이스에서 일치여부 확인
	int result = userDAO.login(userid, pwd);
	//일치시 유저 아이디 세션 유지후 인덱스
	if (result == 1){
		session.setAttribute("userid", userid);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
	}
	// 비밀번호 오류시
	else if (result==0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
	}
	// 아이디 오류시
	else if (result==-1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않은 아이디 입니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
	}
	// 데이터베이스 오류시
	else if (result==-2) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다.')");
		script.println("history.back()");
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