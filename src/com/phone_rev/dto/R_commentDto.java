package com.phone_rev.dto;

import java.sql.Date;

public class R_commentDto {
	private int    cNum;
	private int    rNum;
	private String mId;
	private String cContent;
	private Date   cDate;
	private int    cGroup;
	private int    cStep;
	private int    cIndent;
	private String cIp;
	private String mName;
	
	public R_commentDto() {
	}

	public R_commentDto(int cNum, int rNum, String mId, String cContent, Date cDate, int cGroup, int cStep, int cIndent,
			String cIp, String mName) {
		super();
		this.cNum = cNum;
		this.rNum = rNum;
		this.mId = mId;
		this.cContent = cContent;
		this.cDate = cDate;
		this.cGroup = cGroup;
		this.cStep = cStep;
		this.cIndent = cIndent;
		this.cIp = cIp;
		this.mName = mName;
	}

	public int getcNum() {
		return cNum;
	}

	public void setcNum(int cNum) {
		this.cNum = cNum;
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

	public String getcContent() {
		return cContent;
	}

	public void setcContent(String cContent) {
		this.cContent = cContent;
	}

	public Date getcDate() {
		return cDate;
	}

	public void setcDate(Date cDate) {
		this.cDate = cDate;
	}

	public int getcGroup() {
		return cGroup;
	}

	public void setcGroup(int cGroup) {
		this.cGroup = cGroup;
	}

	public int getcStep() {
		return cStep;
	}

	public void setcStep(int cStep) {
		this.cStep = cStep;
	}

	public int getcIndent() {
		return cIndent;
	}

	public void setcIndent(int cIndent) {
		this.cIndent = cIndent;
	}

	public String getcIp() {
		return cIp;
	}

	public void setcIp(String cIp) {
		this.cIp = cIp;
	}

	public String getmName() {
		return mName;
	}

	public void setmName(String mName) {
		this.mName = mName;
	}

	@Override
	public String toString() {
		return "R_commentDto [cNum=" + cNum + ", rNum=" + rNum + ", mId=" + mId + ", cContent=" + cContent + ", cDate="
				+ cDate + ", cGroup=" + cGroup + ", cStep=" + cStep + ", cIndent=" + cIndent + ", cIp=" + cIp
				+ ", mName=" + mName + "]\r\n";
	}
}
