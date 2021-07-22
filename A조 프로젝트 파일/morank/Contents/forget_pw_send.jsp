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
//비밀번호 찾기 페이지
UserDAO userDAO = new UserDAO(); //객체생성
String userid = null; 
String email = null;
// 값 저장
if (request.getParameter("userid") != null) {
	userid = request.getParameter("userid");
}
if (request.getParameter("email") != null) {
	email = request.getParameter("email");
}
// 정보가 없을시 리턴
if (userid == null || email == null) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('입력이 안 된 사항이 있습니다.')");
	script.println("history.back()");
	script.println("</script>");
	script.close();
	return;
}

//자바빈즈 객체에서 불러온 내용 저장
UserDTO userdto = userDAO.getuser(userid);
// 회원정보에서 이메일을 
if (!userdto.getUserid().equals(userid) || !userdto.getEmail().equals(email)){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('회원정보와 일치하지 않습니다.')");
	script.println("history.back()");
	script.println("</script>");
	script.close();
	return;
}

//사이트 주소
String host = "http://localhost:8080/morank/";
String from = "pcj0228test.gmail.com";//구글아이디
String to = userDAO.getUserEmail(userid);//유저아이디
String subject = "모랭 사이트 비밀번호 찾기 메일 입니다."; //제목
String content = "회원님의 비밀 번호는 "+userdto.getPwd()+" 입니다." + "<a href='" + host + "login.jsp'><br>로그인하기</a>"; //메일내용
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
<link rel="stylesheet" href="css/forget_pw_send.css">

</head>
<body>
	<div id="wrapper">
		<section>
			<article class="main">
				<div class="contents">
					<div class="logo">
						<a href="index.html"><img src="images/모두의랭킹2.png"
							width="250px" alt=""></a>
					</div>
					<div class="content">
						<h1>비밀번호 찾기</h1>
						<p>
							입력하신 이메일 주소로 전송된<br>메일의 링크를 확인해주세요.
						</p>
						<div class="email_send">
							<p>
								<u><a href="http://www.naver.com"><%=userdto.getEmail() %></a></u>으로
								비밀번호가 전송되었습니다.
							</p>
						</div>
						<button type="button" name="button"
							onclick="location.href='http://www.naver.com'">이메일 확인하러
							가기</button>
					</div>
					<a href="login.jsp">로그인 하러가기</a>
				</div>
	</div>
	</article>
	</section>
	</div>

</body>
</html>