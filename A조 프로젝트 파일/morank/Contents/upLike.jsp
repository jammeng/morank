<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="searchdao.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import = "user.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	// 컨텐츠 좋아요를 활성해주는 페이지
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
	// 랭킹 정보 및 검색정보의 제목 및 댓글 정보를 전해줄 변수 생성
	informationDAO tstDAO = new informationDAO();
	informationDAO iDao = new informationDAO();
	String search = (String) session.getAttribute("search");
	String info_id = request.getParameter("info_id");
	String total = request.getParameter("total");
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
			int result = tstDAO.likeplus(info_id);
			// 데이터베이스 오류
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('DB오류')");
				script.println("location.href = 'contents.jsp?info_id="+info_id+"&total="+total+"'");
				script.println("</script>");
				script.close();
			} else {// 추천 적용
				PrintWriter outter = response.getWriter();
				outter.println("<script>");
				outter.println("alert('추천 완료')");
				outter.println("location.href = 'contents.jsp?info_id="+info_id+"&total="+total+"'");
				outter.println("</script>");
			}
		}
	%>



</body>
</html>