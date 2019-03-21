package com.phone_rev.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.dao.QnADao;
import com.phone_rev.dao.ReviewDao;

public class QRevocerService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int qNum = Integer.parseInt(request.getParameter("qNum"));
		QnADao qnaDao = QnADao.getInstance();
		int result = qnaDao.recoverQnA(qNum);
		if(result == QnADao.SUCCESS) {
			request.setAttribute("SuccessMsg", "글 복구가 성공되었습니다");
			System.out.println("복구성공");
		}else {
			request.setAttribute("FailMsg", "글 복구에 실패했습니다");
			System.out.println("복구실패");
		}
	}
}
