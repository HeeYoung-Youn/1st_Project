package com.phone_rev.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.dao.MemberDao;
import com.phone_rev.dto.MemberDto;

public class MListMemberService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String pageNum = request.getParameter("pageNum");
		String searchmId = request.getParameter("searchmId");
		if(pageNum==null) {
			pageNum = "1";
		}
		if(searchmId==null) {
			searchmId = "";
		}
		int currentPage = Integer.parseInt(pageNum);
		final int PAGESIZE = 10, BLOCKSIZE = 10;
		int startRow = (currentPage - 1) * PAGESIZE + 1;
		int endRow = startRow + PAGESIZE - 1;
		MemberDao memberDao = MemberDao.getInstance();
		ArrayList<MemberDto> listMember = memberDao.listMember(searchmId, startRow, endRow);
		request.setAttribute("listMember", listMember);
		int totCnt = memberDao.getMemberTotCnt(searchmId);
		int pageCnt = (int)Math.ceil((double)totCnt/PAGESIZE); // 페이지갯수
		int startPage = ((currentPage - 1) / BLOCKSIZE) * BLOCKSIZE + 1;
		int endPage = startPage + BLOCKSIZE - 1;
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
