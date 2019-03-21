package com.phone_rev.dto;

import java.sql.Date;

public class QnADto {
	private int    qNum;
	private String mId;
	private String qTitle;
	private String qContent;
	private Date   qDate;
	private int    qHit;
	private int    qGroup;
	private int    qStep;
	private int    qIndent;
	private String qIp;
	private int    qDelete;
	private String mName;
	
	public QnADto() {
	}

	public QnADto(int qNum, String mId, String qTitle, String qContent, Date qDate, int qHit, int qGroup, int qStep,
			int qIndent, String qIp, int qDelete, String mName) {
		super();
		this.qNum = qNum;
		this.mId = mId;
		this.qTitle = qTitle;
		this.qContent = qContent;
		this.qDate = qDate;
		this.qHit = qHit;
		this.qGroup = qGroup;
		this.qStep = qStep;
		this.qIndent = qIndent;
		this.qIp = qIp;
		this.qDelete = qDelete;
		this.mName = mName;
	}

	public int getqNum() {
		return qNum;
	}

	public void setqNum(int qNum) {
		this.qNum = qNum;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public String getqTitle() {
		return qTitle;
	}

	public void setqTitle(String qTitle) {
		this.qTitle = qTitle;
	}

	public String getqContent() {
		return qContent;
	}

	public void setqContent(String qContent) {
		this.qContent = qContent;
	}

	public Date getqDate() {
		return qDate;
	}

	public void setqDate(Date qDate) {
		this.qDate = qDate;
	}

	public int getqHit() {
		return qHit;
	}

	public void setqHit(int qHit) {
		this.qHit = qHit;
	}

	public int getqGroup() {
		return qGroup;
	}

	public void setqGroup(int qGroup) {
		this.qGroup = qGroup;
	}

	public int getqStep() {
		return qStep;
	}

	public void setqStep(int qStep) {
		this.qStep = qStep;
	}

	public int getqIndent() {
		return qIndent;
	}

	public void setqIndent(int qIndent) {
		this.qIndent = qIndent;
	}

	public String getqIp() {
		return qIp;
	}

	public void setqIp(String qIp) {
		this.qIp = qIp;
	}

	public int getqDelete() {
		return qDelete;
	}

	public void setqDelete(int qDelete) {
		this.qDelete = qDelete;
	}

	public String getmName() {
		return mName;
	}

	public void setmName(String mName) {
		this.mName = mName;
	}

	@Override
	public String toString() {
		return "QnADto [qNum=" + qNum + ", mId=" + mId + ", qTitle=" + qTitle + ", qContent=" + qContent + ", qDate="
				+ qDate + ", qHit=" + qHit + ", qGroup=" + qGroup + ", qStep=" + qStep + ", qIndent=" + qIndent
				+ ", qIp=" + qIp + ", qDelete=" + qDelete + ", mName=" + mName + "]";
	}
}
