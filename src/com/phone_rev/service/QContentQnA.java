package com.phone_rev.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.dao.QnADao;
import com.phone_rev.dto.QnADto;

public class QContentQnA implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		QnADao qnaDao = QnADao.getInstance();
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null) {
			pageNum = "1";
		}
		int qNum = Integer.parseInt(request.getParameter("qNum"));
		QnADto qnaDto = qnaDao.contentView(qNum);
		request.setAttribute("qnaDto", qnaDto);
		request.setAttribute("pageNum", pageNum);
	}
}
