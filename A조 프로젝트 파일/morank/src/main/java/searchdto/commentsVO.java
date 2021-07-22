package searchdto;
// ¥Ò±€ ¿⁄πŸ ∫Û¡Ó
public class commentsVO {
	private String info_id;
	private String user_img;
	private String user_id;
	private String comments_info;
	private int comment_id;
	
	
	public String getInfo_id() {
		return info_id;
	}


	public void setInfo_id(String info_id) {
		this.info_id = info_id;
	}


	public String getUser_img() {
		return user_img;
	}


	public void setUser_img(String user_img) {
		this.user_img = user_img;
	}


	public String getUser_id() {
		return user_id;
	}


	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}


	public String getComments_info() {
		return comments_info;
	}


	public void setComments_info(String comments_info) {
		this.comments_info = comments_info;
	}


	public int getComment_id() {
		return comment_id;
	}


	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}


	public commentsVO() {
		
	}


	public commentsVO(String info_id, String user_img, String user_id, String comments_info, int comment_id) {
		super();
		this.info_id = info_id;
		this.user_img = user_img;
		this.user_id = user_id;
		this.comments_info = comments_info;
		this.comment_id = comment_id;
	}
	
	
	
}
