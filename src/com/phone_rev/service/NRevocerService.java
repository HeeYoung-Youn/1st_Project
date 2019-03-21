package com.phone_rev.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.dao.NoticeDao;
import com.phone_rev.dao.ReviewDao;

public class NRevocerService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int nNum = Integer.parseInt(request.getParameter("nNum"));
		NoticeDao noticeDao = NoticeDao.getInstance();
		int result = noticeDao.recoverNotice(nNum);
		if(result == NoticeDao.SUCCESS) {
			request.setAttribute("SuccessMsg", "글 복구에 성공했습니다");
			System.out.println("복구 성공");
		}else {
			request.setAttribute("FailMsg", "글 복구에 실패했습니다");
			System.out.println("복구 실패");
		}
	}
}
