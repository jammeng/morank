<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>로그인</title>
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
<%
	//로그인 세션 유지
	String userid = null;
	if (session.getAttribute("userid") != null) {
		userid = (String) session.getAttribute("userid");
	}
	// 이미 로그인 했을 시 접근을 방지
	if (userid != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 된 상태 입니다.')");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
	}
	%>
	<div class="wrapper">
	<!-- 입력받은 아이디와 비밀번호를 검증하는 페이지로 전달후 이동 -->
      <form class="form-signin" action="loginAction.jsp" method="post">
        <p><a href="index.jsp"><img src="images/모두의랭킹2.png" width="250px" alt=""></a></p>
        <div class="centered">
          <div class="account">
            <input type="text" class="form-control" name="userid" maxlength="20" autofocus/>
            <label for="name">ID</label>
            <div class="bar"></div>
          </div>
          <div class="account">
            <input type="password" class="form-control" name="pwd" maxlength="20"  required=""/>
            <label for="name">Password</label>
            <div class="bar"></div>
          </div>
        </div>
        <label class="checkbox">
        </label>
        <button class="btn" type="submit" onclick="location.href='#'">Login</button>
        <p class="forget-signup">
          <span class="forget"><a href="forget_id.html">아이디 |</a><a href="forget_pw.jsp"> 비밀번호 찾기</a></span>
          <span clsss="signup"><a href="join.jsp">| 회원가입</a></span>
        </p>
      </form>
    </div>
</body>
</html>