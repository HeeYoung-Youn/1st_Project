package com.phone_rev.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.dao.R_commentDao;
import com.phone_rev.dto.R_commentDto;

public class RWriteCommentService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int rNum = Integer.parseInt(request.getParameter("rNum"));
		String mId = request.getParameter("mId");
		String cContent = request.getParameter("cContent");
		String cIp = request.getRemoteAddr();
		R_commentDao rDao = R_commentDao.getInstance();
		int result = rDao.writeReviewComment(rNum, mId, cContent, cIp);
		if(result == R_commentDao.SUCCESS) {
			request.setAttribute("SuccessMsg", "댓글 작성이 완료되었습니다");
		}else {
			request.setAttribute("FailMsg", "댓글 작성에 실패했습니다");
		}
	}
}
