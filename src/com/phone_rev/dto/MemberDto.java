package com.phone_rev.dto;

import java.sql.Date;

public class MemberDto {
	private String mId;
	private int    mGrade;
	private String mPw;
	private String mName;
	private String mEmail;
	private Date   mBirth;
	private int    mJoin;
	
	public MemberDto() {
	}

	public MemberDto(String mId, int mGrade, String mPw, String mName, String mEmail, Date mBirth, int mJoin) {
		super();
		this.mId = mId;
		this.mGrade = mGrade;
		this.mPw = mPw;
		this.mName = mName;
		this.mEmail = mEmail;
		this.mBirth = mBirth;
		this.mJoin = mJoin;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public int getmGrade() {
		return mGrade;
	}

	public void setmGrade(int mGrade) {
		this.mGrade = mGrade;
	}

	public String getmPw() {
		return mPw;
	}

	public void setmPw(String mPw) {
		this.mPw = mPw;
	}

	public String getmName() {
		return mName;
	}

	public void setmName(String mName) {
		this.mName = mName;
	}

	public String getmEmail() {
		return mEmail;
	}

	public void setmEmail(String mEmail) {
		this.mEmail = mEmail;
	}

	public Date getmBirth() {
		return mBirth;
	}

	public void setmBirth(Date mBirth) {
		this.mBirth = mBirth;
	}

	public int getmJoin() {
		return mJoin;
	}

	public void setmJoin(int mJoin) {
		this.mJoin = mJoin;
	}

	@Override
	public String toString() {
		return "MemberDto [mId=" + mId + ", mGrade=" + mGrade + ", mPw=" + mPw + ", mName=" + mName + ", mEmail="
				+ mEmail + ", mBirth=" + mBirth + ", mJoin=" + mJoin + "]";
	}
}
