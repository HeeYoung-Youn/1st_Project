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

import com.phone_rev.dto.ReviewDto;

public class ReviewDao {
	public static final int FAIL = 0;
	public static final int SUCCESS = 1;
	
	private static ReviewDao instance = new ReviewDao();
	public static ReviewDao getInstance() {
		return instance;
	}
	private ReviewDao() {
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
	
	// 리뷰 검색(삭제 제외)
	public ArrayList<ReviewDto> searchReviewExcept(String searchrTitle, int startRow, int endRow){
		ArrayList<ReviewDto> dtos = new ArrayList<ReviewDto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM "
				   + " (SELECT ROWNUM RN, A.* FROM "
				   + " (SELECT R.*, "
				   + " (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT, "
				   + " (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT, MNAME "
				   + " FROM REVIEW R, MEMBER M WHERE R.MID = M.MID AND RDELETE = 1  "
				   + " AND RTITLE LIKE '%' || ? || '%' "
				   + " ORDER BY RNUM DESC)A) "
				   + " WHERE RN BETWEEN ? AND ?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchrTitle);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs    = pstmt.executeQuery();
			while(rs.next()) {
				int    rNum        = rs.getInt("rNum");
				String mId         = rs.getString("mId");
				String rTitle      = rs.getString("rTitle");
				String rContent    = rs.getString("rContent");
				String rFileName_1 = rs.getString("rFileName_1");
				String rFileName_2 = rs.getString("rFileName_2");
				String rFileName_3 = rs.getString("rFileName_3");
				String rFileName_4 = rs.getString("rFileName_4");
				String rFileName_5 = rs.getString("rFileName_5");
				Date   rDate       = rs.getDate("rDate");
				int    rHit        = rs.getInt("rHit");
				String rIp         = rs.getString("rIp");
				int    rDelete     = rs.getInt("rDelete");
				int    commentCnt  = rs.getInt("commentCnt");
				int    likeCnt     = rs.getInt("likeCnt");
				String mName       = rs.getString("mName");
				dtos.add(new ReviewDto(rNum, mId, rTitle, rContent, rFileName_1, 
						rFileName_2, rFileName_3, rFileName_4, rFileName_5, 
						rDate, rHit, rIp, rDelete, commentCnt, likeCnt, mName));
			}
		}catch (Exception e) {
			System.out.println("????"+e.getMessage());
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
	
	// 리뷰 검색(삭제 포함)
	public ArrayList<ReviewDto> searchReview(String searchrTitle, int startRow, int endRow){
		ArrayList<ReviewDto> dtos = new ArrayList<ReviewDto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM "
				   + " (SELECT ROWNUM RN, A.* FROM " 
				   + " (SELECT R.*, "
				   + " (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT, " 
				   + " (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT, MNAME "
				   + " FROM REVIEW R, MEMBER M WHERE R.MID = M.MID  "
				   + " AND RTITLE LIKE '%' || ? || '%'ORDER BY RNUM DESC)A) " 
				   + " WHERE RN BETWEEN ? AND ?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchrTitle);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs    = pstmt.executeQuery();
			while(rs.next()) {
				int    rNum        = rs.getInt("rNum");
				String mId         = rs.getString("mId");
				String rTitle      = rs.getString("rTitle");
				String rContent    = rs.getString("rContent");
				String rFileName_1 = rs.getString("rFileName_1");
				String rFileName_2 = rs.getString("rFileName_2");
				String rFileName_3 = rs.getString("rFileName_3");
				String rFileName_4 = rs.getString("rFileName_4");
				String rFileName_5 = rs.getString("rFileName_5");
				Date   rDate       = rs.getDate("rDate");
				int    rHit        = rs.getInt("rHit");
				String rIp         = rs.getString("rIp");
				int    rDelete     = rs.getInt("rDelete");
				int    commentCnt  = rs.getInt("commentCnt");
				int    likeCnt     = rs.getInt("likeCnt");
				String mName       = rs.getString("mName");
				dtos.add(new ReviewDto(rNum, mId, rTitle, rContent, rFileName_1, 
						rFileName_2, rFileName_3, rFileName_4, rFileName_5, 
						rDate, rHit, rIp, rDelete, commentCnt, likeCnt, mName));
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
	
	// 검색된 리뷰 총 갯수(삭제 제외)
	public int searchReviewCntExcept(String searchrTitle) {
		int totCnt = 0;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT COUNT(*) FROM REVIEW WHERE RDELETE = 1 AND RTITLE LIKE '%' || ? || '%'";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchrTitle);
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
	
	// 검색된 리뷰 총 갯수(삭제 포함)
		public int searchReviewCnt(String searchrTitle) {
			int totCnt = 0;
			Connection        conn  = null;
			PreparedStatement pstmt = null;
			ResultSet         rs    = null;
			String sql = "SELECT COUNT(*) FROM REVIEW WHERE RTITLE LIKE '%' || ? || '%'";
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, searchrTitle);
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
	
	// 내가 쓴 리뷰
	public ArrayList<ReviewDto> myReview(String mId, int startRow, int endRow){
		ArrayList<ReviewDto> dtos = new ArrayList<ReviewDto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM (SELECT ROWNUM RN, A.*, MNAME FROM "
				   + " (SELECT R.*, "
				   + " (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT, " 
				   + " (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT  "
				   + " FROM REVIEW R WHERE RDELETE = 1 AND R.MID=? ORDER BY RNUM DESC)A, MEMBER " 
				   + " WHERE A.MID=MEMBER.MID) "
				   + " WHERE RN BETWEEN ? AND ?";
		
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mId);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs    = pstmt.executeQuery();
			while(rs.next()) {
				int    rNum        = rs.getInt("rNum");
				String rTitle      = rs.getString("rTitle");
				String rContent    = rs.getString("rContent");
				String rFileName_1 = rs.getString("rFileName_1");
				String rFileName_2 = rs.getString("rFileName_2");
				String rFileName_3 = rs.getString("rFileName_3");
				String rFileName_4 = rs.getString("rFileName_4");
				String rFileName_5 = rs.getString("rFileName_5");
				Date   rDate       = rs.getDate("rDate");
				int    rHit        = rs.getInt("rHit");
				String rIp         = rs.getString("rIp");
				int    rDelete     = rs.getInt("rDelete");
				int    commentCnt  = rs.getInt("commentCnt");
				int    likeCnt     = rs.getInt("likeCnt");
				String mName       = rs.getString("mName");
				dtos.add(new ReviewDto(rNum, mId, rTitle, rContent, rFileName_1, 
						rFileName_2, rFileName_3, rFileName_4, rFileName_5, 
						rDate, rHit, rIp, rDelete, commentCnt, likeCnt, mName));
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
	
	// 내가 쓴 리뷰 총 갯수
	public int myReviewCnt(String mId) {
		int totCnt = 0;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT COUNT(*) FROM REVIEW WHERE MID=? AND RDELETE = 1";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mId);
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
	private void hitUp(int rNum) {
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE REVIEW SET RHIT = RHIT + 1 WHERE RNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rNum);
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
	
	// 글 상세보기(rNum으로 DTO가져오기)
	public ReviewDto contentView(int rNum) {
		hitUp(rNum);
		ReviewDto dto = null;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT R.*, " 
				   + " (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT, " 
				   + " (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT, MNAME "
				   + " FROM REVIEW R, MEMBER M WHERE R.MID = M.MID AND RNUM = ?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rNum);
			rs    = pstmt.executeQuery();
			while(rs.next()) {
				String mId         = rs.getString("mId");
				String rTitle      = rs.getString("rTitle");
				String rContent    = rs.getString("rContent");
				String rFileName_1 = rs.getString("rFileName_1");
				String rFileName_2 = rs.getString("rFileName_2");
				String rFileName_3 = rs.getString("rFileName_3");
				String rFileName_4 = rs.getString("rFileName_4");
				String rFileName_5 = rs.getString("rFileName_5");
				Date   rDate       = rs.getDate("rDate");
				int    rHit        = rs.getInt("rHit");
				String rIp         = rs.getString("rIp");
				int    rDelete     = rs.getInt("rDelete");
				int    commentCnt  = rs.getInt("commentCnt");
				int    likeCnt     = rs.getInt("likeCnt");
				String mName       = rs.getString("mName");
				dto = new ReviewDto(rNum, mId, rTitle, rContent, rFileName_1, 
						rFileName_2, rFileName_3, rFileName_4, rFileName_5, 
						rDate, rHit, rIp, rDelete, commentCnt, likeCnt, mName);
			}
		}catch (Exception e) {
			System.out.println("error:"+e.getMessage());
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
	public int writeReview(String mId, String rTitle, String rContent, 
			String rFileName_1, String rFileName_2, String rFileName_3, 
			String rFileName_4, String rFileName_5, String rIp) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO REVIEW (rNum, mId, rTitle, rContent, rFileName_1, rFileName_2,  "
				   + " rFileName_3, rFileName_4, rFileName_5, rIp) "
				   + " VALUES (REVIEW_SEQ.NEXTVAL, ?, ?, ?, ?, ?, " 
				   + " ?, ?, ?, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mId);
			pstmt.setString(2, rTitle);
			pstmt.setString(3, rContent);
			pstmt.setString(4, rFileName_1);
			pstmt.setString(5, rFileName_2);
			pstmt.setString(6, rFileName_3);
			pstmt.setString(7, rFileName_4);
			pstmt.setString(8, rFileName_5);
			pstmt.setString(9, rIp);
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
	

	// 수정 view (rNum으로 DTO가져오기)
	public ReviewDto reviewModifyView(int rNum) {
		ReviewDto dto = null;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT R.*, "
				   + " (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT, " 
				   + " (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT, MNAME "
				   + " FROM REVIEW R, MEMBER M WHERE R.MID = M.MID AND RNUM = ?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rNum);
			rs    = pstmt.executeQuery();
			while(rs.next()) {
				String mId         = rs.getString("mId");
				String rTitle      = rs.getString("rTitle");
				String rContent    = rs.getString("rContent");
				String rFileName_1 = rs.getString("rFileName_1");
				String rFileName_2 = rs.getString("rFileName_2");
				String rFileName_3 = rs.getString("rFileName_3");
				String rFileName_4 = rs.getString("rFileName_4");
				String rFileName_5 = rs.getString("rFileName_5");
				Date   rDate       = rs.getDate("rDate");
				int    rHit        = rs.getInt("rHit");
				String rIp         = rs.getString("rIp");
				int    rDelete     = rs.getInt("rDelete");
				int    commentCnt  = rs.getInt("commentCnt");
				int    likeCnt     = rs.getInt("likeCnt");
				String mName       = rs.getString("mName");
				dto = new ReviewDto(rNum, mId, rTitle, rContent, rFileName_1, 
						rFileName_2, rFileName_3, rFileName_4, rFileName_5, 
						rDate, rHit, rIp, rDelete, commentCnt, likeCnt, mName);
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
	public int modifyReview(String rTitle, String rContent, 
			String rFileName_1, String rFileName_2, String rFileName_3, 
			String rFileName_4, String rFileName_5, String rIp, int rNum) { 
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE REVIEW SET RTITLE = ?, " 
				   + " RCONTENT    = ?,  "
				   + " RFILENAME_1 = ?,  "
				   + " RFILENAME_2 = ?,  " 
				   + " RFILENAME_3 = ?,  " 
				   + " RFILENAME_4 = ?,  " 
				   + " RFILENAME_5 = ?,  " 
				   + " RDATE       = SYSDATE,  " 
				   + " RIP         = ? " 
				   + " WHERE RNUM  = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rTitle);
			pstmt.setString(2, rContent);
			pstmt.setString(3, rFileName_1);
			pstmt.setString(4, rFileName_2);
			pstmt.setString(5, rFileName_3);
			pstmt.setString(6, rFileName_4);
			pstmt.setString(7, rFileName_5);
			pstmt.setString(8, rIp);
			pstmt.setInt(9, rNum);
			result = pstmt.executeUpdate();
			System.out.println(result==SUCCESS? "수정 성공" : "수정 실패");
		}catch (SQLException e) { // 지금 발생되는 exception이 SQLException임
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
	public int deleteReview(int rNum) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE REVIEW SET RDELETE = 0 WHERE RNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rNum);
			result = pstmt.executeUpdate();
			System.out.println(result==SUCCESS? "삭제 성공" : "삭제 실패");
		}catch (SQLException e) { // 지금 발생되는 exception이 SQLException임
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
	public int recoverReview(int rNum) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE REVIEW SET RDELETE = 1 WHERE RNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rNum);
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
	
	// 최근 리뷰 8개의 dto 가져오기
	public ArrayList<ReviewDto> getReviewList(){
		ArrayList<ReviewDto> reviewList = new ArrayList<ReviewDto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM "
				   + " (SELECT ROWNUM RN, A.* FROM " 
				   + " (SELECT R.*, "
				   + " (SELECT COUNT(*) FROM R_COMMENT WHERE R.RNUM=R_COMMENT.RNUM) COMMENTCNT, " 
				   + " (SELECT COUNT(*) FROM R_LIKE WHERE R.RNUM=R_LIKE.RNUM) LIKECNT, MNAME "
				   + " FROM REVIEW R, MEMBER M WHERE R.MID = M.MID AND RDELETE = 1 "
				   + " ORDER BY RNUM DESC)A) "
				   + " WHERE RN BETWEEN 1 AND 8";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs    = pstmt.executeQuery();
			while(rs.next()) {
				int    rNum        = rs.getInt("rNum");
				String mId         = rs.getString("mId");
				String rTitle      = rs.getString("rTitle");
				String rContent    = rs.getString("rContent");
				String rFileName_1 = rs.getString("rFileName_1");
				String rFileName_2 = rs.getString("rFileName_2");
				String rFileName_3 = rs.getString("rFileName_3");
				String rFileName_4 = rs.getString("rFileName_4");
				String rFileName_5 = rs.getString("rFileName_5");
				Date   rDate       = rs.getDate("rDate");
				int    rHit        = rs.getInt("rHit");
				String rIp         = rs.getString("rIp");
				int    rDelete     = rs.getInt("rDelete");
				int    commentCnt  = rs.getInt("commentCnt");
				int    likeCnt     = rs.getInt("likeCnt");
				String mName       = rs.getString("mName");
				reviewList.add(new ReviewDto(rNum, mId, rTitle, rContent, rFileName_1,
						rFileName_2, rFileName_3, rFileName_4, rFileName_5, rDate, rHit,
						rIp, rDelete, commentCnt, likeCnt, mName));
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
		return reviewList;
	}
}
