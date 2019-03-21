package com.phone_rev.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.dao.NoticeDao;
import com.phone_rev.dao.QnADao;
import com.phone_rev.dto.NoticeDto;
import com.phone_rev.dto.QnADto;

public class NmodifyViewService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int nNum = Integer.parseInt(request.getParameter("nNum"));
		NoticeDao noticeDao = NoticeDao.getInstance();
		NoticeDto dto = noticeDao.noticeModifyView(nNum);
		request.setAttribute("modify_view", dto);
	}
}
