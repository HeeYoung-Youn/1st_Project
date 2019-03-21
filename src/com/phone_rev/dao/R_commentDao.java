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

import com.phone_rev.dto.R_commentDto;

public class R_commentDao {
	public static final int FAIL = 0;
	public static final int SUCCESS = 1;
	
	private static R_commentDao instance = new R_commentDao();
	public static R_commentDao getInstance() {
		return instance;
	}
	private R_commentDao() {
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
	
	// rNum번 글의 전체 댓글 목록
	public ArrayList<R_commentDto> reviewCommentList(int rNum, int startRow, int endRow){
		ArrayList<R_commentDto> dtos = new ArrayList<R_commentDto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM  "
				   + " (SELECT ROWNUM RN, A.CNUM, A.RNUM, A.MID, A.CCONTENT, A.CDATE, A.CGROUP,  " 
				   + " A.CSTEP, A.CINDENT, A.CIP, A.MNAME FROM "
				   + " (SELECT R.*, MNAME FROM R_COMMENT R, MEMBER M  " 
				   + " WHERE R.MID = M.MID AND  RNUM = ?  "
				   + " ORDER BY CGROUP DESC, CSTEP)A) "
				   + " WHERE RN BETWEEN ? AND ?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rNum);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs    = pstmt.executeQuery();
			while(rs.next()) {
				int    cNum = rs.getInt("cNum");
				String mId = rs.getString("mId");
				String cContent = rs.getString("cContent");
				Date   cDate = rs.getDate("cDate");
				int    cGroup = rs.getInt("cGroup");
				int    cStep = rs.getInt("cStep");
				int    cIndent = rs.getInt("cIndent");
				String cIp = rs.getString("cIp");
				String mName = rs.getString("mName");
				dtos.add(new R_commentDto(cNum, rNum, mId, cContent, cDate,
						cGroup, cStep, cIndent, cIp, mName));
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
	
	// rNum번 글의 댓글 총 갯수
	public int reviewCommentListCnt(int rNum) {
		int totCnt = 0;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT COUNT(*) FROM R_COMMENT WHERE RNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rNum);
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
	
	// 내가 쓴 Review댓글
	public ArrayList<R_commentDto> myReviewComment(String mId, int startRow, int endRow){
		ArrayList<R_commentDto> dtos = new ArrayList<R_commentDto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM "
				   + " (SELECT ROWNUM RN, A.* FROM "
				   + " (SELECT R.*, MNAME FROM R_COMMENT R, MEMBER M  " 
				   + " WHERE R.MID=M.MID AND R.MID = ?  "
				   + " ORDER BY RNUM DESC, CGROUP DESC, CSTEP)A) " 
				   + " WHERE RN BETWEEN ? AND ?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mId);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs    = pstmt.executeQuery();
			while(rs.next()) {
				int    cNum = rs.getInt("cNum");
				int    rNum = rs.getInt("rNum");
				String cContent = rs.getString("cContent");
				Date   cDate = rs.getDate("cDate");
				int    cGroup = rs.getInt("cGroup");
				int    cStep = rs.getInt("cStep");
				int    cIndent = rs.getInt("cIndent");
				String cIp = rs.getString("cIp");
				String mName = rs.getString("mName");
				dtos.add(new R_commentDto(cNum, rNum, mId, cContent, cDate,
						cGroup, cStep, cIndent, cIp, mName));
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
	
	// 내가 쓴 Review 댓글 총 갯수
	public int myReviewCommentCnt(String mId) {
		int totCnt = 0;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT COUNT(*) FROM R_COMMENT WHERE MID=?";
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
	
	// 원 댓글 작성
	public int writeReviewComment(int rNum, String mId, String cContent, String cIp) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO R_COMMENT (cNum, rNum, mId, cContent,  " 
				   + " cGroup, cStep, cIndent, cIp) "
				   + " VALUES (R_COMMENT_SEQ.NEXTVAL, ?, ?, ?,  " 
				   + " R_COMMENT_SEQ.CURRVAL, 0, 0, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rNum);
			pstmt.setString(2, mId);
			pstmt.setString(3, cContent);
			pstmt.setString(4, cIp);
			result = pstmt.executeUpdate();
			System.out.println(result==SUCCESS? "Review 댓글 원글 쓰기 성공" : "Review 댓글 원글 쓰기 실패");
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
	
	// Review 댓글의 답글 처리를 위한 step A
	private void preReviewCommentReplyStepA(int cGroup, int cStep) {
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE R_COMMENT SET CSTEP = CSTEP + 1 "
				   + " WHERE CGROUP = ? AND CSTEP > ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cGroup);
			pstmt.setInt(2, cStep);
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
	
	// Review댓글의 답글쓰기
	public int replyReviewComment(int rNum, String mId, String cContent, 
			int cGroup, int cStep, int cIndent, String cIp) {
		preReviewCommentReplyStepA(cGroup, cStep);
		// qgroup, qstep, qindent 원글의 정보
		// qname, qtitle, qcontent, qip 답변글의 정보
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO R_COMMENT (cNum, rNum, mId, cContent,  " 
				   + " cGroup, cStep, cIndent, cIp) "
				   + " VALUES (R_COMMENT_SEQ.NEXTVAL, ?, ?, ?,  " 
				   + " ?, ?, ?, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rNum);
			pstmt.setString(2, mId);
			pstmt.setString(3, cContent);
			pstmt.setInt(4, cGroup);
			pstmt.setInt(5, cStep+1);
			pstmt.setInt(6, cIndent+1);
			pstmt.setString(7, cIp);
			result = pstmt.executeUpdate();
			System.out.println(result==SUCCESS ? "Review 댓글의 답변쓰기 성공" : "Review 댓글의 답변쓰기 실패");
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
