package com.phone_rev.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.dao.QnADao;

public class QmodifyService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int qNum = Integer.parseInt(request.getParameter("qNum"));
		String qTitle = request.getParameter("qTitle");
		String qIp = request.getRemoteAddr();
		String qContent = request.getParameter("qContent");
		qContent = qContent.trim();
		String pageNum = request.getParameter("pageNum");
		request.setAttribute("pageNum", pageNum);
		QnADao dao = QnADao.getInstance();
		int result = dao.modifyQnA(qTitle, qContent, qIp, qNum);
		if(result == QnADao.SUCCESS) {
			request.setAttribute("SuccessMsg", "글 수정이 완료되었습니다");
		}else {
			request.setAttribute("FailMsg", "글 수정에 실패했습니다");
		}
	}
}
