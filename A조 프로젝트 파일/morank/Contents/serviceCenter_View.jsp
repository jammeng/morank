<%@page import="java.util.ArrayList"%>
<%@page import="user.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO"%>
<%@ page import="notice.NoticeDTO"%>
<%@ page import="notice.NoticeDAO"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/CS_main.css">
<link rel="stylesheet" href="css/login_btn.css">
<script type="text/javascript" src="js/login_btn.js"></script>
</head>
<body>
	<%
	// 공지글의 상세 내용을 보내주는 페이지
	// 로그인 세션 유지
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
	}
	// 비로그인 시 접근 방지
	if (userid == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
		script.close();
	}
	// 회원 정보를 보여줄 객체 생성
	UserDAO userDAO = new UserDAO();
	UserDTO user = userDAO.getuser(userid);
	// 문의글 정보를 보여줄 객체 생성
	NoticeDAO noticeDAO = new NoticeDAO();
	// 리던타입 이 arraylist인 문의글을 가져와주는 메소드를 arraylist에 담아줌
	ArrayList<NoticeDTO> list = noticeDAO.getList();
	// 문의글 아이디을 가져와줄 변수 생성 및 삽입 
	String noticeid = null;
	if (request.getParameter("noticeid") != null){
		noticeid = (String)request.getParameter("noticeid");
	}
	// 문의글의 상세 내용을 보여줄 객체 생성
	NoticeDAO play = new NoticeDAO();
	// 문의글의 상세 내용을 보여줄 메소드 실행
	NoticeDTO show = play.getnotice(noticeid);
	// 프로필 사진을 가져옴
	String profile = new UserDAO().getProfile(userid);
	%>
	<div id="wrapper">
		<header>
			<div class="head">
				<a href="index.jsp"><img src="images/모두의랭킹.png" alt=""></a>
				<h2>고객센터</h2>
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
					} else {// 로그인 시
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
							<li><a href="#"><h3>공지사항</h3></a></li>
							<%// 가져온 리스트의 이름을 공지 자바빈즈에 넣어준후 포문을 통해 리스트 사이즈 만큼 돌려 모든 공지글의 제목만 보여줌 
								for (int i=0; i<list.size(); i++){
									NoticeDTO notice = list.get(i);
								%><!-- 링크에 아이디 변수를 넣어 공지의 상세페이지로 이동 -->
									<li><a href="serviceCenter_View.jsp?noticeid=<%=notice.getNoticeid()%>"><%= notice.getNoticeTitle() %></a></li>								
								<%
								}
							%>
						</ul>
					</div>
					<!-- 공지 상세 제목 및 내용 -->
					<div class="main_content">
						<div class="main_title">
							<h3><%=show.getNoticeTitle() %></h3>
						</div>
						<div class="main_text">
							<%= show.getNoticeContent() %>
						</div>
					</div>
				</article>
				<!-- 관리자가 공지글 작성 시 페이지로 이동 -->
				<%
				if (user.getUserAvailable()==1){
				%>
				<button onclick="location.href='noticeWrite.jsp'">공지사항 작성</button>
				<%
				}
				%>
			</section>
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