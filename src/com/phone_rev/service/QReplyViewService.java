package com.phone_rev.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.dao.QnADao;
import com.phone_rev.dto.QnADto;

public class QReplyViewService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int qNum = Integer.parseInt(request.getParameter("qNum"));
		QnADao qnaDao = QnADao.getInstance();
		QnADto dto      = qnaDao.modifyQnAView_replyQnAView(qNum);
		request.setAttribute("reply_view", dto);
	}
}
