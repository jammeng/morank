<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.mail.Transport"%>
<%@ page import="javax.mail.Message"%>
<%@ page import="javax.mail.Address"%>
<%@ page import="javax.mail.internet.InternetAddress"%>
<%@ page import="javax.mail.internet.MimeMessage"%>
<%@ page import="javax.mail.Session"%>
<%@ page import="javax.mail.Authenticator"%>
<%@ page import="java.util.Properties"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="util.Gmail"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDTO"%>
<%
// 유저 이메일을 가져올 객체 생성
UserDAO userDAO = new UserDAO();
//회원가입 페이지 (3)
// 유저 세션 정보를 가져와 로그인 시 접근을 제한 하기위함
String userid = null;
if (session.getAttribute("userid") != null) {
	userid = (String) session.getAttribute("userid");
}
// 회원가입 절차를 무시하고 접근 시 방지하기 위함
if (userid == null) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('잘못된 접근 입니다.')");
	script.println("location.href = 'login.jsp'");
	script.println("</script>");
	script.close();
	return;
}
// 이메일 인증이 완료 되었는데 접근 시 방지하기 위함
boolean emailChecked = userDAO.getUserEmailChecked(userid);
if (emailChecked == true) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('이미 인증된 회원 입니다.')");
	script.println("location.href = 'index.jsp'");
	script.println("</script>");
	script.close();
	return;
}

String host = "http://jusu0369.cafe24.com/"; //사이트 주소
String from = "pcj0228test.gmail.com"; //구글아이디
String to = userDAO.getUserEmail(userid); //유저아이디
String subject = "모랭 사이트 회원가입 이메일 인증 메일 입니다."; // 메일 제목
String content = "다음 링크에 접속하여 이메일 인증을 진행하세요." + "<a href='" + host + "emailCheckAction.jsp?code="
		+ new SHA256().getSHA256(to) + "'><br>이메일 인증하기</a>"; // 메일 내용
// 이메일 전송 내용 저장
Properties p = new Properties();
p.put("mail.smtp.user", from);
p.put("mail.smtp.host", "smtp.googlemail.com");
p.put("mail.smtp.port", "465");
p.put("mail.smtp.starttls.enable", "true");
p.put("mail.smtp.auth", "true");
p.put("mail.smtp.debug", "true");
p.put("mail.smtp.socketFactory.port", "465");
p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
p.put("mail.smtp.socketFactory.fallback", "false");
//이메일 전송
try {
	Authenticator auth = new Gmail();
	Session ses = Session.getInstance(p, auth);
	ses.setDebug(true);
	MimeMessage msg = new MimeMessage(ses);
	msg.setSubject(subject);
	Address fromAddr = new InternetAddress(from);
	msg.setFrom(fromAddr);
	Address toAddr = new InternetAddress(to);
	msg.addRecipient(Message.RecipientType.TO, toAddr);
	msg.setContent(content, "text/html;charset=UTF-8");
	Transport.send(msg);
} catch (Exception e) {
	e.printStackTrace();
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('오류가 발생 했습니다.')");
	script.println("history.back()");
	script.println("</script>");
	script.close();
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/join3.css">
</head>
<body>
	<%
	UserDTO user = userDAO.getuser(userid);
	%>
	<div id="wrapper">
		<div class="logo">
			<a href="index.jsp"><img src="images/모두의랭킹6.png" alt=""></a>
		</div>
		<div class="button">
			<img src="images/join_button_off.png" alt=""> <img
				src="images/join_button_off.png" alt=""> <img
				src="images/join_button.png" alt=""> <img
				src="images/join_button_off.png" alt="">
		</div>
		<p class="title">이메일 전송 안내</p>
		<hr>
		<div class="contents">
			<p>
				<a href="https://nid.naver.com/"><u><%=user.getEmail() %></u></a>(으)로 인증
				메일이 발송되었습니다.
			</p>
		</div>
		<button type="button" class="email-check" name="button"
			onclick="location.href='http://www.naver.com'">메일 확인하러 가기</button>
		<div class="footer">
			메일을 받지 못하셨나요? <a href="join3.jsp"> 다시 보내기 </a>
		</div>
	</div>
	<footer>Changju Co.</footer>
</body>
</html>