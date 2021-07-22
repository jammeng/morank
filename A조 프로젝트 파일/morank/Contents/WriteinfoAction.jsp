<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="searchdto.informationVO"%>
<%@ page import="searchdao.informationDAO"%>
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
	// 검색 정보을 데이터베이스에 전달해주는 페이지
	request.setCharacterEncoding("UTF-8");
	// 입력 받은 검색 정보들의 내용을 담을 변수
	String BigC_id = null;
	String SmallC_id = null;
	String info_name = null;
	String keyword = null;
	String producer = null;
	String info_content = null;
	String num = "1";
	int num1 = 0;
	int num2 = 0;
	String result1 = null;
	// 정보테이블에 저장해줄 객체 생성
		informationDAO infoDAO = new informationDAO();
	
	// 전달받은 값을 변수에 넣어줌
	if(request.getParameter("BigC_id") != null){
		BigC_id = request.getParameter("BigC_id");
	}
	if(request.getParameter("SmallC_id") != null){
		SmallC_id = request.getParameter("SmallC_id");
	}
	if(request.getParameter("info_name") != null){
		info_name = request.getParameter("info_name");
	}
	if(request.getParameter("keyword") != null){
		keyword = request.getParameter("keyword");
	}
	
	if(request.getParameter("producer") != null){
		producer = request.getParameter("producer");
	}
	if(request.getParameter("info_content") != null){
		info_content = request.getParameter("info_content");
	}
	// 키워드 변수는 입력시 앞에 #이 있어야해서 띄어쓰기시 #을 넣어줄게있게 해줌
	if (keyword.contains(" ")){
		keyword = keyword.replace(" ", "#");
	}
	// info_id는 카테고리(대)와 카테고리(소)의 앞글자를 가져와 합쳐준 컬럼이다
	String info_id = BigC_id.substring(0,1)+"_"+SmallC_id.substring(0,1)+"_"+num;
	
	
	if (infoDAO.getprimarykey(info_id)==true){
		result1 = infoDAO.getinfoid(BigC_id, SmallC_id);
		num1 = result1.indexOf("_",2);
		num = result1.substring(num1+1,result1.length());
		num2 = Integer.parseInt(num);
		if(num2>=9){
			num2+=1;
		}
		num2+=1;
		info_id = result1.substring(0, num1+1)+Integer.toString(num2);
	}
	
	// 입력사항이 없을 시 방지
	if (BigC_id == null || SmallC_id == null || info_name == null || keyword == null ||  producer == null || info_content == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	}
	
	// 정보테이블에 저장해줄 메소드 생성
	int result = infoDAO.writeinfo(new informationVO(BigC_id, SmallC_id, info_id, info_name, keyword, info_content, 0, null, producer));
	if (result == -1){// 디비오류
		PrintWriter outter = response.getWriter();
		outter.println("<script>");
		outter.println("alert('글쓰기에 실패 했습니다.')");
		outter.println("history.back()");
		outter.println("</script>");
	}
	else {// 완료
		PrintWriter outter = response.getWriter();
		outter.println("<script>");
		outter.println("alert('등록완료')");
		outter.println("location.href = 'search.jsp'");
		outter.println("</script>");
	}
%>

</body>
</html>