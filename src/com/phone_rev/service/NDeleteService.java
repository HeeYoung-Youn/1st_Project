package com.phone_rev.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.dao.NoticeDao;
import com.phone_rev.dao.ReviewDao;

public class NDeleteService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int nNum = Integer.parseInt(request.getParameter("nNum"));
		NoticeDao noticeDao = NoticeDao.getInstance();
		int result = noticeDao.deleteNotice(nNum);
		if(result == NoticeDao.SUCCESS) {
			request.setAttribute("SuccessMsg", "글 삭제에 성공했습니다");
		}else {
			request.setAttribute("FailMsg", "글 삭제에 실패했습니다");
		}
	}
}
