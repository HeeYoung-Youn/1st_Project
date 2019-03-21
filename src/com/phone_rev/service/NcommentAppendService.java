package com.phone_rev.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.dao.N_commentDao;
import com.phone_rev.dao.R_commentDao;
import com.phone_rev.dto.N_commentDto;
import com.phone_rev.dto.R_commentDto;

public class NcommentAppendService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String pageNum = request.getParameter("pageNum");
		int nNum = Integer.parseInt(request.getParameter("nNum"));
		if(pageNum==null) {
			pageNum = "1";
		}
		final int PAGESIZE = 20;
		int currentPage = Integer.parseInt(pageNum);
		N_commentDao commentDao = N_commentDao.getInstance();
		int totCnt = commentDao.noticeCommentListCnt(nNum); // 글갯수
		int pageCnt = (int)Math.ceil((double)totCnt/PAGESIZE); // 페이지갯수
		if(currentPage < pageCnt) {
			currentPage++;
			int startRow = (currentPage - 1) * PAGESIZE + 1;
			int endRow = startRow + PAGESIZE - 1;
			ArrayList<N_commentDto> commentList = commentDao.noticeCommentList(nNum, startRow, endRow);
			request.setAttribute("commentList", commentList);
			request.setAttribute("pageNum", currentPage);
		}else {
			request.setAttribute("error", "마지막 페이지입니다");
		}
	}
}
