package com.phone_rev.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.dao.NoticeDao;
import com.phone_rev.dao.QnADao;

public class NWriteNotice implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String aId = request.getParameter("aId");
		String nTitle = request.getParameter("nTitle");
		String nIp = request.getRemoteAddr();
		String nContent = request.getParameter("nContent");
		nContent = nContent.trim();
		NoticeDao dao = NoticeDao.getInstance();
		int result = dao.writeNotice(aId, nTitle, nContent, nIp);
		if(result == NoticeDao.SUCCESS) {
			request.setAttribute("SuccessMsg", "글 작성이 완료되었습니다");
		}else {
			request.setAttribute("FailMsg", "글 작성에 실패했습니다");
		}
	}
}
