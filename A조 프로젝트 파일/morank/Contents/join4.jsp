<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 유저 세션 유지
String userid = null;
if (session.getAttribute("userid") != null) {
	userid = (String) session.getAttribute("userid");
}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link rel="stylesheet" href="css/join5.css">
</head>
<body>
<div id="wrapper">
      <div class="logo">
        <a href="index.jsp"><img src="images/모두의랭킹6.png" alt=""></a>
      </div>
      <hr>
      <p class="title">
        가입 완료되었습니다.
        <br>앞으로 저희와 함께해요.
      </p>
      <button type="button" class="complete" name="button" onclick="location.href='index.jsp'">메인으로 돌아가기</button>
    </div>
    <footer>Changju Co.</footer>
</body>
</html>