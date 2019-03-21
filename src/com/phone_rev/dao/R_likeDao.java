package com.phone_rev.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class R_likeDao {
	public static final int FAIL = 0;
	public static final int SUCCESS = 1;
	public static final int UNPRESSED = 0;
	public static final int PRESSED = 1;
	
	private static R_likeDao instance = new R_likeDao();
	public static R_likeDao getInstance() {
		return instance;
	}
	private R_likeDao() {
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
	
	// mId로 rNum번의 글 추천 눌렀는지 확인
	public int likePressConfirm(int rNum, String mId) {
		int result = UNPRESSED;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM R_LIKE WHERE RNUM = ? AND MID = ?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rNum);
			pstmt.setString(2, mId);
			rs    = pstmt.executeQuery();
			if(rs.next()) {
				result = PRESSED;
			}else {
				result = UNPRESSED;
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
		return result;
	}
	
	// mId로 rNum번의 글 추천 누르기
	public int pressLike(int rNum, String mId) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO R_LIKE (lNum, rNum, mId) " 
				   + " VALUES(R_LIKE_SEQ.NEXTVAL, ?, ?)";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rNum);
			pstmt.setString(2, mId);
			result = pstmt.executeUpdate();
			System.out.println(result==SUCCESS? "좋아요 누르기 성공" : "좋아요 누르기 실패");
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
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
		return result;
	}
}