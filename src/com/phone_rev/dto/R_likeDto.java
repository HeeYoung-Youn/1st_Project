package com.phone_rev.dto;

public class R_likeDto {
	private int    lNum;
	private int    rNum;
	private String mId;
	
	public R_likeDto() {
	}

	public R_likeDto(int lNum, int rNum, String mId) {
		super();
		this.lNum = lNum;
		this.rNum = rNum;
		this.mId = mId;
	}

	public int getlNum() {
		return lNum;
	}

	public void setlNum(int lNum) {
		this.lNum = lNum;
	}

	public int getrNum() {
		return rNum;
	}

	public void setrNum(int rNum) {
		this.rNum = rNum;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	@Override
	public String toString() {
		return "R_likeDto [lNum=" + lNum + ", rNum=" + rNum + ", mId=" + mId + "]";
	}
}
