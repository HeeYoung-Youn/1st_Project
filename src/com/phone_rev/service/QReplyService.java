package com.phone_rev.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.dao.QnADao;

public class QReplyService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String mId = request.getParameter("mId");
		String qTitle = request.getParameter("qTitle");
		String qIp = request.getRemoteAddr();
		String qContent = request.getParameter("qContent");
		qContent = qContent.trim();
		int qGroup = Integer.parseInt(request.getParameter("qGroup"));
		int qStep = Integer.parseInt(request.getParameter("qStep"));
		int qIndent = Integer.parseInt(request.getParameter("qIndent"));
		String pageNum = request.getParameter("pageNum");
		request.setAttribute("pageNum", pageNum);
		QnADao dao = QnADao.getInstance();
		int result = dao.reply(mId, qTitle, qContent, qGroup, qStep, qIndent, qIp);
		if(result == QnADao.SUCCESS) {
			request.setAttribute("SuccessMsg", "답변글 작성이 완료되었습니다");
		}else {
			request.setAttribute("FailMsg", "답변글 작성에 실패했습니다");
		}
	}
}
