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
	if (userid == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요')");
		script.println("location.href = 'login.jsp'");
		script.println("<script>");
		script.close();
	}


	//		boolean emailChecked = new UserDAO().getUserEmailChecked(userID); 
	//	if(emailChecked==false){
	//	PrintWriter script = response.getWriter();
	//		script.println("<script>");
	//		script.println("location.href = 'emailSendConfirm.jsp'");
	//		script.println("</script>");
	//		script.close();
	//		return;
	//	}
	
	String checkPoint = request.getParameter("checkPoint");
	
	
	if (checkPoint == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('회원탈퇴 동의해 주세요')");
		script.println("history.back()");
		script.println("<script>");
		script.close();
	}
	else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("history.back()");
		script.println("location.href = 'secession_mypage_Input.jsp'");
		script.close();
	}
	
	
	%>
</body>
</html>