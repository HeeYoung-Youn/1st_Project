package com.phone_rev.dto;

import java.sql.Date;

public class N_commentDto {
	private int    ncNum;
	private int    nNum;
	private String mId;
	private String ncContent;
	private Date   ncDate;
	private int    ncGroup;
	private int    ncStep;
	private int    ncIndent;
	private String ncIp;
	private String mName;
	
	public N_commentDto() {
	}

	public N_commentDto(int ncNum, int nNum, String mId, String ncContent, Date ncDate, int ncGroup, int ncStep,
			int ncIndent, String ncIp, String mName) {
		super();
		this.ncNum = ncNum;
		this.nNum = nNum;
		this.mId = mId;
		this.ncContent = ncContent;
		this.ncDate = ncDate;
		this.ncGroup = ncGroup;
		this.ncStep = ncStep;
		this.ncIndent = ncIndent;
		this.ncIp = ncIp;
		this.mName = mName;
	}

	public int getNcNum() {
		return ncNum;
	}

	public void setNcNum(int ncNum) {
		this.ncNum = ncNum;
	}

	public int getnNum() {
		return nNum;
	}

	public void setnNum(int nNum) {
		this.nNum = nNum;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public String getNcContent() {
		return ncContent;
	}

	public void setNcContent(String ncContent) {
		this.ncContent = ncContent;
	}

	public Date getNcDate() {
		return ncDate;
	}

	public void setNcDate(Date ncDate) {
		this.ncDate = ncDate;
	}

	public int getNcGroup() {
		return ncGroup;
	}

	public void setNcGroup(int ncGroup) {
		this.ncGroup = ncGroup;
	}

	public int getNcStep() {
		return ncStep;
	}

	public void setNcStep(int ncStep) {
		this.ncStep = ncStep;
	}

	public int getNcIndent() {
		return ncIndent;
	}

	public void setNcIndent(int ncIndent) {
		this.ncIndent = ncIndent;
	}

	public String getNcIp() {
		return ncIp;
	}

	public void setNcIp(String ncIp) {
		this.ncIp = ncIp;
	}

	public String getmName() {
		return mName;
	}

	public void setmName(String mName) {
		this.mName = mName;
	}

	@Override
	public String toString() {
		return "N_commentDto [ncNum=" + ncNum + ", nNum=" + nNum + ", mId=" + mId + ", ncContent=" + ncContent
				+ ", ncDate=" + ncDate + ", ncGroup=" + ncGroup + ", ncStep=" + ncStep + ", ncIndent=" + ncIndent
				+ ", ncIp=" + ncIp + ", mName=" + mName + "]";
	}
}
