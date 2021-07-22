package util;
//이메일 연동 객체
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Gmail extends Authenticator {
	
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication("구글아이디", "구글비밀번호"); //본인 아이디
	}
	
	
	
	
}
