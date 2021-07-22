<%@page import="user.UserDTO"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="service.ServiceDAO"%>
<%@ page import="service.ServiceDTO"%>
<%@ page import="java.util.ArrayList"%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터 문의</title>
<link rel="stylesheet" href="css/CS_mtm_list.css">
<link rel="stylesheet" href="css/login_btn.css">
<script type="text/javascript" src="js/login_btn.js"></script>
</head>
<body>
	<%
	// 유저 세션 유지
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
	// 비로그인시 방지
	if (userid == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
		script.close();
	}
	// 페이징 처리를 위한 변수
	String pageNumber = "1";
	// 다음 이전을 클릭시 넘어올 변수를 페이지 변수에 넣어줌
	if (request.getParameter("pageNumber") != null) {
		pageNumber = request.getParameter("pageNumber");
	}
	// 스트링인 pageNumber를 int 형으로 변환
	try {
		Integer.parseInt(pageNumber);
	}catch (Exception e){
		session.setAttribute("messageTYPE", "오류 메세지");
		session.setAttribute("messageTYPE", "페이지 번호가 잘못되었습니다.");
		response.sendRedirect("serviceQnA.jsp");
		return;
		
	}
	//유저정보를 보여줄 객체생성
	UserDAO userDAO = new UserDAO();
	UserDTO user = userDAO.getuser(userid);
	String profile = new UserDAO().getProfile(userid);
	%>
	<div id="wrapper">
		<header>
			<div class="head">
				<a href="index.jsp"><img src="images/모두의랭킹.png" alt=""></a>
				<h2>고객센터</h2>
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
							<h3>1:1 문의</h3>
						</div>
						<div class="main_list">
							<table class="list_info">
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>문의날짜</th>
									<th>답변여부</th>
								</tr>
								<% // 리턴 값이 arraylist인 게시물 객체 메소드에 페이지 넘버를 넣어준 후 가져운 정보를 포문을 통해 메소드의 내용에 맞게 정보를 띄어줌
								ServiceDAO svDAO = new ServiceDAO();
								ArrayList<ServiceDTO> list = svDAO.getList(pageNumber);
								for (int i = 0; i < list.size(); i++) {
									ServiceDTO sv = list.get(i);
								%>
								<tr>
									<td><%="Q "+sv.getScid()%></td>
									<td><a href="serviceQnA_View.jsp?scid=<%=sv.getScid()%>"><%=sv.getScTitle()%></a></td>
									<td><%=sv.getScDate().substring(2,4) +"-"+ sv.getScDate().substring(5,7)+"-"+sv.getScDate().substring(8,10)%></td>
									<%
									if(sv.getStatused()==0){
									%>
									<td id="ing">진행중</td>
									<%
									} else if (sv.getStatused()==1)  {
									%>
									<td>답변완료</td>
									<%
									 }
									%>
								</tr>
								<%
								}
								%>
							</table>
						</div>
						<div class="main_footer">
							<button type="button" class="write_btn" name="button"
								onclick="location.href='serviceInput.jsp'">글쓰기</button>
								<div class="list_page">
								<%//페이징처리 첫번째 페이지 가 아니라면 이전을 띄어줌
									if (!pageNumber.equals("1")){
								%>
									<a href="serviceQnA.jsp?pageNumber=<%=Integer.parseInt(pageNumber)-1%>">이전</a>
									
								<%// 페이지가 있을 시 treu 없을 시 false 값을 리턴해주는 메소드을 실행하여 페이지가 있으면 다음버튼을 띄어줌
									} if (svDAO.nextPage(pageNumber)){
								%>
								
									<a href="serviceQnA.jsp?pageNumber=<%=Integer.parseInt(pageNumber)+1%>">다음</a>
								<%
									}
								%>
							</div>
						</div>
					</div>
				</article>
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