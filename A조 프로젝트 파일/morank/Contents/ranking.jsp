<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="searchdao.informationDAO" %>
<%@ page import="searchdto.informationVO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import = "user.UserDAO" %>   
<%@ page import = "user.UserDTO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% String search = (String)session.getAttribute("search");
   
   
 %>
 <%
 		// 검색 후 랭킹정보를 보여주는 페이지
 		// 유저 세션 유지
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
		// 유저정보를 가져올 객체 색성
		UserDAO userDAO = new UserDAO();
		UserDTO user = userDAO.getuser(userid);
		String profile = new UserDAO().getProfile(userid);
	%>
 
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>모두의 랭킹</title>
    <script src="https://kit.fontawesome.com/8b15bac25a.js" crossorigin="anonymous"></script>
    <script type="text/javascript" src="js/search_IN.js"></script>
    <script src="https://kit.fontawesome.com/8b15bac25a.js" crossorigin="anonymous"></script>
	<script type="text/javascript" src="js/login_btn.js"></script>
	<script type="text/javascript" src="js/login_btn.js"></script>
	
	<link rel="stylesheet" href="css/search_IN.css">
	<link rel="stylesheet" href="css/login_btn.css">
	<link rel="stylesheet" href="css/mypage_header.css">
  </head>
  <body>
    <div id="wrapper">
      <header>
			<div class="head">
				<div class="head-text">
					<div class="head-flex">
						<div class="logo-title">
							<a href="index.jsp"><img src="images/모두의랭킹.png" alt=""></a>
						</div>
						<div class="login">
							<%// 로그인시
							if (userid == null) {
							%>
							<button type="button" class="login_btn"
								onclick="location.href='serviceCenter.jsp'">고객센터</button>
							<button type="button" class="login_btn"
								onclick="location.href='login.jsp'">로그인</button>
							<button type="button" class="login_btn"
								onclick="location.href='join.jsp'">회원가입</button>
							<%// 비로그인시
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

      <div id="wire">

        <section>
          <article class="main_contents" style="justify-content: center;">
			<form method="get" action="search.jsp" class="search_form">
	           
	              <input type="text"  name="search" class="search">
	              <input type="submit" class="search_sub" value="검색" >
	           
			</form>
			
			<!-- 검색 결과 text -->
			<div style="margin-top:20px;">
			<%	
				
				out.print("\""+search+"\"에 대한 검색 결과 입니다.");
				
			%>
			</div>
			
			<!-- 소 카테고리 분류 -->
			<div class="small_category">
				<%
					String total = null;
					informationDAO iDao = new informationDAO();
					ArrayList<informationVO> result = iDao.showcategory(search);
							
					for (int i= 0; i <result.size(); i++){
						informationVO iVo = result.get(i);
						total = iVo.getSmallC_id() + iVo.getBigC_id();
				%>
					<form method="get" action="" >
						<input type="submit" name="showcate" value="<%= total%>">&nbsp;&nbsp;&nbsp;
					</form>
				<%
					}
					if (result.size() == 0){
				%>		
					<form method="post" action="SCpage.jsp">
						<input type="submit" name="gotoSC" value="추가 요청하러 가기">
					</form>
				<%		
					}
				%>
			</div>
			
			<!-- 랭킹 리스트 -->
			<div class="rankingbord" id="rankingbord" style="margin-top:20px;">
				<div>
					<table>
					 	<tr>
		                    <th>순위</th>
		                    <th>이름</th>
		                    <th>투표수</th>
		                    <th>좋아요</th>
	                  	</tr>
							<%
								String select = request.getParameter("showcate");
								ArrayList<informationVO> table = iDao.showranklist(select);
								int cnt = 1;
								for (int i= 0; i <table.size(); i++){
								
									informationVO iVo = table.get(i);
							%>
	              
		                <tr>
		                   <td><%=cnt++%></td>
		                   <td><a href="contents.jsp?info_id=<%=iVo.getInfo_id()%>&total=<%=select%>"><%= iVo.getInfo_name() %></a></td>
		                   <td><%= iVo.getLikeamount() %></td>
		                   <%String info_id =  (String)session.getAttribute("info_id"); %>
		                   
		                   <td> <a href="like.jsp?info_id=<%=iVo.getInfo_id() %>&total=<%=select%>">좋아요</a><i class="fas fa-thumbs-up"></i></td>
		                	
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
            <a style=""><img src="images/WTP.jpg" width=50px;> <h2>What the Pork</h2></a>
          </div>
          <div class="detail">
            <b>주소</b> : 경기 수원시 팔달구 중부대로 100 3층
            <br>
            <b>대표</b> : 박창주
          </div>
        </div>
      </footer>
    </div>
  </body>
</html>