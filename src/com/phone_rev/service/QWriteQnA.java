package com.phone_rev.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.dao.QnADao;

public class QWriteQnA implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String mId = request.getParameter("mId");
		String qTitle = request.getParameter("qTitle");
		String qIp = request.getRemoteAddr();
		String qContent = request.getParameter("qContent");
		qContent = qContent.trim();
		QnADao dao = QnADao.getInstance();
		int result = dao.writeQnA(mId, qTitle, qContent, qIp);
		if(result == QnADao.SUCCESS) {
			request.setAttribute("SuccessMsg", "글 작성이 완료되었습니다");
		}else {
			request.setAttribute("FailMsg", "글 작성에 실패했습니다");
		}
	}
}
