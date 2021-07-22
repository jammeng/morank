package searchdao;
// 댓글정보 객체
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


import searchdto.commentsVO;
import util.DatabaseUtil;

public class commentsDAO {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	// 댓글 정보를 가져와주는 메소드
	public ArrayList<commentsVO> getcomments(String info_id) {
		ArrayList<commentsVO> ArrtDto = new ArrayList<commentsVO>();
		String sql = "select * from comments where info_id=? ORDER BY comment_id DESC";
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, info_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				commentsVO cVo = new commentsVO();
				cVo.setInfo_id(rs.getString(1));
				cVo.setUser_img(rs.getString(2));
				cVo.setUser_id(rs.getString(3));
				cVo.setComments_info(rs.getString(4));
				ArrtDto.add(cVo);

			}

		} catch (Exception e) {
			e.printStackTrace();
		} 
		finally {
			try {
				if (conn != null)
					conn.close();
				if (pstmt != null)
					pstmt.close();
				if (rs != null)
					rs.close();
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		return ArrtDto;
	}
	// 댓글 작성시 사용되는 메소드
	public int creatcomment(commentsVO commentsvo) {
		String sql = "INSERT INTO comments VALUES(?,?,?,?,0)";
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, commentsvo.getInfo_id());
			pstmt.setString(2, commentsvo.getUser_img());
			pstmt.setString(3, commentsvo.getUser_id());
			pstmt.setString(4, commentsvo.getComments_info());
	        return pstmt.executeUpdate();
	        
	     } catch (Exception e) {
	        e.printStackTrace();
	     } 
		return -1;
	  }
	
}
