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
<link rel="stylesheet" href="css/secession_mypage.css">
<link rel="stylesheet" href="css/login_btn.css">
<link rel="stylesheet" href="css/mypage_header.css">
<script type="text/javascript" src="js/login_btn.js"></script>
</head>
<body>
	<%
	// 회원 탈퇴 시 동의사항 페이지
	// 유저정보 유지
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
	// 비 로그인 시 접근 방지
	if (userid == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
		script.close();
	}
	// 유저 정보를 가져올 객체 생성
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
							<%// 비로그인시
							if (userid == null) {
							%>
							<button type="button" class="login_btn"
								onclick="location.href='serviceCenter.jsp'">고객센터</button>
							<button type="button" class="login_btn"
								onclick="location.href='login.jsp'">로그인</button>
							<button type="button" class="login_btn"
								onclick="location.href='join.jsp'">회원가입</button>
							<%//로그인시
							} else {
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
			<div class="content-item">
				<div class="content-box">
				<!-- 회원탈퇴시 동의사항 값을 secessionCheckPoint.jsp 페이지에 전달-->
					<form class="" action="secessionCheckPoint.jsp" method="post">
						<h2>회원탈퇴</h2>
						회원 탈퇴 전에 반드시 유의 사항을 확인하고 진행해 주세요<br> <br>
						<h2>개인정보 및 서비스 이용 기록 삭제</h2>
						개인정보 및 개인화 서비스 이용기록이 모두 삭제 되며, 삭제된 데이터는 복구되지 않습니다.<br> 필요한
						데이터는 미리 백업 해 주시기 바랍니다.<br> <br> <input type="checkbox"
							name="checkPoint" value=1>회원 탈퇴 시 유의사항을 확인하였으며, 모두 동의
						합니다.<br> <br>
						<div class="text_btn">
							<!-- 값 집어 넣으면 됨 -->

							<button type="submit" value="동의" onclick="location.href='secessionCheckPoint.jsp'"">동의</button>
							<button type="button" name="button" onclick="history.go(-1);">돌아가기</button>
					</form>
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