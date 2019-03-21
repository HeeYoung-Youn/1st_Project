package com.phone_rev.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.dao.R_commentDao;
import com.phone_rev.dao.ReviewDao;
import com.phone_rev.dto.R_commentDto;
import com.phone_rev.dto.ReviewDto;

public class RContentReview implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		ReviewDao reviewDao = ReviewDao.getInstance();
		R_commentDao commentDao = R_commentDao.getInstance();
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null) {
			pageNum = "1";
		}
		int totCnt = 0;
		int pageCnt = 0;
		int currentPage = Integer.parseInt(pageNum);
		int rNum = Integer.parseInt(request.getParameter("rNum"));
		final int PAGESIZE = 20;
		int startRow = (currentPage - 1) * PAGESIZE + 1;
		int endRow = startRow + PAGESIZE - 1;
		ArrayList<R_commentDto> commentList = commentDao.reviewCommentList(rNum, startRow, endRow);
		ReviewDto reviewDto = reviewDao.contentView(rNum);
		request.setAttribute("commentList", commentList);
		request.setAttribute("reviewDto", reviewDto);
		totCnt = commentDao.reviewCommentListCnt(rNum);
		pageCnt = (int)Math.ceil((double)totCnt/PAGESIZE);
		request.setAttribute("pageCnt", pageCnt);
		request.setAttribute("totCnt", totCnt);
		request.setAttribute("pageNum", pageNum);
	}
}
