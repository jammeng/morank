<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="searchdao.informationDAO"%>
<%@ page import="searchdto.informationVO"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%String title = null;
// 검색 정보의 제목 을 가져옴
if (request.getParameter("title") != null){
	title = request.getParameter("title");
}
// 검색 정보 아이디를 가져옴
String info_id = null;

if (request.getParameter("info_id") != null){
	info_id = request.getParameter("info_id");
}
// total = 카테고리(서)+카테고리(대) 정보를 가져옴
String total = null;

if (request.getParameter("total") != null){
	total = request.getParameter("total");
}
// 3개의 변수를 세션 유지해줌
session.setAttribute("title", title);
session.setAttribute("info_id", info_id);
session.setAttribute("total", total);
%>	<!-- 관리자가 검색정보의 사진정보를 넣는 페이지 -->
	<form action="infoprofileAction.jsp" method="post" enctype="multipart/form-data">
	<h4>정보제목</h4>
	<input type="file" name="IMG_LINK" value="">
	
	<br>
	<input type="submit" class="edit_btn" name="" value="전송">
	</form>
</body>
</html>