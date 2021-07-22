package notice;
// �������� ��ü
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

	//�������� �ۼ��� ���Ǵ� �޼ҵ�
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
	// �������� ���� �������ִ� �޼ҵ�
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
	// �Ϻ� �������� ������ �������ִ� �޼ҵ�
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
