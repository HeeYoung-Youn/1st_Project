package com.phone_rev.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.dao.NoticeDao;
import com.phone_rev.dao.QnADao;

public class NmodifyService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int nNum = Integer.parseInt(request.getParameter("nNum"));
		String nTitle = request.getParameter("nTitle");
		String nIp = request.getRemoteAddr();
		String nContent = request.getParameter("nContent");
		nContent = nContent.trim();
		String pageNum = request.getParameter("pageNum");
		request.setAttribute("pageNum", pageNum);
		NoticeDao dao = NoticeDao.getInstance();
		int result = dao.modifyNotice(nTitle, nContent, nIp, nNum);
		if(result == NoticeDao.SUCCESS) {
			request.setAttribute("SuccessMsg", "글 수정이 완료되었습니다");
		}else {
			request.setAttribute("FailMsg", "글 수정에 실패했습니다");
		}

	}

}
