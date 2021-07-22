<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import="java.io.PrintWriter" %>
<%
	// 회원 가입 이 이루어지는 페이지
	request.setCharacterEncoding("UTF-8"); //사용자에게 받은 데이터를 변경
	//입력받은 아이디 비밀번호, 비밀번호 확인, 이메일, 닉네임을 담는 변수
	String userid=null;
	String pwd=null;
	String nixname=null;
	String email = null;
	String review = null;
	// 전달받은 값을 변수에 저장
	if (request.getParameter("userid") != null){
		userid = request.getParameter("userid");
	}
	if (request.getParameter("pwd") != null){
		pwd = request.getParameter("pwd");
	}
	if (request.getParameter("nixname") != null){
		nixname = request.getParameter("nixname");
	}
	if (request.getParameter("review") != null){
		review = request.getParameter("review");
	}
	if (request.getParameter("email") != null){
		email = request.getParameter("email");
	}
	// 비밀번호 확인 과 비밀번호가 틀릴리 방지
	if (!pwd.equals(review)) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 일치하지 않습니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	}
	// 입력 사항이 없을 시
	if (userid==null || pwd==null || nixname==null || email==null || review==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	}
	// 데이터베이스에 유저정보를 전달할 객체 생성
	UserDAO userDAO = new UserDAO();
	int result = userDAO.join(new UserDTO(userid, pwd, nixname, email ,SHA256.getSHA256(email), false,0,null));
	if (result == -1){// 디비오류
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류 입니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
	}
	else {// 회원 생성 후 세션저장
		session.setAttribute("userid", userid);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'join3.jsp'");
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