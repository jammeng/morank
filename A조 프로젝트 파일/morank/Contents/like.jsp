<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.io.PrintWriter"%>
<%@ page import="searchdao.informationDAO" %>
<%@ page import="searchdto.informationVO" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import = "user.UserDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	// 전달 받은 검색 정보 아이디, 검색어, total = 카테고리(소)+카테고리(대) 정보를 변수에 저장
	// 로그인 세션 유지
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
		// 비 로그인 시를 방지 하기 위함
	if (userid ==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 후 가능합니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	} // 로그인시 추천 적용
	else{
		String info_id = request.getParameter("info_id");
		informationDAO iDao = new informationDAO();
		String search = (String)session.getAttribute("search");
		String total = request.getParameter("total");
		//좋아요 정보를 데이터베이스에 저장
		iDao.likeplus(info_id);
		PrintWriter script  = response.getWriter();
		script.println("<script>");
		//이전 페이지에 total = 카테고리(소)+카테고리(대) 정보를 전달해줌
		script.println("location.href='ranking.jsp?showcate="+total+"'");
		script.println("</script>");
		script.close();
	}
	
						
%>
</body>
</html>