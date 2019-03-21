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

import com.phone_rev.dto.QnADto;

public class QnADao {
	public static final int FAIL = 0;
	public static final int SUCCESS = 1;
	
	private static QnADao instance = new QnADao();
	public static QnADao getInstance() {
		return instance;
	}
	private QnADao() {
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
	public ArrayList<QnADto> listExcept(int startRow, int endRow){
		ArrayList<QnADto> dtos = new ArrayList<QnADto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM  "
				   + " (SELECT ROWNUM RN, A.* FROM " 
				   + " (SELECT Q.*, M.MNAME FROM QnA Q, MEMBER M  " 
				   + " WHERE Q.MID=M.MID AND QDELETE = 1 ORDER BY QNUM DESC)A) " 
				   + " WHERE RN BETWEEN ? AND ?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs    = pstmt.executeQuery();
			while(rs.next()) {
				int    qNum     = rs.getInt("qNum");
				String mId      = rs.getString("mId");
				String qTitle   = rs.getString("qTitle");
				String qContent = rs.getString("qContent");
				Date   qDate    = rs.getDate("qDate");
				int    qHit     = rs.getInt("qHit");
				int    qGroup   = rs.getInt("qGroup");
				int    qStep    = rs.getInt("qStep");
				int    qIndent  = rs.getInt("qIndent");
				String qIp      = rs.getString("qIp");
				int    qDelete  = rs.getInt("qDelete");
				String mName    = rs.getString("mName");
				dtos.add(new QnADto(qNum, mId, qTitle, qContent, 
						qDate, qHit, qGroup, qStep, qIndent, qIp, qDelete, mName));
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
	public ArrayList<QnADto> list(int startRow, int endRow){
		ArrayList<QnADto> dtos = new ArrayList<QnADto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM  "
				   + " (SELECT ROWNUM RN, A.* FROM " 
				   + " (SELECT Q.*, M.MNAME FROM QnA Q, MEMBER M  " 
				   + " WHERE Q.MID=M.MID ORDER BY QNUM DESC)A) " 
				   + " WHERE RN BETWEEN ? AND ?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs    = pstmt.executeQuery();
			while(rs.next()) {
				int    qNum     = rs.getInt("qNum");
				String mId      = rs.getString("mId");
				String qTitle   = rs.getString("qTitle");
				String qContent = rs.getString("qContent");
				Date   qDate    = rs.getDate("qDate");
				int    qHit     = rs.getInt("qHit");
				int    qGroup   = rs.getInt("qGroup");
				int    qStep    = rs.getInt("qStep");
				int    qIndent  = rs.getInt("qIndent");
				String qIp      = rs.getString("qIp");
				int    qDelete  = rs.getInt("qDelete");
				String mName    = rs.getString("mName");
				dtos.add(new QnADto(qNum, mId, qTitle, qContent, qDate, 
						qHit, qGroup, qStep, qIndent, qIp, qDelete, mName));
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
	
	// QnA 총 갯수(삭제 제외)
	public int getQnATotCntExcept() {
		int cnt = 0;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT COUNT(*) FROM QnA WHERE QDELETE = 1";
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
	
	// QnA 총 갯수(삭제 포함)
	public int getQnATotCnt() {
		int cnt = 0;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT COUNT(*) FROM QnA";
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
	
	// QnA 검색(삭제 제외)
	public ArrayList<QnADto> searchQnAExcept(String searchqTitle, int startRow, int endRow){
		ArrayList<QnADto> dtos = new ArrayList<QnADto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM  " 
				   + " (SELECT ROWNUM RN, A.* FROM " 
				   + " (SELECT Q.*, M.MNAME FROM QnA Q, MEMBER M  " 
				   + " WHERE Q.MID=M.MID AND QDELETE = 1  "
				   + " AND QTITLE LIKE '%' || ? || '%' ORDER BY QGROUP DESC, QSTEP)A) " 
				   + " WHERE RN BETWEEN ? AND ?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchqTitle);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs    = pstmt.executeQuery();
			while(rs.next()) {
				int    qNum     = rs.getInt("qNum");
				String mId      = rs.getString("mId");
				String qTitle   = rs.getString("qTitle");
				String qContent = rs.getString("qContent");
				Date   qDate    = rs.getDate("qDate");
				int    qHit     = rs.getInt("qHit");
				int    qGroup   = rs.getInt("qGroup");
				int    qStep    = rs.getInt("qStep");
				int    qIndent  = rs.getInt("qIndent");
				String qIp      = rs.getString("qIp");
				int    qDelete  = rs.getInt("qDelete");
				String mName    = rs.getString("mName");
				dtos.add(new QnADto(qNum, mId, qTitle, qContent, 
						qDate, qHit, qGroup, qStep, qIndent, qIp, qDelete, mName));
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
	
	// QnA 검색(삭제 포함)
	public ArrayList<QnADto> searchQnA(String searchqTitle, int startRow, int endRow){
		ArrayList<QnADto> dtos = new ArrayList<QnADto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM "
				   + " (SELECT ROWNUM RN, A.*, MNAME FROM " 
				   + " (SELECT * FROM QnA WHERE QTITLE LIKE '%' || ? || '%'  " 
				   + " ORDER BY QGROUP DESC, QSTEP)A, MEMBER M "
				   + " WHERE A.MID = M.MID) "
				   + " WHERE RN BETWEEN ? AND ?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchqTitle);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs    = pstmt.executeQuery();
			while(rs.next()) {
				int    qNum     = rs.getInt("qNum");
				String mId      = rs.getString("mId");
				String qTitle   = rs.getString("qTitle");
				String qContent = rs.getString("qContent");
				Date   qDate    = rs.getDate("qDate");
				int    qHit     = rs.getInt("qHit");
				int    qGroup   = rs.getInt("qGroup");
				int    qStep    = rs.getInt("qStep");
				int    qIndent  = rs.getInt("qIndent");
				String qIp      = rs.getString("qIp");
				int    qDelete  = rs.getInt("qDelete");
				String mName    = rs.getString("mName");
				dtos.add(new QnADto(qNum, mId, qTitle, qContent, 
						qDate, qHit, qGroup, qStep, qIndent, qIp, qDelete, mName));
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
	
	// 검색된 QnA 총 갯수(삭제 제외)
	public int searchQnACntExcept(String searchqTitle) {
		int totCnt = 0;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT COUNT(*) FROM QnA WHERE QDELETE = 1 AND QTITLE LIKE '%' || ? || '%'";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchqTitle);
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
	
	// 검색된 QnA 총 갯수(삭제 포함)
	public int searchQnACnt(String searchqTitle) {
		int totCnt = 0;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT COUNT(*) FROM QnA WHERE QTITLE LIKE '%' || ? || '%'";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchqTitle);
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
	
	// 내가 쓴 QnA
	public ArrayList<QnADto> myQnA(String mId, int startRow, int endRow){
		ArrayList<QnADto> dtos = new ArrayList<QnADto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM  "
				   + " (SELECT ROWNUM RN, A.* FROM " 
				   + " (SELECT Q.*, M.MNAME FROM QnA Q, MEMBER M  " 
				   + " WHERE Q.MID=M.MID AND Q.MID=? AND QDELETE = 1 " 
				   + " ORDER BY QGROUP DESC, QSTEP)A) "
				   + " WHERE RN BETWEEN ? AND ?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mId);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int    qNum     = rs.getInt("qNum");
				String qTitle   = rs.getString("qTitle");
				String qContent = rs.getString("qContent");
				Date   qDate    = rs.getDate("qDate");
				int    qHit     = rs.getInt("qHit");
				int    qGroup   = rs.getInt("qGroup");
				int    qStep    = rs.getInt("qStep");
				int    qIndent  = rs.getInt("qIndent");
				String qIp      = rs.getString("qIp");
				int    qDelete  = rs.getInt("qDelete");
				String mName    = rs.getString("mName");
				dtos.add(new QnADto(qNum, mId, qTitle, qContent, qDate, 
						qHit, qGroup, qStep, qIndent, qIp, qDelete, mName));
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
	
	// 내가 쓴 QnA 총 갯수
	public int myQnACnt(String mId) {
		int totCnt = 0;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT COUNT(*) FROM QnA WHERE MID=? AND QDELETE = 1";
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
	private void hitUp(int qNum) {
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE QnA SET QHIT = QHIT + 1 WHERE QNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qNum);
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
	
	// 글 상세보기(qNum으로 DTO가져오기)
	public QnADto contentView(int qNum) {
		hitUp(qNum);
		QnADto dto = null;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT Q.*, MNAME FROM QnA Q, MEMBER M  "
				   + " WHERE Q.MID = M.MID AND QNUM = ?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qNum);
			rs    = pstmt.executeQuery();
			while(rs.next()) {
				String mId      = rs.getString("mId");
				String qTitle   = rs.getString("qTitle");
				String qContent = rs.getString("qContent");
				Date   qDate    = rs.getDate("qDate");
				int    qHit     = rs.getInt("qHit");
				int    qGroup   = rs.getInt("qGroup");
				int    qStep    = rs.getInt("qStep");
				int    qIndent  = rs.getInt("qIndent");
				String qIp      = rs.getString("qIp");
				int    qDelete  = rs.getInt("qDelete");
				String mName    = rs.getString("mName");
				dto = new QnADto(qNum, mId, qTitle, qContent, qDate, 
						qHit, qGroup, qStep, qIndent, qIp, qDelete, mName);
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
	
	// 원글 작성
	public int writeQnA(String mId, String qTitle, String qContent, String qIp) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO QnA (qNum, mId, qTitle, qContent,  "
				   + " qGroup, qStep, qIndent, qIp) "
				   + " VALUES (QnA_SEQ.NEXTVAL, ?, ?, ?,  " 
				   + " QnA_SEQ.CURRVAL, 0, 0, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mId);
			pstmt.setString(2, qTitle);
			pstmt.setString(3, qContent);
			pstmt.setString(4, qIp);
			result = pstmt.executeUpdate();
			System.out.println(result==SUCCESS? "QnA 원글 쓰기 성공" : "QnA 원글 쓰기 실패");
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
	
	// 수정 view (qNum으로 DTO가져오기)
	public QnADto modifyQnAView_replyQnAView(int qNum) {
		QnADto dto = null;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT Q.*, MNAME FROM QnA Q, MEMBER M WHERE Q.MID = M.MID AND QNUM = ?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qNum);
			rs    = pstmt.executeQuery();
			while(rs.next()) {
				String mId      = rs.getString("mId");
				String qTitle   = rs.getString("qTitle");
				String qContent = rs.getString("qContent");
				Date   qDate    = rs.getDate("qDate");
				int    qHit     = rs.getInt("qHit");
				int    qGroup   = rs.getInt("qGroup");
				int    qStep    = rs.getInt("qStep");
				int    qIndent  = rs.getInt("qIndent");
				String qIp      = rs.getString("qIp");
				int    qDelete  = rs.getInt("qDelete");
				String mName    = rs.getString("mName");
				dto = new QnADto(qNum, mId, qTitle, qContent, qDate, 
						qHit, qGroup, qStep, qIndent, qIp, qDelete, mName);
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
	public int modifyQnA(String qTitle, String qContent, String qIp, int qNum) { 
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE QnA SET QTITLE   = ?,  "
					    + "          QCONTENT = ?,  "
					    + "          QDATE    = SYSDATE,  " 
					    + "          QIP      = ? "
					    + "    WHERE QNUM     = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, qTitle);
			pstmt.setString(2, qContent);
			pstmt.setString(3, qIp);
			pstmt.setInt(4, qNum);
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
	
	// 답글 처리를 위한 step A
	private void preQnAReplyStepA(int qGroup, int qStep) {
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE QnA SET QSTEP = QSTEP + 1 "
				   + " WHERE QGROUP = ? AND QSTEP > ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qGroup);
			pstmt.setInt(2, qStep);
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
	
	// 답글쓰기
	public int reply(String mId, String qTitle, String qContent, 
			int qGroup, int qStep, int qIndent, String qIp) {
		preQnAReplyStepA(qGroup, qStep);
		// qgroup, qstep, qindent 원글의 정보
		// qname, qtitle, qcontent, qip 답변글의 정보
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO QnA (qNum, mId, qTitle, qContent,  "
				   + " qGroup, qStep, qIndent, qIp) "
				   + " VALUES (QnA_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mId);
			pstmt.setString(2, qTitle);
			pstmt.setString(3, qContent);
			pstmt.setInt(4, qGroup);
			pstmt.setInt(5, qStep+1);
			pstmt.setInt(6, qIndent+1);
			pstmt.setString(7, qIp);
			result = pstmt.executeUpdate();
			System.out.println(result==SUCCESS ? "답변쓰기 성공" : "답변쓰기 실패");
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
	public int deleteQnA(int qNum) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE QnA SET QDELETE = 0 WHERE QNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qNum);
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
	public int recoverQnA(int qNum) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE QnA SET QDELETE = 1 WHERE QNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qNum);
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
