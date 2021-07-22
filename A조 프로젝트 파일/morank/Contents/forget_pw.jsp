<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/forget_pw.css">

</head>
<body>
<div id="wrapper">
    <section>
      <article class="main">
        <div class="contents">
          <div class="logo">
            <a href="index.html"><img src="images/모두의랭킹2.png" width="250px" alt=""></a>
          </div>
          <div class="content">
            <h1>비밀번호 찾기</h1>
            <p>회원정보에 등록된 아이디와 이메일 주소를 입력해주세요.</p>


            <form class="" action="forget_pw_send.jsp" method="post">
              <input type="text" name="userid" value="" placeholder="아이디 입력">
              <input type="email" name="email" value="" placeholder="이메일 주소 입력">
              <div class="button"> 
                <button type="submit" name="submit" onclick="location.href='forget_pw_send.jsp'">이메일 전송</button><!-- 이메일 전송 페이지 이동 -->
                <button type="button" name="button" onclick="location.href='login.jsp'">나가기</button>
              </div>
            </form>


            <a href="login.html">로그인 하러가기</a>
          </div>
        </div>
      </article>
    </section>
    </div>
</body>
</html>