package com.phone_rev.dto;

import java.sql.Date;

public class ReviewDto {
	private int    rNum;
	private String mId;
	private String rTitle;
	private String rContent;
	private String rFileName_1;
	private String rFileName_2;
	private String rFileName_3;
	private String rFileName_4;
	private String rFileName_5;
	private Date   rDate;
	private int    rHit;
	private String rIp;
	private int    rDelete;
	private int    commentCnt;
	private int    likeCnt;
	private String mName;
	
	public ReviewDto() {
	}

	public ReviewDto(int rNum, String mId, String rTitle, String rContent, String rFileName_1, String rFileName_2,
			String rFileName_3, String rFileName_4, String rFileName_5, Date rDate, int rHit, String rIp, int rDelete,
			int commentCnt, int likeCnt, String mName) {
		super();
		this.rNum = rNum;
		this.mId = mId;
		this.rTitle = rTitle;
		this.rContent = rContent;
		this.rFileName_1 = rFileName_1;
		this.rFileName_2 = rFileName_2;
		this.rFileName_3 = rFileName_3;
		this.rFileName_4 = rFileName_4;
		this.rFileName_5 = rFileName_5;
		this.rDate = rDate;
		this.rHit = rHit;
		this.rIp = rIp;
		this.rDelete = rDelete;
		this.commentCnt = commentCnt;
		this.likeCnt = likeCnt;
		this.mName = mName;
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

	public String getrTitle() {
		return rTitle;
	}

	public void setrTitle(String rTitle) {
		this.rTitle = rTitle;
	}

	public String getrContent() {
		return rContent;
	}

	public void setrContent(String rContent) {
		this.rContent = rContent;
	}

	public String getrFileName_1() {
		return rFileName_1;
	}

	public void setrFileName_1(String rFileName_1) {
		this.rFileName_1 = rFileName_1;
	}

	public String getrFileName_2() {
		return rFileName_2;
	}

	public void setrFileName_2(String rFileName_2) {
		this.rFileName_2 = rFileName_2;
	}

	public String getrFileName_3() {
		return rFileName_3;
	}

	public void setrFileName_3(String rFileName_3) {
		this.rFileName_3 = rFileName_3;
	}

	public String getrFileName_4() {
		return rFileName_4;
	}

	public void setrFileName_4(String rFileName_4) {
		this.rFileName_4 = rFileName_4;
	}

	public String getrFileName_5() {
		return rFileName_5;
	}

	public void setrFileName_5(String rFileName_5) {
		this.rFileName_5 = rFileName_5;
	}

	public Date getrDate() {
		return rDate;
	}

	public void setrDate(Date rDate) {
		this.rDate = rDate;
	}

	public int getrHit() {
		return rHit;
	}

	public void setrHit(int rHit) {
		this.rHit = rHit;
	}

	public String getrIp() {
		return rIp;
	}

	public void setrIp(String rIp) {
		this.rIp = rIp;
	}

	public int getrDelete() {
		return rDelete;
	}

	public void setrDelete(int rDelete) {
		this.rDelete = rDelete;
	}

	public int getCommentCnt() {
		return commentCnt;
	}

	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}

	public int getLikeCnt() {
		return likeCnt;
	}

	public void setLikeCnt(int likeCnt) {
		this.likeCnt = likeCnt;
	}

	public String getmName() {
		return mName;
	}

	public void setmName(String mName) {
		this.mName = mName;
	}

	@Override
	public String toString() {
		return "ReviewDto [rNum=" + rNum + ", mId=" + mId + ", rTitle=" + rTitle + ", rContent=" + rContent
				+ ", rFileName_1=" + rFileName_1 + ", rFileName_2=" + rFileName_2 + ", rFileName_3=" + rFileName_3
				+ ", rFileName_4=" + rFileName_4 + ", rFileName_5=" + rFileName_5 + ", rDate=" + rDate + ", rHit="
				+ rHit + ", rIp=" + rIp + ", rDelete=" + rDelete + ", commentCnt=" + commentCnt + ", likeCnt=" + likeCnt
				+ ", mName=" + mName + "]";
	}
}
