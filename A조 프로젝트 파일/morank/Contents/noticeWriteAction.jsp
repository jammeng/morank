<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="notice.NoticeDTO"%>
<%@ page import="notice.NoticeDAO"%>
<%@page import="user.UserDTO"%>
<%@page import="user.UserDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	// 
	request.setCharacterEncoding("UTF-8");
	int noticeid;
	String noticeTitle = null;
	String noticeContent = null;

	// 회원 세션 유지
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
	// 잘못된 접근 방지
	if (userid == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('잘못된 접근 입니다.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
		script.close();
	}
	// 유저 정보를 가져올 객체 생성
	UserDAO userDAO = new UserDAO();
	UserDTO user = userDAO.getuser(userid);
	// 관리자 계정이외 접근 시 을 방지하기 위함
	if (user.getUserAvailable() != 1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('잘못된 접근 입니다.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
		script.close();
	}
	// 전달받은 공지 제목을 저장
	if (request.getParameter("noticeTitle") != null) {
		noticeTitle = request.getParameter("noticeTitle");
	}
	// 전달받은 공지 내용을 저장
	if (request.getParameter("noticeContent") != null) {
		noticeContent = request.getParameter("noticeContent");
	}
	// 입력을 못받을 시 이전페이지 이동
	if (noticeTitle == null || noticeContent == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	}
	// 공지데이터를 가져올 객체 생성
	NoticeDAO noticeDAO = new NoticeDAO();
	// 공지 글을 데이터베이스에 전송하는 메소드 사용
	int result = noticeDAO.write(new NoticeDTO(0, noticeTitle, noticeContent));
	if (result == -1) {
		PrintWriter outter = response.getWriter();
		outter.println("<script>");
		outter.println("alert('글쓰기에 실패 했습니다.')");
		outter.println("history.back()");
		outter.println("</script>");
	} else {
		PrintWriter outter = response.getWriter();
		outter.println("<script>");
		outter.println("location.href = 'serviceCenter.jsp'");
		outter.println("</script>");
	}
	%>


</body>
</html>