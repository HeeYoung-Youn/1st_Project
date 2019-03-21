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

import com.phone_rev.dto.N_commentDto;

public class N_commentDao {
	public static final int FAIL = 0;
	public static final int SUCCESS = 1;
	
	private static N_commentDao instance = new N_commentDao();
	public static N_commentDao getInstance() {
		return instance;
	}
	private N_commentDao() {
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
	
	// nNum번 글의 전체 댓글 목록
	public ArrayList<N_commentDto> noticeCommentList(int nNum, int startRow, int endRow){
		ArrayList<N_commentDto> dtos = new ArrayList<N_commentDto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM  "
				   + " (SELECT ROWNUM RN, A.NCNUM, A.NNUM, A.MID, A.NCCONTENT, A.NCDATE, A.NCGROUP,  " 
				   + " A.NCSTEP, A.NCINDENT, A.NCIP, A.MNAME FROM "
				   + " (SELECT C.*, MNAME "
				   + " FROM MEMBER M, N_COMMENT C " 
				   + " WHERE M.MID=C.MID AND NNUM = ? ORDER BY NCGROUP DESC, NCSTEP) A) " 
				   + " WHERE RN BETWEEN ? AND ?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, nNum);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs    = pstmt.executeQuery();
			while(rs.next()) {
				int    ncNum = rs.getInt("ncNum");
				String mId = rs.getString("mId");
				String ncContent = rs.getString("ncContent");
				Date   ncDate = rs.getDate("ncDate");
				int    ncGroup = rs.getInt("ncGroup");
				int    ncStep = rs.getInt("ncStep");
				int    ncIndent = rs.getInt("ncIndent");
				String ncIp = rs.getString("ncIp");
				String mName = rs.getString("mName");
				dtos.add(new N_commentDto(ncNum, nNum, mId, ncContent, ncDate,
						ncGroup, ncStep, ncIndent, ncIp, mName));
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
	
	// nNum번 글의 댓글 총 갯수
	public int noticeCommentListCnt(int nNum) {
		int totCnt = 0;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT COUNT(*) FROM N_COMMENT WHERE NNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, nNum);
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
	
	// 내가 쓴 Notice댓글
	public ArrayList<N_commentDto> myNoticeComment(String mId, int startRow, int endRow){
		ArrayList<N_commentDto> dtos = new ArrayList<N_commentDto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM "
				   + " (SELECT ROWNUM RN, A.* FROM " 
				   + " (SELECT N.*, MNAME FROM N_COMMENT N, MEMBER M  " 
				   + " WHERE N.MID=M.MID AND N.MID = ?  " 
				   + " ORDER BY NNUM DESC, NCGROUP DESC, NCSTEP)A) " 
				   + " WHERE RN BETWEEN ? AND ?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mId);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs    = pstmt.executeQuery();
			while(rs.next()) {
				int    ncNum = rs.getInt("ncNum");
				int    nNum = rs.getInt("nNum");
				String ncContent = rs.getString("ncContent");
				Date   ncDate = rs.getDate("ncDate");
				int    ncGroup = rs.getInt("ncGroup");
				int    ncStep = rs.getInt("ncStep");
				int    ncIndent = rs.getInt("ncIndent");
				String ncIp = rs.getString("ncIp");
				String mName = rs.getString("mName");
				dtos.add(new N_commentDto(ncNum, nNum, mId, ncContent, ncDate,
						ncGroup, ncStep, ncIndent, ncIp, mName));
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
	
	// 내가 쓴 Notice 댓글 총 갯수
	public int myNoticeCommentCnt(String mId) {
		int totCnt = 0;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT COUNT(*) FROM N_COMMENT WHERE MID=?";
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
	public int writeNoticeComment(int nNum, String mId, String ncContent, String ncIp) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;	
		String sql = "INSERT INTO N_COMMENT (ncNum, nNum, mId, ncContent,  "
				   + " ncGroup, ncStep, ncIndent, ncIp) "
				   + " VALUES (N_COMMENT_SEQ.NEXTVAL, ?, ?, ?,  " 
				   + " N_COMMENT_SEQ.CURRVAL, 0, 0, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, nNum);
			pstmt.setString(2, mId);
			pstmt.setString(3, ncContent);
			pstmt.setString(4, ncIp);
			result = pstmt.executeUpdate();
			System.out.println(result==SUCCESS? "Notice 댓글 원글 쓰기 성공" : "Notice 댓글 원글 쓰기 실패");
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
	private void preNoticeCommentReplyStepA(int ncGroup, int ncStep) {
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE N_COMMENT SET NCSTEP = NCSTEP + 1 " 
				   + " WHERE NCGROUP = ? AND NCSTEP > ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ncGroup);
			pstmt.setInt(2, ncStep);
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
	
	// Notice댓글의 답글쓰기
	public int replyNoticeComment(int nNum, String mId, String ncContent, 
			int ncGroup, int ncStep, int ncIndent, String ncIp) {
		preNoticeCommentReplyStepA(ncGroup, ncStep);
		// qgroup, qstep, qindent 원글의 정보
		// qname, qtitle, qcontent, qip 답변글의 정보
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO N_COMMENT (ncNum, nNum, mId, ncContent,  "
				   + " ncGroup, ncStep, ncIndent, ncIp) "
				   + " VALUES (N_COMMENT_SEQ.NEXTVAL, ?, ?, ?,  " 
				   + " ?, ?, ?, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, nNum);
			pstmt.setString(2, mId);
			pstmt.setString(3, ncContent);
			pstmt.setInt(4, ncGroup);
			pstmt.setInt(5, ncStep+1);
			pstmt.setInt(6, ncIndent+1);
			pstmt.setString(7, ncIp);
			result = pstmt.executeUpdate();
			System.out.println(result==SUCCESS ? "Notice 댓글의 답변쓰기 성공" : "Notice 댓글의 답변쓰기 실패");
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
