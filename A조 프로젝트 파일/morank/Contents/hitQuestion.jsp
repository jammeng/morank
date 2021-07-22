<%@page import="user.UserDTO"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="service.ServiceDAO"%>
<%@ page import="service.ServiceDTO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/CS_QnA.css">
<link rel="stylesheet" href="css/login_btn.css">
<script type="text/javascript" src="js/login_btn.js"></script>
<title>Insert title here</title>
</head>
<body>
	<%
	// 로그인 세션 유지
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
	// 비로그인 시
	if (userid == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요')");
		script.println("location.href = 'login.jsp'");
		script.println("<script>");
		script.close();
	}
	// 게시물 아이디 저장
	String scid = null;
	if (request.getParameter("scid") != null) {
		scid = (String) request.getParameter("scid");
	}
	// 게시물 객체 생성
	ServiceDAO svDAO = new ServiceDAO();
	//조회수 증가 메소드
	svDAO.good(scid);
	// 회원정보를 가져올 유저 객체 생성
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
				<a href="index.jsp"><img src="images/모두의랭킹.png" alt=""></a>
				<h2>고객센터</h2>
				<div class="login">
					<%
					// 비로그인 시
					if (userid == null) {
					%>
					<button type="button" class="login_btn"
						onclick="location.href='serviceCenter.jsp'">고객센터</button>
					<button type="button" class="login_btn"
						onclick="location.href='login.jsp'">로그인</button>
					<button type="button" class="login_btn"
						onclick="location.href='join.jsp'">회원가입</button>
					<%// 로그인시
					} else {
					%>
					<button type="button" class="login_btn" id="login_btn"><%= user.getNixname()+"▼" %></button>
					<div id="profile_wrap">
						<div class="hello">
							<%= user.getNixname() + " 님 안녕하세요" %>
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
		</header>
		<div id="wire">
			<nav>
				<ul>
					<li class="c1"><a href="serviceCenter.jsp">공지사항</a></li>
					<li class="c2"><a class="c2_1" href="serviceQnA.jsp">문의사항</a>
						<ul>
							<li><a href="hitQuestion.jsp">자주 묻는 질문</a></li>
							<li><a href="serviceQnA.jsp">1:1 문의</a></li>
						</ul></li>
				</ul>
			</nav>
			<section>
				<article class="main_contents">
					<div class="notice_list">
						<ul>
							<li><h3>문의</h3></li>
							<li><a href="hitQuestion.jsp">자주 묻는 질문</a></li>
							<li><a href="serviceQnA.jsp">1:1 문의</a></li>
						</ul>
					</div>
					<div class="main_content">
						<div class="main_title">
							<h3>자주 묻는 질문</h3>
						</div>
						<div class="main_list">
							<table class="list_info">
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>조회수</th>
								</tr>
								<%
								// 리턴타입 arraylist 인 문의글 정보를 가져오는 메소드를 자바빈즈에 담아 줌 
								ArrayList<ServiceDTO> list = svDAO.gethitquestion();
								for (int i = 0; i < list.size(); i++) {
									ServiceDTO sv = list.get(i);
								%>
								<tr>
									<td><%="Q "+sv.getScid()%></td>
									<td><a href="hitQuestion_View.jsp?scid=<%=sv.getScid()%>"><%=sv.getScTitle()%></a></td>
									<td><%=sv.getScGood()%></td>
								</tr>
								<%
								}
								%>
							</table>
						</div>
					</div>
				</article>
			</section>
		</div>
		<footer>
			<div class="footer">
				<div class="company">
					<a style=""><img src="../images/WTP.jpg" width=50px;>
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