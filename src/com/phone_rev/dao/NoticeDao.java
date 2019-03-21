package com.phone_rev.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.phone_rev.dto.NoticeDto;

public class NoticeDao {
	public static final int FAIL = 0;
	public static final int SUCCESS = 1;
	
	private static NoticeDao instance = new NoticeDao();
	public static NoticeDao getInstance() {
		return instance;
	}
	private NoticeDao() {
	}
	private Connection getConnection() throws SQLException {
		Connection conn = null;
		Context ctx;
		try {
			ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/Oracle11g");
			conn = ds.getConnection();
		} catch (NamingException e) {
			System.out.println(e.getMessage());
		}
		return conn;
	}
	
	// 전체 글 목록(삭제 제외)
	public ArrayList<NoticeDto> listExcept(int startRow, int endRow){
		ArrayList<NoticeDto> dtos = new ArrayList<NoticeDto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM (SELECT ROWNUM RN, A.*, ANAME FROM " 
				   + " (SELECT N.*, " 
				   + " (SELECT COUNT(*) FROM N_COMMENT WHERE N.NNUM=N_COMMENT.NNUM) COMMENTCNT " 
				   + " FROM NOTICE N WHERE NDELETE = 1 ORDER BY NNUM DESC)A, ADMIN " 
				   + " WHERE A.AID=ADMIN.AID) " 
				   + " WHERE RN BETWEEN ? AND ?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs    = pstmt.executeQuery();
			while(rs.next()) {
				int    nNum = rs.getInt("nNum");
				String aId = rs.getString("aId");
				String nTitle = rs.getString("nTitle");
				String nContent = rs.getString("nContent");
				Date   nDate = rs.getDate("nDate");
				int    nHit = rs.getInt("nHit");
				String nIp = rs.getString("nIp");
				int    nDelete = rs.getInt("nDelete");
				int    commentCnt = rs.getInt("commentCnt");
				String aName = rs.getString("aName");
				dtos.add(new NoticeDto(nNum, aId, nTitle, nContent, 
						nDate, nHit, nIp, nDelete, commentCnt, aName));
			}
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs!=null) {
					rs.close();
				}
				if(pstmt!=null) {
					pstmt.close();
				}
				if(conn!=null) {
					conn.close();
				}
			}catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return dtos;
	}
	
	// 전체 글 목록(삭제 포함)
	public ArrayList<NoticeDto> list(int startRow, int endRow){
		ArrayList<NoticeDto> dtos = new ArrayList<NoticeDto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM "
				   + " (SELECT ROWNUM RN, A.* FROM "
				   + " (SELECT N.*, ANAME,  "
				   + " (SELECT COUNT(*) FROM N_COMMENT WHERE N.NNUM=N_COMMENT.NNUM) COMMENTCNT "
				   + " FROM NOTICE N, ADMIN A WHERE N.AID = A.AID ORDER BY NNUM DESC)A) "
				   + " WHERE RN BETWEEN ? AND ?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs    = pstmt.executeQuery();
			while(rs.next()) {
				int    nNum = rs.getInt("nNum");
				String aId = rs.getString("aId");
				String nTitle = rs.getString("nTitle");
				String nContent = rs.getString("nContent");
				Date   nDate = rs.getDate("nDate");
				int    nHit = rs.getInt("nHit");
				String nIp = rs.getString("nIp");
				int    nDelete = rs.getInt("nDelete");
				int    commentCnt = rs.getInt("commentCnt");
				String aName = rs.getString("aName");
				dtos.add(new NoticeDto(nNum, aId, nTitle, nContent, 
						nDate, nHit, nIp, nDelete, commentCnt, aName));
			}
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs!=null) {
					rs.close();
				}
				if(pstmt!=null) {
					pstmt.close();
				}
				if(conn!=null) {
					conn.close();
				}
			}catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return dtos;
	}
	
	// 공지 총 갯수(삭제 제외)
	public int getNoticeTotCntExcept() {
		int cnt = 0;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT COUNT(*) FROM NOTICE WHERE NDELETE = 1";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			cnt = rs.getInt(1);
		}catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs!=null) {
					rs.close();
				}
				if(pstmt!=null) {
					pstmt.close();
				}
				if(conn!=null) {
					conn.close();
				}
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return cnt;
	}
	
	// 공지 총 갯수(삭제 포함)
	public int getNoticeTotCnt() {
		int cnt = 0;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT COUNT(*) FROM NOTICE";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			cnt = rs.getInt(1);
		}catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs!=null) {
					rs.close();
				}
				if(pstmt!=null) {
					pstmt.close();
				}
				if(conn!=null) {
					conn.close();
				}
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return cnt;
	}
	
	// 공지 검색(삭제 제외)
	public ArrayList<NoticeDto> searchNoticeExcept(String searchnTitle, int startRow, int endRow){
		ArrayList<NoticeDto> dtos = new ArrayList<NoticeDto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM (SELECT ROWNUM RN, A.*, ANAME FROM " 
				   + " (SELECT N.*, "
				   + " (SELECT COUNT(*) FROM N_COMMENT WHERE N.NNUM=N_COMMENT.NNUM) COMMENTCNT " 
				   + " FROM NOTICE N WHERE NDELETE = 1 ORDER BY NNUM DESC)A, ADMIN "
				   + " WHERE A.AID=ADMIN.AID AND NTITLE LIKE '%' || ? || '%') "
				   + " WHERE RN BETWEEN ? AND ?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchnTitle);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs    = pstmt.executeQuery();
			while(rs.next()) {
				int    nNum = rs.getInt("nNum");
				String aId = rs.getString("aId");
				String nTitle = rs.getString("nTitle");
				String nContent = rs.getString("nContent");
				Date   nDate = rs.getDate("nDate");
				int    nHit = rs.getInt("nHit");
				String nIp = rs.getString("nIp");
				int    nDelete = rs.getInt("nDelete");
				int    commentCnt = rs.getInt("commentCnt");
				String aName = rs.getString("aName");
				dtos.add(new NoticeDto(nNum, aId, nTitle, nContent, nDate, 
						nHit, nIp, nDelete, commentCnt, aName));
				
			}
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs!=null) {
					rs.close();
				}
				if(pstmt!=null) {
					pstmt.close();
				}
				if(conn!=null) {
					conn.close();
				}
			}catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return dtos;
	}
	
	// 공지 검색(삭제 포함)
	public ArrayList<NoticeDto> searchNotice(String searchnTitle, int startRow, int endRow){
		ArrayList<NoticeDto> dtos = new ArrayList<NoticeDto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM "
				   + " (SELECT ROWNUM RN, A.* FROM " 
				   + " (SELECT N.*, ANAME,  "
				   + " (SELECT COUNT(*) FROM N_COMMENT WHERE N.NNUM=N_COMMENT.NNUM) COMMENTCNT " 
				   + " FROM NOTICE N, ADMIN A WHERE N.AID = A.AID  "
				   + " AND NTITLE LIKE '%' || ? || '%' "
				   + " ORDER BY NNUM DESC)A) "
				   + " WHERE RN BETWEEN ? AND ?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchnTitle);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs    = pstmt.executeQuery();
			while(rs.next()) {
				int    nNum = rs.getInt("nNum");
				String aId = rs.getString("aId");
				String nTitle = rs.getString("nTitle");
				String nContent = rs.getString("nContent");
				Date   nDate = rs.getDate("nDate");
				int    nHit = rs.getInt("nHit");
				String nIp = rs.getString("nIp");
				int    nDelete = rs.getInt("nDelete");
				int    commentCnt = rs.getInt("commentCnt");
				String aName = rs.getString("aName");
				dtos.add(new NoticeDto(nNum, aId, nTitle, nContent, nDate, 
						nHit, nIp, nDelete, commentCnt, aName));
				
			}
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs!=null) {
					rs.close();
				}
				if(pstmt!=null) {
					pstmt.close();
				}
				if(conn!=null) {
					conn.close();
				}
			}catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return dtos;
	}
	
	// 검색된 공지 총 갯수(삭제 제외)
	public int searchNoticeCntExcept(String searchnTitle) {
		int totCnt = 0;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT COUNT(*) FROM NOTICE WHERE NDELETE = 1 AND NTITLE LIKE '%' || ? || '%'";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchnTitle);
			rs = pstmt.executeQuery();
			rs.next();
			totCnt = rs.getInt(1);
		}catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs!=null) {
					rs.close();
				}
				if(pstmt!=null) {
					pstmt.close();
				}
				if(conn!=null) {
					conn.close();
				}
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return totCnt;
	}
	
	// 검색된 공지 총 갯수(삭제 포함)
	public int searchNoticeCnt(String searchnTitle) {
		int totCnt = 0;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT COUNT(*) FROM NOTICE WHERE NTITLE LIKE '%' || ? || '%'";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchnTitle);
			rs = pstmt.executeQuery();
			rs.next();
			totCnt = rs.getInt(1);
		}catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs!=null) {
					rs.close();
				}
				if(pstmt!=null) {
					pstmt.close();
				}
				if(conn!=null) {
					conn.close();
				}
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return totCnt;
	}
	
	
	// 조회수 올리기
	private void hitUp(int nNum) {
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE NOTICE SET NHIT = NHIT + 1 WHERE NNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, nNum);
			pstmt.executeUpdate();
		}catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt!=null) {
					pstmt.close();
				}
				if(conn!=null) {
					conn.close();
				}
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		}
	}
	
	// 글 상세보기(nNum으로 DTO가져오기)
	public NoticeDto contentView(int nNum) {
		hitUp(nNum);
		NoticeDto dto = null;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT N.*, ANAME,  " 
				   + " (SELECT COUNT(*) FROM N_COMMENT WHERE N.NNUM=N_COMMENT.NNUM) COMMENTCNT " 
				   + " FROM NOTICE N, ADMIN A WHERE N.AID = A.AID AND NNUM = ?";
		try {
			conn  = getConnection();	
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, nNum);
			rs    = pstmt.executeQuery();
			while(rs.next()) {
				String aId = rs.getString("aId");
				String nTitle = rs.getString("nTitle");
				String nContent = rs.getString("nContent");
				Date   nDate = rs.getDate("nDate");
				int    nHit = rs.getInt("nHit");
				String nIp = rs.getString("nIp");
				int    nDelete = rs.getInt("nDelete");
				int    commentCnt = rs.getInt("commentCnt");
				String aName = rs.getString("aName");
				dto = new NoticeDto(nNum, aId, nTitle, nContent, nDate,
						nHit, nIp, nDelete, commentCnt, aName);
			}
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs!=null) {
					rs.close();
				}
				if(pstmt!=null) {
					pstmt.close();
				}
				if(conn!=null) {
					conn.close();
				}
			}catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return dto;
	}
	
	// 글 작성
	public int writeNotice(String aId, String nTitle, String nContent, String nIp) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO NOTICE (nNum, aId, nTitle, nContent, nIp) "
				   + " VALUES (NOTICE_SEQ.NEXTVAL, ?, ?, ?, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, aId);
			pstmt.setString(2, nTitle);
			pstmt.setString(3, nContent);
			pstmt.setString(4, nIp);
			result = pstmt.executeUpdate();
			System.out.println(result==SUCCESS? "리뷰 쓰기 성공" : "리뷰 쓰기 실패");
		}catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt!=null) {
					pstmt.close();
				}
				if(conn!=null) {
					conn.close();
				}
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
	

	// 수정 view (nNum으로 DTO가져오기)
	public NoticeDto noticeModifyView(int nNum) {
		NoticeDto dto = null;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT N.*, ANAME,  "
				   + " (SELECT COUNT(*) FROM N_COMMENT WHERE N.NNUM=N_COMMENT.NNUM) COMMENTCNT " 
				   + " FROM NOTICE N, ADMIN A WHERE N.AID = A.AID AND NNUM = ?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, nNum);
			rs    = pstmt.executeQuery();
			while(rs.next()) {
				String aId = rs.getString("aId");
				String nTitle = rs.getString("nTitle");
				String nContent = rs.getString("nContent");
				Date   nDate = rs.getDate("nDate");
				int    nHit = rs.getInt("nHit");
				String nIp = rs.getString("nIp");
				int    nDelete = rs.getInt("nDelete");
				int    commentCnt = rs.getInt("commentCnt");
				String aName = rs.getString("aName");
				dto = new NoticeDto(nNum, aId, nTitle, nContent, nDate, 
						nHit, nIp, nDelete, commentCnt, aName);
			}
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs!=null) {
					rs.close();
				}
				if(pstmt!=null) {
					pstmt.close();
				}
				if(conn!=null) {
					conn.close();
				}
			}catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return dto;
	}
	
	// 글 수정
	public int modifyNotice(String nTitle, String nContent, String nIp, int nNum) { 
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE NOTICE SET NTITLE = ?,  "
				   + " NCONTENT = ?,  "
				   + " NDATE = SYSDATE,  "
				   + " NIP = ? " 
				   + " WHERE NNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nTitle);
			pstmt.setString(2, nContent);
			pstmt.setString(3, nIp);
			pstmt.setInt(4, nNum);
			result = pstmt.executeUpdate();
			System.out.println(result==SUCCESS? "수정 성공" : "수정 실패");
		}catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt!=null) {
					pstmt.close();
				}
				if(conn!=null) {
					conn.close();
				}
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
	
	// 글 삭제
	public int deleteNotice(int nNum) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE NOTICE SET NDELETE = 0 WHERE NNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, nNum);
			result = pstmt.executeUpdate();
			System.out.println(result==SUCCESS? "삭제 성공" : "삭제 실패");
		}catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt!=null) {
					pstmt.close();
				}
				if(conn!=null) {
					conn.close();
				}
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
	
	// 글 복구
	public int recoverNotice(int nNum) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE NOTICE SET NDELETE=1 WHERE NNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, nNum);
			result = pstmt.executeUpdate();
			System.out.println(result==SUCCESS? "복구 성공" : "복구 실패");
		}catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt!=null) {
					pstmt.close();
				}
				if(conn!=null) {
					conn.close();
				}
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
}
