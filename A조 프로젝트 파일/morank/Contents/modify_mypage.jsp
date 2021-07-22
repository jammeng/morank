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

<link rel="stylesheet" href="css/modify_mypage.css">
<link rel="stylesheet" href="css/login_btn.css">
<link rel="stylesheet" href="css/mypage_header.css">
<script type="text/javascript" src="js/login_btn.js"></script>
</head>
<body>
	<%
	// 이미지 변경 페이지
	// 로그인 세션 유지
	String userid = null;
	if(session.getAttribute("userid") != null) {
		userid = (String)session.getAttribute("userid");
		// 이메일 비 인증시 다시 인증할수 있게 이동
		boolean emailChecked = new UserDAO().getUserEmailChecked(userid); //이메일 인증 안될시
		if(emailChecked==false){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'join3.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
	}// 비 로그인시 접근을 방지
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
	//		boolean emailChecked = new UserDAO().getUserEmailChecked(userID); //이메일 인증 안될시
	//	if(emailChecked==false){
	//	PrintWriter script = response.getWriter();
	//		script.println("<script>");
	//		script.println("location.href = 'emailSendConfirm.jsp'");
	//		script.println("</script>");
	//		script.close();
	//		return;
	//	}
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
							<%//비 로그인 시
							if (userid == null) {
							%>
							<button type="button" class="login_btn"
								onclick="location.href='serviceCenter.jsp'">고객센터</button>
							<button type="button" class="login_btn"
								onclick="location.href='login.jsp'">로그인</button>
							<button type="button" class="login_btn"
								onclick="location.href='join.jsp'">회원가입</button>
							<%// 로그인 시
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
			<div class="content-items">
				<div class="content-item">
					<div class="content-item-title">
						<strong><h2>프로필수정</h2></strong>
					</div>
					<div class="content-item-profile">
						<div class="content-item-profile-font-size">
							<img alt="" src="<%= profile %>" class="chang"/> 
						</div>
					</div>
					<!-- 프로필 수정 부분 -->
					<form action="modifyProfile.jsp" method="post"
						enctype="multipart/form-data">
						<div class="content-item-min">
							<div class="content-item-modify-profile">
								<label class="image-btn">이미지 변경<input type="file"
									name="profile" value=""></label>
								<div class="content-item-modify-profile">
									<!-- 삭제 기능 추가 -->
									<input type="reset" name="button">삭제
								</div>
							</div>
						</div>
						<div class="content-text">
							<div class="content-item-nixname">
							</div>
						</div>
						<div class="text_btns">
							<!-- 수정 클릭 시 input 닉네임 변경하는 입력창(+중복확인) -->
							<button type="submit" class="edit_btn" name="button" value="수정" onclick="location.href='modifyProfile.jsp'">수정</button>
							<button type="button" class="delete_btn" name="button"
								onclick="location.href='mypageMain.jsp'">취소</button>
						</div>
					</form>
				</div>
				<!-- 수정 끝 -->
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