<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="searchdao.informationDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.File"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
request.setCharacterEncoding("UTF-8");
// 정보 객체 생성
informationDAO info = new informationDAO();
// 절대 경로로 upload라는 폴더를 찾아 directory 변수에 넣어줌
String directory = application.getRealPath("/upload").replaceAll("\\\\","/");;
// 사진의 크기 변수
int maxSize = 1024*1024*100;
// UTF-8로 변환
String encoding ="UTF-8";
// 사진 정보를 데이터베이스에 전송하기 위해 변환하는 라이브러리 생성 후 위에 생성한 변수를 넣어줌
MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());
// 전달받은 사진 정보를 변수에 넣어줌
String IMG_LINK = multipartRequest.getOriginalFileName("IMG_LINK");

// 검색정보 제목변수
String info_name = null;
// inforprofile.jsp 에서 유지한 세션을 넣어줌
if(session.getAttribute("title") != null) {
	info_name = (String) session.getAttribute("title");
}
// total = 카테고리(서)+카테고리(대) 정보 변수
String total = null;
//inforprofile.jsp 에서 유지한 세션을 넣어줌
if(session.getAttribute("total") != null) {
	total = (String) session.getAttribute("total");
}
// 검색 정보 아이디 변수
String info_id = null;
//inforprofile.jsp 에서 유지한 세션을 넣어줌
if(session.getAttribute("info_id") != null) {
	info_id = (String) session.getAttribute("info_id");
}
// 전달 받은 사진 정보가 없을 시 (다른경로로 접근 방지)
if (IMG_LINK == null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('입력받은 프로필 정보가 없습니다.')");
	script.println("history.back()");
	script.println("</script>");
	script.close();
}
// 검색 정보 아이디 변수가 없을 시 (다른경로로 접근 방지)
if (info_name == null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('입력받은 이름이 없습니다.')");
	script.println("history.back()");
	script.println("</script>");
	script.close();
}
// 정보가 있을 시 데이터베이스에 사진정보를 넣어주는 메소드 실행 후 정상적으로 작동 시 이전 페이지에 변수들을 전달해줌
else {
	info.getProfile(IMG_LINK, info_name);
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('프로필 변경 완료')");
	script.println("location.href = 'contents.jsp?info_id="+info_id+"&total="+total+"&title="+info_name+"'");
	script.println("</script>");
	script.close();
}
%>
</body>
</html>