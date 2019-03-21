package com.phone_rev.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.dao.QnADao;
import com.phone_rev.dao.ReviewDao;
import com.phone_rev.dto.QnADto;
import com.phone_rev.dto.ReviewDto;

public class MyContentService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		ReviewDao reviewDao = ReviewDao.getInstance();
		QnADao qnaDao = QnADao.getInstance();
		
		
		String mId = request.getParameter("mId");
		String rpageNum = request.getParameter("rpageNum");
		String qpageNum = request.getParameter("qpageNum");
		
		if(rpageNum==null) {
			rpageNum = "1";
		}
		if(qpageNum==null) {
			qpageNum = "1";
		}
		
		int rtotCnt = 0;
		int rpageCnt = 0;
		int rstartPage = 0;
		int rendPage = 0;
		int rcurrentPage = Integer.parseInt(rpageNum);
		final int rPAGESIZE = 10;
		final int rBLOCKSIZE = 10;
		int rstartRow = (rcurrentPage - 1) * rPAGESIZE + 1;
		int rendRow = rstartRow + rPAGESIZE - 1;
		
		int qtotCnt = 0;
		int qpageCnt = 0;
		int qstartPage = 0;
		int qendPage = 0;
		int qcurrentPage = Integer.parseInt(qpageNum);
		final int qPAGESIZE = 10;
		final int qBLOCKSIZE = 10;
		int qstartRow = (qcurrentPage - 1) * qPAGESIZE + 1;
		int qendRow = qstartRow + qPAGESIZE - 1;
		
		ArrayList<ReviewDto> reviewList = reviewDao.myReview(mId, rstartRow, rendRow);
		ArrayList<QnADto> qnaList = qnaDao.myQnA(mId, qstartRow, qendRow);
		
		request.setAttribute("reviewList", reviewList);
		request.setAttribute("qnaList", qnaList);
		
		rtotCnt = reviewDao.myReviewCnt(mId);
		qtotCnt = qnaDao.myQnACnt(mId);
		
		rpageCnt = (int)Math.ceil((double)rtotCnt/rPAGESIZE); // 페이지갯수
		rstartPage = ((rcurrentPage - 1) / rBLOCKSIZE) * rBLOCKSIZE + 1;
		rendPage = rstartPage + rBLOCKSIZE - 1;
		if(rendPage > rpageCnt) {
			rendPage = rpageCnt;
		}
		
		qpageCnt = (int)Math.ceil((double)qtotCnt/qPAGESIZE); // 페이지갯수
		qstartPage = ((qcurrentPage - 1) / qBLOCKSIZE) * qBLOCKSIZE + 1;
		qendPage = qstartPage + qBLOCKSIZE - 1;
		if(qendPage > qpageCnt) {
			qendPage = qpageCnt;
		}
		
		request.setAttribute("rBLOCKSIZE", rBLOCKSIZE);
		request.setAttribute("rstartPage", rstartPage);
		request.setAttribute("rendPage", rendPage);
		request.setAttribute("rpageCnt", rpageCnt);
		request.setAttribute("rtotCnt", rtotCnt);
		request.setAttribute("rpageNum", rpageNum);
		
		request.setAttribute("qBLOCKSIZE", qBLOCKSIZE);
		request.setAttribute("qstartPage", qstartPage);
		request.setAttribute("qendPage", qendPage);
		request.setAttribute("qpageCnt", qpageCnt);
		request.setAttribute("qtotCnt", qtotCnt);
		request.setAttribute("qpageNum", qpageNum);
	}
}
