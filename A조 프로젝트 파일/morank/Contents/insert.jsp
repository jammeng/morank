<%@page import="java.sql.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="user.UserDTO"%>
<%@page import="searchdao.commentsDAO"%>
<%@page import="searchdto.commentsVO"%>
<%@page import="searchdao.informationDAO"%>
<%@page import="searchdto.informationVO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
	//댓글 작성 후 댓글정보를 데이터베이스에 넣어주는 페이지
	// 로그인 세션 유지
	request.setCharacterEncoding("UTF-8");
	UserDAO userDAO = new UserDAO();
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
	
	// 검색 정보 아이디를 가져옴 
	String info_id = null;
	
	if (request.getParameter("info_id") != null) {
		info_id = request.getParameter("info_id");
	}
	// 검색정보 객체를 생성
	informationDAO infoDAO = new informationDAO();
	// 자바빈즈에 검색정보를 넣어줌
	informationVO infoVO = infoDAO.getinfo(info_id);
	// 랭킹정보를 가져올 변수
	String total = infoVO.getSmallC_id()+infoVO.getBigC_id();
	// 비 로그인 시 제한
	if (userid==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 후 이용해 주세요')");
		script.println("location.href = 'contents.jsp?info_id="+info_id+"&total="+total+"'");
		script.println("</script>");
		script.close();
	}
	else{// 로그인 시 댓글 정보를 데이터베이스에 넣어줌
		String profile = userDAO.getProfile(userid);
		String comment_inputs = request.getParameter("comment_inputs");
		commentsDAO comm = new commentsDAO();
		int result = comm.creatcomment(new commentsVO(info_id, profile, userid, comment_inputs, 0));
		//데이터베이스 오류시
		if (result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류')");
			script.println("location.href = 'contents.jsp?info_id="+info_id+"&total="+total+"'");
			script.println("</script>");
			script.close();
		}
		// 완료 시
		else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('댓글 등록 완료')");
			script.println("location.href = 'contents.jsp?info_id="+info_id+"&total="+total+"'");
			script.println("</script>");
			script.close();
		}
	}
	%>
</body>
</html>