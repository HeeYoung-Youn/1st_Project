package com.phone_rev.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.dao.N_commentDao;
import com.phone_rev.dao.NoticeDao;
import com.phone_rev.dao.R_commentDao;
import com.phone_rev.dao.ReviewDao;
import com.phone_rev.dto.N_commentDto;
import com.phone_rev.dto.NoticeDto;
import com.phone_rev.dto.R_commentDto;
import com.phone_rev.dto.ReviewDto;

public class NContentNotice implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		NoticeDao noticeDao = NoticeDao.getInstance();
		N_commentDao commentDao = N_commentDao.getInstance();
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null) {
			pageNum = "1";
		}
		int totCnt = 0;
		int pageCnt = 0;
		int currentPage = Integer.parseInt(pageNum);
		int nNum = Integer.parseInt(request.getParameter("nNum"));
		final int PAGESIZE = 20;
		int startRow = (currentPage - 1) * PAGESIZE + 1;
		int endRow = startRow + PAGESIZE - 1;
		ArrayList<N_commentDto> commentList = commentDao.noticeCommentList(nNum, startRow, endRow);
		NoticeDto noticeDto = noticeDao.contentView(nNum);
		request.setAttribute("commentList", commentList);
		request.setAttribute("noticeDto", noticeDto);
		totCnt = commentDao.noticeCommentListCnt(nNum);
		pageCnt = (int)Math.ceil((double)totCnt/PAGESIZE);
		request.setAttribute("pageCnt", pageCnt);
		request.setAttribute("totCnt", totCnt);
		request.setAttribute("pageNum", pageNum);
	}
}
