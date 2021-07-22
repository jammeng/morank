<%@page import="user.UserDTO"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/security_mypage.css">
<link rel="stylesheet" href="css/login_btn.css">
<link rel="stylesheet" href="css/mypage_header.css">
<script type="text/javascript" src="js/login_btn.js"></script>
</head>
<body>
	<%
	// 회원 탈퇴 및 비밀번호 변경 페이지로 이동하기 위한 페이지
	// 회원 세션 유지
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
	}// 비로그인 시 접근 방지
	if (userid == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
		script.close();
	}
	// 유저 정보를 가져오는 객체 생성
	UserDAO userDAO = new UserDAO();
	UserDTO user = userDAO.getuser(userid);
	String profile = new UserDAO().getProfile(userid);
	%>
	<div id="wrapper">
		<header>
			<div class="head">
				<div class="head-text">
					<div class="head-flex">
						<div class="logo-title">
							<a href="index.jsp"><img src="images/모두의랭킹.png" alt=""></a>
							<h2>마이페이지</h2>
						</div>
						<div class="login">
							<%// 비 로그인 시
							if (userid == null) {
							%>
							<button type="button" class="login_btn"
								onclick="location.href='serviceCenter.jsp'">고객센터</button>
							<button type="button" class="login_btn"
								onclick="location.href='login.jsp'">로그인</button>
							<button type="button" class="login_btn"
								onclick="location.href='join.jsp'">회원가입</button>
							<%
							} else {//로그인 시
							%>
							<button type="button" class="login_btn" id="login_btn"><%=user.getNixname() + "▼"%></button>
							<div id="profile_wrap">
								<div class="hello">
									<%=user.getNixname() + " 님 안녕하세요"%>
									<div class="profile_img">
										<img src="<%=profile %>" alt="">
									</div>
									<a href="mypageMain.jsp" class="mypage">마이페이지</a> <a
										href="serviceCenter.jsp" class="mypage">고객센터</a>
									<hr>
									<form action="logoutAction">
										<a href="logoutAction.jsp" class="logoutAction.jsp">로그아웃</a>
									</form>
								</div>
							</div>
							<%
							}
							%>
						</div>
					</div>
				</div>
			</div>
		</header>
		<nav>
			<div class="head-menu">
				<ul>
					<li><a href="mypageMain.jsp">회원정보</a></li>
					<li><a href="security_mypage.jsp">보안설정</a></li>
				</ul>
			</div>
		</nav>
		<div class="contents">
			<div class="content-items">
				<div class="content-item">
				<!-- 비밀번호 변경 페이지 이동-->
					<div class="content-item-title">
						<strong>비밀번호 변경</strong>
					</div>
					<div class="text_btn">
						<a href="password_mypage.jsp"><br> <br>변경하기</a>
					</div>
				</div>
				<div class="content-item">
				<!-- 회원 탈퇴 페이지 이동-->
					<div class="content-item-title">
						<strong>회원 탈퇴</strong>
					</div>
					<div class="text_btn">
						<a href="secession_mypage.jsp"><br> <br>회원탈퇴 하기</a>
					</div>
				</div>
			</div>
		</div>
		<footer>
			<div class="footer">
				<div class="company">
					<a style=""><img src="images/WTP.jpg" width=50px;>
						<h2>What the Pork</h2></a>
				</div>
				<div class="detail">
					<b>주소</b> : 경기 수원시 팔달구 중부대로 100 3층 <br> <b>대표</b> : 박창주
				</div>
			</div>
		</footer>
	</div>
</body>
</html>