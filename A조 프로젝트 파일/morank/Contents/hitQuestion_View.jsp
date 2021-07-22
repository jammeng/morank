<%@page import="user.UserDTO"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="service.ServiceDAO"%>
<%@ page import="service.ServiceDTO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/CS_QnA_ex.css">
<link rel="stylesheet" href="css/login_btn.css">
<script type="text/javascript" src="js/login_btn.js"></script>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	//유저 세션 유지
	String userid = null;
	if(session.getAttribute("userid") != null) {
		userid = (String)session.getAttribute("userid");
		//이메일 인증 체크
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
	// 아이디정보가 없을시 접근 불가
	if (userid == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
		script.close();
	}
	//게시물 정보 저장
	String scid = null;
	if (request.getParameter("scid") != null) {
		scid = (String) request.getParameter("scid");
	}
	//게시물 객체 생성
	ServiceDAO svDAO = new ServiceDAO();
	//이전 다음 게시물 정보를 불러오는 객체를 자바빈즈에 저장
	ServiceDTO svDTO = svDAO.getSC(scid);
	ServiceDTO svDTO1 = svDAO.getSC(scid);
	svDAO.good(scid);
	// 유저 정보를 가져올 객체 생성
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
					//비로그인시
					if (userid == null) {
					%>
					<button type="button" class="login_btn"
						onclick="location.href='serviceCenter.jsp'">고객센터</button>
					<button type="button" class="login_btn"
						onclick="location.href='login.jsp'">로그인</button>
					<button type="button" class="login_btn"
						onclick="location.href='join.jsp'">회원가입</button>
					<%
					//로그인시
					} else {
					%>
					<button type="button" class="login_btn" id="login_btn"><%=user.getNixname() + "▼"%></button>
					<div id="profile_wrap">
						<div class="hello">
							<%=user.getNixname() + " 님 안녕하세요"%>
							<div class="profile_img">
								<img src="<%=profile%>" alt="">
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
						<div class="QnA_title">
						<!-- 게시물제목정보 -->
							<h1><%=svDTO.getScTitle()%></h1>
						</div>
						<div class="main_text">
							<%=svDTO.getScContent()%><!-- 게시물 내용 정보 -->
						</div>
						<div class="main_text_answer">
							<%
							// 문의글 답변 정보가 없을 시
							if (svDTO.getStatused() == 0) {
							%>
							<p>답변 대기중</p>
							<%
							// 문의글 답변 정보가 있을 시
							} else if (svDTO.getStatused() == 1) {
							%>
							<p><%=svDTO.getScAnswer()%></p>
							<%
							}
							%>
						</div>
						<%
						// 리턴타입 arraylist 인 문의글 정보를 가져오는 메소드를 자바빈즈에 담아 줌 
						ArrayList<ServiceDTO> list = svDAO.gethitquestion();
						// 리스트 정보를 포문을 통해 가져옴
						for (int i = 0; i < list.size(); i++) {
							//게시물 정보를 담을 변수
							String title = null;
							//게시물 정보아이디를 담을 변수
							int id = 0;
							// 생성한 자바빈즈에 게시물 정보를 반복문을 통해 넣어줌
							svDTO = list.get(i);
							if (i == 0) {//만약 첫번째 게시물 정보 일시 전달받은 게시물 아이디와 가져온 게시물 아이디가 같다면
								if (Integer.parseInt(scid) == svDTO.getScid()) {
									//다음글의 정보를 가져옴
									svDTO = list.get(i + 1);
									// 다음글 제목 정보를 넣어줌
									title = svDTO.getScTitle();
									// 다음글 게시물 아이디 정보를 넣어줌
									id = svDTO.getScid();
						%>
						<div class="line">
							<p class="pre">이전글</p>
							<a class="" href="#"> 이전 글이 없습니다. </a>
						</div>
						<div class="line">
							<p class="after">다음글</p>
							<!-- 다음 페이지에 아이디정보  전달-->
							<a class="" href="hitQuestion_View.jsp?scid=<%=id%>"><%=title%></a>
						</div>
						<%
						}//만약 마지막 게시물 정보 일시 전달받은 게시물 아이디와 가져온 게시물 아이디가 같다면
						} else if (i == list.size()) {
						if (Integer.parseInt(scid) == svDTO.getScid()) {
							// 이전 페이지 정보를 가져옴
							svDTO = list.get(i - 1);
							// 이전 페이지 제목 정보
							title = svDTO.getScTitle();
							// 이전 페이지 아이디 정보
							id = svDTO.getScid();
						%>
						<div class="line">
							<p class="pre">이전글</p>
							<!-- 이전 페이지에 아이디정보  전달-->
							<a class="" href="hitQuestion_View.jsp?scid=<%=id%>"><%=title%></a>
						</div>
						<div class="line">
							<p class="after">다음글</p>
							<a class="" href="#"> 다음 글이 없습니다. </a>
						</div>

						<%
						}//그이외에 게시물들일시
						} else {
						if (Integer.parseInt(scid) == svDTO.getScid()) {
						ArrayList<ServiceDTO> list1 = svDAO.gethitquestion();
						svDTO = list.get(i - 1);
						title = svDTO.getScTitle();
						id = svDTO.getScid();
						svDTO1 = list.get(i + 1);
						String nexttitle = svDTO1.getScTitle();
						int nextid = svDTO1.getScid();
						%>
						<div class="line">
							<p class="pre">이전글</p>
							<!-- 이전 페이지에 아이디정보  전달-->
							<a class="" href="hitQuestion_View.jsp?scid=<%=id%>"> <%=title%></a>
						</div>
						<div class="line">
							<p class="after">다음글</p>
							<!-- 다음 페이지에 아이디정보  전달-->
							<a class="pre_list" href="hitQuestion_View.jsp?scid=<%=nextid%>"><%=nexttitle%></a>
						</div>
						<%
						}
						}
						%>
						<%
						}
						%>

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