<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.File"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="user.UserDAO"%>




<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		//프로필 사진 변경 이 이루어지는 페이지
		// 유저 객체 생성
		UserDAO userDAO = new UserDAO();
		request.setCharacterEncoding("UTF-8");
		//유저 아이디를 담을 변수
		String userid = null;
		// 절대 경로로 upload라는 폴더를 찾아 directory 변수에 넣어줌
		String directory = application.getRealPath("/upload").replaceAll("\\\\","/");
		// 사진의 크기 변수
		int maxSize = 1024*1024*100;
		// UTF-8로 변환
		String encoding ="UTF-8";
		// 유저 세션 유지
		if (session.getAttribute("userid") != null) {
			userid = (String) session.getAttribute("userid");
		}
		
		// 사진 정보를 데이터베이스에 전송하기 위해 변환하는 라이브러리 생성 후 위에 생성한 변수를 넣어줌
		MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());
		// 사진 변수에 전달받은 사진 정보를 넣어줌
		String profile = multipartRequest.getOriginalFileName("profile");
		// 비 로그인 시 접근을 방지하기위함
		if (userid == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
			script.close();
		}
		
		// 사진정보를 넣지 않았을 시 을 방지
		if (profile == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력받은 프로필 정보가 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
			script.close();
			return;
		}
		// 사진정보가 있을 시 데이터베이스에 사진정보를 넣어주는 메소드를 실행후 완료 시 인덱스 페이지 이동
		else {
			userDAO.upload(profile, userid);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('프로필 변경 완료')");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
			script.close();
		}
	%>

</body>
</html>