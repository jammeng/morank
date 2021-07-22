package searchdto;
// 검색 정보 자바빈즈
public class informationVO {
	private String BigC_id;
	private String SmallC_id;    
	private String info_id;      
	private String info_name;    
	private String keyword;      
	private String info_content;
	private int likeamount;
	private String img_link;
	private String producer;
	
	

	
	
	public String getBigC_id() {
		return BigC_id;
	}





	public void setBigC_id(String bigC_id) {
		BigC_id = bigC_id;
	}





	public String getSmallC_id() {
		return SmallC_id;
	}





	public void setSmallC_id(String smallC_id) {
		SmallC_id = smallC_id;
	}





	public String getInfo_id() {
		return info_id;
	}





	public void setInfo_id(String info_id) {
		this.info_id = info_id;
	}





	public String getInfo_name() {
		return info_name;
	}





	public void setInfo_name(String info_name) {
		this.info_name = info_name;
	}





	public String getKeyword() {
		return keyword;
	}





	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}





	public String getInfo_content() {
		return info_content;
	}





	public void setInfo_content(String info_content) {
		this.info_content = info_content;
	}





	public int getLikeamount() {
		return likeamount;
	}





	public void setLikeamount(int likeamount) {
		this.likeamount = likeamount;
	}





	public String getImg_link() {
		return img_link;
	}





	public void setImg_link(String img_link) {
		this.img_link = img_link;
	}





	public String getProducer() {
		return producer;
	}





	public void setProducer(String producer) {
		this.producer = producer;
	}





	public informationVO() {
		
	}





	public informationVO(String bigC_id, String smallC_id, String info_id, String info_name, String keyword,
			String info_content, int likeamount, String img_link, String producer) {
		super();
		BigC_id = bigC_id;
		SmallC_id = smallC_id;
		this.info_id = info_id;
		this.info_name = info_name;
		this.keyword = keyword;
		this.info_content = info_content;
		this.likeamount = likeamount;
		this.img_link = img_link;
		this.producer = producer;
	}
	
	
	
	
	
	
}
