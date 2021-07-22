<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
// 마구잡이로 저장된 세션값을 초기화해주는 페이지
session.removeAttribute("total");
session.removeAttribute("search");
session.removeAttribute("info_id");
session.removeAttribute("info_name");
PrintWriter script = response.getWriter();
script.println("<script>");
script.println("location.href = 'index.jsp'");
script.println("</script>");
script.close();
%>
</body>
</html>