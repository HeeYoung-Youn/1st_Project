package com.phone_rev.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.dao.QnADao;

public class QDeleteService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int qNum = Integer.parseInt(request.getParameter("qNum"));
		QnADao qnaDao = QnADao.getInstance();
		int result = qnaDao.deleteQnA(qNum);
		if(result == QnADao.SUCCESS) {
			request.setAttribute("SuccessMsg", "글 삭제가 성공되었습니다");
		}else {
			request.setAttribute("FailMsg", "글 삭제에 실패했습니다");
		}
	}
}
