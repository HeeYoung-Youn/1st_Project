package com.phone_rev.dto;

import java.sql.Date;

public class NoticeDto {
	private int    nNum;
	private String aId;
	private String nTitle;
	private String nContent;
	private Date   nDate;
	private int    nHit;
	private String nIp;
	private int    nDelete;
	private int    commentCnt;
	private String aName;
	
	public NoticeDto() {
	}

	public NoticeDto(int nNum, String aId, String nTitle, String nContent, Date nDate, int nHit, String nIp,
			int nDelete, int commentCnt, String aName) {
		super();
		this.nNum = nNum;
		this.aId = aId;
		this.nTitle = nTitle;
		this.nContent = nContent;
		this.nDate = nDate;
		this.nHit = nHit;
		this.nIp = nIp;
		this.nDelete = nDelete;
		this.commentCnt = commentCnt;
		this.aName = aName;
	}

	public int getnNum() {
		return nNum;
	}

	public void setnNum(int nNum) {
		this.nNum = nNum;
	}

	public String getaId() {
		return aId;
	}

	public void setaId(String aId) {
		this.aId = aId;
	}

	public String getnTitle() {
		return nTitle;
	}

	public void setnTitle(String nTitle) {
		this.nTitle = nTitle;
	}

	public String getnContent() {
		return nContent;
	}

	public void setnContent(String nContent) {
		this.nContent = nContent;
	}

	public Date getnDate() {
		return nDate;
	}

	public void setnDate(Date nDate) {
		this.nDate = nDate;
	}

	public int getnHit() {
		return nHit;
	}

	public void setnHit(int nHit) {
		this.nHit = nHit;
	}

	public String getnIp() {
		return nIp;
	}

	public void setnIp(String nIp) {
		this.nIp = nIp;
	}

	public int getnDelete() {
		return nDelete;
	}

	public void setnDelete(int nDelete) {
		this.nDelete = nDelete;
	}

	public int getCommentCnt() {
		return commentCnt;
	}

	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}

	public String getaName() {
		return aName;
	}

	public void setaName(String aName) {
		this.aName = aName;
	}

	@Override
	public String toString() {
		return "NoticeDto [nNum=" + nNum + ", aId=" + aId + ", nTitle=" + nTitle + ", nContent=" + nContent + ", nDate="
				+ nDate + ", nHit=" + nHit + ", nIp=" + nIp + ", nDelete=" + nDelete + ", commentCnt=" + commentCnt
				+ ", aName=" + aName + "]";
	}
}
