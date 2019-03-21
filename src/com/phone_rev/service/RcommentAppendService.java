package com.phone_rev.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.phone_rev.dao.R_commentDao;
import com.phone_rev.dto.R_commentDto;

public class RcommentAppendService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String pageNum = request.getParameter("pageNum");
		int rNum = Integer.parseInt(request.getParameter("rNum"));
		if(pageNum==null) {
			pageNum = "1";
		}
		final int PAGESIZE = 20;
		int currentPage = Integer.parseInt(pageNum);
		R_commentDao commentDao = R_commentDao.getInstance();
		int totCnt = commentDao.reviewCommentListCnt(rNum); // 글갯수
		int pageCnt = (int)Math.ceil((double)totCnt/PAGESIZE); // 페이지갯수
		if(currentPage < pageCnt) {
			currentPage++;
			int startRow = (currentPage - 1) * PAGESIZE + 1;
			int endRow = startRow + PAGESIZE - 1;
			ArrayList<R_commentDto> commentList = commentDao.reviewCommentList(rNum, startRow, endRow);
			request.setAttribute("commentList", commentList);
			request.setAttribute("pageNum", currentPage);
		}else {
			request.setAttribute("error", "마지막 페이지입니다");
		}
	}
}
