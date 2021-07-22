package notice;
// 공지사항 객체
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import service.ServiceDTO;
import util.DatabaseUtil;

public class NoticeDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	//공지사항 작성시 사용되는 메소드
	public int write(NoticeDTO noticeDTO) {

		String SQL = "INSERT INTO NOTICE VALUES (NULL, ?, ?)";
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, noticeDTO.getNoticeTitle());
			pstmt.setString(2, noticeDTO.getNoticeContent());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}

			try {
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}

			try {
				if (rs != null)
					rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
	// 공지글을 전부 가져와주는 메소드
	public ArrayList<NoticeDTO> getList() {
		String SQL = "SELECT * FROM NOTICE ORDER BY noticeid  DESC";
		ArrayList<NoticeDTO> list = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			list = new ArrayList<NoticeDTO>();
			while (rs.next()) {
				NoticeDTO noticeDTO = new NoticeDTO();
				noticeDTO.setNoticeid(rs.getInt(1));
				noticeDTO.setNoticeTitle(rs.getString(2));
				noticeDTO.setNoticeContent(rs.getString(3));
				list.add(noticeDTO);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}

			try {
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}

			try {
				if (rs != null)
					rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	// 일부 공지글의 정보를 가져와주는 메소드
	public NoticeDTO getnotice(String noticeid) {
		String SQL = "SELECT * FROM NOTICE WHERE noticeid=?";
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, noticeid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				NoticeDTO noticeDTO = new NoticeDTO();
				noticeDTO.setNoticeid(rs.getInt(1));
				noticeDTO.setNoticeTitle(rs.getString(2));
				noticeDTO.setNoticeContent(rs.getString(3));
				return noticeDTO;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}

			try {
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}

			try {
				if (rs != null)
					rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}
}
