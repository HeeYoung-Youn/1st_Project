package com.phone_rev.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.dao.N_commentDao;
import com.phone_rev.dao.R_commentDao;

public class NWriteComment_commentService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int nNum = Integer.parseInt(request.getParameter("nNum"));
		String mId = request.getParameter("mId");
		String ncContent = request.getParameter("ncContent");
		int ncGroup = Integer.parseInt(request.getParameter("ncGroup"));
		int ncStep = Integer.parseInt(request.getParameter("ncStep"));
		int ncIndent = Integer.parseInt(request.getParameter("ncIndent"));
		String ncIp = request.getRemoteAddr();
		N_commentDao nDao = N_commentDao.getInstance();
		int result = nDao.replyNoticeComment(nNum, mId, ncContent, ncGroup, ncStep, ncIndent, ncIp);
		if(result == N_commentDao.SUCCESS) {
			request.setAttribute("SuccessMsg", "댓글 작성이 완료되었습니다");
		}else {
			request.setAttribute("FailMsg", "댓글 작성에 실패했습니다");
		}

	}

}
