package com.phone_rev.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.dao.N_commentDao;

public class NWriteCommentService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int nNum = Integer.parseInt(request.getParameter("nNum"));
		String mId = request.getParameter("mId");
		String ncContent = request.getParameter("ncContent");
		String ncIp = request.getRemoteAddr();
		N_commentDao nDao = N_commentDao.getInstance();
		int result = nDao.writeNoticeComment(nNum, mId, ncContent, ncIp);
		if(result == N_commentDao.SUCCESS) {
			request.setAttribute("SuccessMsg", "댓글 작성이 완료되었습니다");
		}else {
			request.setAttribute("FailMsg", "댓글 작성에 실패했습니다");
		}
	}
}
