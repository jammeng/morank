package service;
// 문의글의 자바빈즈
public class ServiceDTO {
	private int scid;
	private String scTitle;
	private String userid;
	private String scContent;
	private int scAvailable;
	private String scDate;
	private int statused;
	private int scGood;
	private String classified;
	private String scAnswer;



	public String getScAnswer() {
		return scAnswer;
	}

	public void setScAnswer(String scAnswer) {
		this.scAnswer = scAnswer;
	}

	public String getClassified() {
		return classified;
	}

	public void setClassified(String classified) {
		this.classified = classified;
	}

	public int getScid() {
		return scid;
	}

	public void setScid(int scid) {
		this.scid = scid;
	}

	public String getScTitle() {
		return scTitle;
	}

	public void setScTitle(String scTitle) {
		this.scTitle = scTitle;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getScContent() {
		return scContent;
	}

	public void setScContent(String scContent) {
		this.scContent = scContent;
	}

	public int getScAvailable() {
		return scAvailable;
	}

	public void setScAvailable(int scAvailable) {
		this.scAvailable = scAvailable;
	}

	public String getScDate() {
		return scDate;
	}

	public void setScDate(String scDate) {
		this.scDate = scDate;
	}

	public int getStatused() {
		return statused;
	}

	public void setStatused(int statused) {
		this.statused = statused;
	}

	public int getScGood() {
		return scGood;
	}

	public void setScGood(int scGood) {
		this.scGood = scGood;
	}

	public ServiceDTO() {

	}

	public ServiceDTO(int scid, String scTitle, String userid, String scContent, int scAvailable, String scDate,
			int statused, int scGood, String classified, String scAnswer) {
		super();
		this.scid = scid;
		this.scTitle = scTitle;
		this.userid = userid;
		this.scContent = scContent;
		this.scAvailable = scAvailable;
		this.scDate = scDate;
		this.statused = statused;
		this.scGood = scGood;
		this.classified = classified;
		this.scAnswer = scAnswer;
	}

	

}
