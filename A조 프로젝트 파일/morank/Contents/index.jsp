<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@ page import = "java.io.PrintWriter" %> 
<%@ page import = "user.UserDAO" %>   
<%@ page import = "user.UserDTO" %>
<%@ page import = "searchdao.informationDAO" %>
<%@ page import = "searchdto.informationVO" %>  

<%
//영화 변수
String Movie = "Movie";
String Game = "Game"; //게임 변수
String annie = "Annie"; //애니메이션 변수
String drama = "Drama"; //드라마 변수
String Carton = "Carton"; //만화 변수
informationDAO info = new informationDAO(); //인덱스 랭킹 정보를 가져올 정보 객체 생성


%>

<%		// 로그인 세션 유지
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
		//회원정보를 가져올 회원객체 생성
		UserDAO userDAO = new UserDAO();
		UserDTO user = userDAO.getuser(userid);
		String profile = new UserDAO().getProfile(userid);
	%>

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
<meta charset="utf-8">
<title>모두의 랭킹</title>
<link rel="stylesheet" href="css/index.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="css/login_btn.css">
	<script type="text/javascript" src="js/login_btn.js"></script>
</head>
<body>
	<div id="wrap">
		<header>
			<div class="login">
				<%//비 로그인 시
				if(userid == null){
			%>	
					<button type="button" class="login_btn" onclick="location.href='serviceCenter.jsp'">고객센터</button>
	         		<button type="button" class="login_btn" onclick="location.href='login.jsp'">로그인</button>
	          		<button type="button" class="login_btn" onclick="location.href='join.jsp'">회원가입</button>
          	<%		//로그인시
				} else {
			%>
					<button type="button" class="login_btn" id="login_btn"><%= user.getNixname()+"▼" %></button>
          			<div id="profile_wrap">
            			<div class="hello">
              				<%= user.getNixname() + " 님 안녕하세요" %>
            				<div class="profile_img">
              					<img src="<%=profile %>" class="prof_img" alt="">
            				</div>
            				<a href="mypageMain.jsp" class="mypage">마이페이지</a>
           					<a href="serviceCenter.jsp" class="mypage">고객센터</a>
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
		</header>
		<div id="wire">
			<div class="logo">
				<img src="images/모두의랭킹2.png" alt="">
			</div>
			<form action="search.jsp" method="post">
				<div class="search">
					<input class="keyword" type="text" name="search" maxlength=255
						value="" autocomplete="off" placeholder="원하는 랭킹을 입력하세요" alt="">
					<button type="submit" name="button" class="search_btn">
						검색
					</button>
				</div>
			</form>
			<div class="rankdata">
				<div class="row">
					<div class="col">
						<ul class="nav nav-tabs">
							<li class="nav-item"><a class="nav-link active"
								data-toggle="tab" href="#영화">영화</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab"
								href="#게임">게임</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab"
								href="#만화">만화</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab"
								href="#드라마">드라마</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab"
								href="#애니">애니</a></li>
						</ul>
						<div class="tab-ex">
							<div class="genre_display">
								<h1></h1>
								<strong>장르</strong>
							</div>
							<div class="producer_display">
								<h1></h1>
								<strong>제작</strong>
							</div>
							<div class="star_display">
								<h1></h1>
								<strong>좋아요</strong>
							</div>
						</div>
						<div class="tab-content">
							<div class="tab-pane fade show active" id="영화">
								<%// 리턴타입 arraylist 인 정보객체에서 정보를 전부 가져오는 메소드를 자바빈즈에 담아 줌
								ArrayList<informationVO> arrmovie = info.getindexinfo(Movie);
								int cnt = 1;
								for (int i = 0; i < arrmovie.size(); i++) {
									informationVO infoVO = arrmovie.get(i);
									String total = infoVO.getSmallC_id()+Movie;
								%>
								<a href="contents.jsp?info_id=<%=infoVO.getInfo_id()%>&total=<%=total%>">
									<div class="rank_box">
										<div class="num_box">
											<strong><%=cnt++%></strong>
										</div>
										<div class="name_box">
											<strong><%=infoVO.getInfo_name()%></strong>
										</div>
										<div class="genre_box">
											<%=infoVO.getSmallC_id()%>
										</div>
										<div class="producer_box">
											<%=infoVO.getProducer()%>
										</div>
										<div class="star_box">
											<%=infoVO.getLikeamount()%>
										</div>
									</div> <%
 }
 %>
								</a>
							</div>
							<div class="tab-pane fade" id="게임">
								<%// 리턴타입 arraylist 인 정보객체에서 정보를 전부 가져오는 메소드를 자바빈즈에 담아 줌
								ArrayList<informationVO> arrgame = info.getindexinfo(Game);
								cnt = 1;
								for (int i = 0; i < arrgame.size(); i++) {
									informationVO infoVO = arrgame.get(i);
									String total = infoVO.getSmallC_id()+Game;
								%>
								<a href="contents.jsp?info_id=<%=infoVO.getInfo_id()%>&total=<%=total%>">
									<div class="rank_box">
										<div class="num_box">
											<strong><%=cnt++%></strong>
										</div>
										<strong></strong>
										<div class="name_box">
											<strong><%=infoVO.getInfo_name()%></strong>
										</div>
										<div class="genre_box">
											<%=infoVO.getSmallC_id()%>
										</div>
										<div class="producer_box">
											<%=infoVO.getProducer()%>
										</div>
										<div class="star_box">
											<%=infoVO.getLikeamount()%>
										</div>
									</div> <%
 }
 %>
								</a>
							</div>
							<div class="tab-pane fade" id="만화">
								<%// 리턴타입 arraylist 인 정보객체에서 정보를 전부 가져오는 메소드를 자바빈즈에 담아 줌
								ArrayList<informationVO> arrcarton = info.getindexinfo(Carton);
								cnt = 1;
								for (int i = 0; i < arrcarton.size(); i++) {
									informationVO infoVO = arrcarton.get(i);
									String total = infoVO.getSmallC_id()+Carton;
								%>
								<a href="contents.jsp?info_id=<%=infoVO.getInfo_id()%>&total=<%=total%>">
									<div class="rank_box">
										<div class="num_box">
											<strong><%=cnt++%></strong>
										</div>
										<div class="name_box">
											<strong><%=infoVO.getInfo_name()%></strong>
										</div>
										<div class="genre_box">
											<%=infoVO.getSmallC_id()%>
										</div>
										<div class="producer_box">
											<%=infoVO.getProducer()%>
										</div>
										<div class="star_box">
											<%=infoVO.getLikeamount()%>
										</div>
									</div> <%
 }
 %>
								</a>
							</div>
							<div class="tab-pane fade" id="드라마">
								<%// 리턴타입 arraylist 인 정보객체에서 정보를 전부 가져오는 메소드를 자바빈즈에 담아 줌
								ArrayList<informationVO> arrdrama = info.getindexinfo(drama);
								cnt = 1;
								for (int i = 0; i < arrdrama.size(); i++) {
									informationVO infoVO = arrdrama.get(i);
									String total = infoVO.getSmallC_id()+drama;
								%>
								<a href="contents.jsp?info_id=<%=infoVO.getInfo_id()%>&total=<%=total%>">
									<div class="rank_box">
										<div class="num_box">
											<strong><%=cnt++%></strong>
										</div>
										<div class="name_box">
											<strong><%=infoVO.getInfo_name()%></strong>
										</div>
										<div class="genre_box">
											<%=infoVO.getSmallC_id()%>
										</div>
										<div class="producer_box">
											<%=infoVO.getProducer()%>
										</div>
										<div class="star_box">
											<%=infoVO.getLikeamount()%>
										</div>
									</div> <%
 }
 %>
								</a>
							</div>
							<div class="tab-pane fade" id="애니">
								<%// 리턴타입 arraylist 인 정보객체에서 정보를 전부 가져오는 메소드를 자바빈즈에 담아 줌
								ArrayList<informationVO> arrani = info.getindexinfo(annie);
								cnt = 1;
								for (int i = 0; i < arrani.size(); i++) {
									informationVO infoVO = arrani.get(i);
									String total = infoVO.getSmallC_id()+annie;
								%>
								<a href="contents.jsp?info_id=<%=infoVO.getInfo_id()%>&total=<%=total%>">
									<div class="rank_box">
										<div class="num_box">
											<strong><%=cnt++%></strong>
										</div>
										<div class="name_box">
											<strong><%=infoVO.getInfo_name()%></strong>
										</div>
										<div class="genre_box">
											<%=infoVO.getSmallC_id()%>
										</div>
										<div class="producer_box">
											<%=infoVO.getProducer()%>
										</div>
										<div class="star_box">
											<%=infoVO.getLikeamount()%>
										</div>
									</div> <%
 }
 %>
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<footer>
        <div class="footer">
          <div class="company">
            <a style=""><img src="images/WTP.jpg" width=50px;> <h2>What the Pork</h2></a>
          </div>
          <div class="detail">
            <b>주소</b> : 경기 수원시 팔달구 중부대로 100 3층
            <br>
            <b>대표</b> : 박창주
          </div>
        </div>
      </footer>
</body>
</html>
