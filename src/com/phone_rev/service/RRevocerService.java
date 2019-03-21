package com.phone_rev.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.dao.ReviewDao;

public class RRevocerService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int rNum = Integer.parseInt(request.getParameter("rNum"));
		ReviewDao reviewDao = ReviewDao.getInstance();
		int result = reviewDao.recoverReview(rNum);
		if(result == ReviewDao.SUCCESS) {
			request.setAttribute("SuccessMsg", "글 복구가 성공되었습니다");
			System.out.println("복구성공");
		}else {
			request.setAttribute("FailMsg", "글 복구에 실패했습니다");
			System.out.println("복구실패");
		}
	}
}
