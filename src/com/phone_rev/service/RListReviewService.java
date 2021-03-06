package com.phone_rev.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.phone_rev.dao.ReviewDao;
import com.phone_rev.dto.ReviewDto;

public class RListReviewService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		ReviewDao reviewDao = ReviewDao.getInstance();
		String pageNum = request.getParameter("pageNum");
		String searchrTitle = request.getParameter("searchrTitle");
		if(pageNum==null) {
			pageNum = "1";
		}
		if(searchrTitle==null) {
			searchrTitle = "";
		}
		int totCnt = 0;
		int pageCnt = 0;
		int startPage = 0;
		int endPage = 0;
		int currentPage = Integer.parseInt(pageNum);
		final int PAGESIZE = 10;
		final int BLOCKSIZE = 10;
		int startRow = (currentPage - 1) * PAGESIZE + 1;
		int endRow = startRow + PAGESIZE - 1;
		if(session.getAttribute("admin")==null) { // 로그인 전 or 일반사용자 로그인 삭제 제외하고 뿌리기
			ArrayList<ReviewDto> reviewList = reviewDao.searchReviewExcept(searchrTitle, startRow, endRow);
			request.setAttribute("reviewList", reviewList);
			totCnt = reviewDao.searchReviewCntExcept(searchrTitle);
			pageCnt = (int)Math.ceil((double)totCnt/PAGESIZE); // 페이지갯수
			startPage = ((currentPage - 1) / BLOCKSIZE) * BLOCKSIZE + 1;
			endPage = startPage + BLOCKSIZE - 1;
			if(endPage > pageCnt) {
				endPage = pageCnt;
			}
			request.setAttribute("BLOCKSIZE", BLOCKSIZE);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("pageCnt", pageCnt);
			request.setAttribute("totCnt", totCnt);
			request.setAttribute("pageNum", pageNum);
		}else{                                // admin 로그인 삭제 포함해서 뿌리기
			ArrayList<ReviewDto> reviewList = reviewDao.searchReview(searchrTitle, startRow, endRow);
			request.setAttribute("reviewList", reviewList);
			totCnt = reviewDao.searchReviewCnt(searchrTitle);
			pageCnt = (int)Math.ceil((double)totCnt/PAGESIZE); // 페이지갯수
			startPage = ((currentPage - 1) / BLOCKSIZE) * BLOCKSIZE + 1;
			endPage = startPage + BLOCKSIZE - 1;
			if(endPage > pageCnt) {
				endPage = pageCnt;
			}
			request.setAttribute("BLOCKSIZE", BLOCKSIZE);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("pageCnt", pageCnt);
			request.setAttribute("totCnt", totCnt);
			request.setAttribute("pageNum", pageNum);
		}
	}
}
