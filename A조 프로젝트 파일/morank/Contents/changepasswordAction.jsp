<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8"); //사용자에게 받은 데이터를 변경
	String userid=null;
	String pwd=null;
	String change=null; // 변경할 비밀번호
	String rechange=null; // 변경할 비밀번호 확인
	//유저아이디 세션 유지
	if (session.getAttribute("userid") != null) {
		userid = (String) session.getAttribute("userid");
	}
	//비밀번호 입력 정보 가져오기
	if (request.getParameter("pwd") != null){
		pwd = request.getParameter("pwd");
	}
	//변경할 비밀번호 입력 정보 가져오기
	if (request.getParameter("change") != null){
		change = request.getParameter("change");
	}
	//변경할 비밀번호 확인 입력 정보 가져오기
	if (request.getParameter("rechange") != null){
		rechange = request.getParameter("rechange");
	} 
	
	// 입력이 없을시 이전페이지 이동
	if (pwd==null || change==null || rechange==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	}
	// 변경할 비밀번호와 변경할 비밀번호 확인이 일치하지 않으면 이전페이제 이동
	if (!change.equals(rechange)){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('변경 하실 비밀번호가 일치 하지 않습니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	}
	// 유저 디비 접근 객체 생성
	UserDAO userDAO = new UserDAO();
	// 결과값에 저장(로그인 객체 사용)
	int result = userDAO.login(userid, pwd);
	// 디비연동 성공
	if (result == 1){
		//결과값 저장 (비밀번호 변경 객체 사용)
		int reslt = userDAO.changepassword(userid, change);
		// 비밀번호 변경 객체 디비 연동 실패
		if (reslt == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
			script.close();
		}
		// 디비연동 성공
		else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호 수정 완료 되었습니다. 다시 로그인 해주세요')");
			script.println("location.href = 'logoutAction.jsp'");
			script.println("</script>");
			script.close();
		}
	}
	// 입력받은 현재 비밀번호가 다를 시
	else if (result==0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
	}
	// 디비에 입력받은 아이디가 없을 시
	else if (result==-1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('아이디가 없습니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
	}
	// 로그인 객체 디비 연동 오류시
	else if (result==-2) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
	}
%>
</body>
</html>