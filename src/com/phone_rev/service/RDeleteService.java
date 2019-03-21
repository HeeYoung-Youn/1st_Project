package com.phone_rev.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.dao.ReviewDao;

public class RDeleteService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int rNum = Integer.parseInt(request.getParameter("rNum"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		System.out.println(pageNum);
		ReviewDao reviewDao = ReviewDao.getInstance();
		int result = reviewDao.deleteReview(rNum);
		if(result == ReviewDao.SUCCESS) {
			request.setAttribute("SuccessMsg", "글 삭제가 성공되었습니다");
		}else {
			request.setAttribute("FailMsg", "글 삭제에 실패했습니다");
		}
	}
}
