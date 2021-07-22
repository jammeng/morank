<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%>
    
<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8"); //사용자에게 받은 데이터를 변경
	String code=null;
	String userid=null;
	UserDAO userDAO = new UserDAO();
	
	if (request.getParameter("code") != null){
		code = (String)request.getParameter("code");
	}
	if (session.getAttribute("userid") != null) {
		userid = (String)session.getAttribute("userid");
	}
	
	if (userid==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요')");
		script.println("location.href = 'Login.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
	if (code==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('code가없습니다.')");
		script.println("location.href = 'join3.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
	String userEmail = userDAO.getUserEmail(userid);
	boolean isRight = (new SHA256().getSHA256(userEmail).equals(code)) ? true : false;
	if (isRight==true){
		userDAO.setUserEmailChecked(userid);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('인증에 성공했습니다.')");
		script.println("location.href = 'join4.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 코드입니다.')");
		script.println("location.href = 'index.jsp'");
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