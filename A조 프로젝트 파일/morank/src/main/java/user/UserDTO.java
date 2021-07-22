package user;
// 유저 정보 자바빈즈
public class UserDTO {
	
	private String userid;
	private String pwd;
	private String nixname;
	private String email;
	private String emailhash;
	private boolean emailchecked;
	private int userAvailable;
	private String profile;
	

	public String getUserid() {
		return userid;
	}


	public void setUserid(String userid) {
		this.userid = userid;
	}



	public String getPwd() {
		return pwd;
	}




	public void setPwd(String pwd) {
		this.pwd = pwd;
	}




	public String getNixname() {
		return nixname;
	}




	public void setNixname(String nixname) {
		this.nixname = nixname;
	}



	public String getEmail() {
		return email;
	}



	public void setEmail(String email) {
		this.email = email;
	}



	public String getEmailhash() {
		return emailhash;
	}


	public void setEmailhash(String emailhash) {
		this.emailhash = emailhash;
	}


	public boolean isEmailchecked() {
		return emailchecked;
	}


	public void setEmailchecked(boolean emailchecked) {
		this.emailchecked = emailchecked;
	}



	public int getUserAvailable() {
		return userAvailable;
	}


	public void setUserAvailable(int userAvailable) {
		this.userAvailable = userAvailable;
	}


	public String getProfile() {
		return profile;
	}


	public void setProfile(String profile) {
		this.profile = profile;
	}



	public UserDTO() {
		
	}


	public UserDTO(String userid, String pwd, String nixname, String email, String emailhash, boolean emailchecked,
			int userAvailable, String profile) {
		super();
		this.userid = userid;
		this.pwd = pwd;
		this.nixname = nixname;
		this.email = email;
		this.emailhash = emailhash;
		this.emailchecked = emailchecked;
		this.userAvailable = userAvailable;
		this.profile = profile;
	}


	



	






	
	
	
}
