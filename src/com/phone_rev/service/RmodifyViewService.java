package com.phone_rev.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.dao.ReviewDao;
import com.phone_rev.dto.ReviewDto;

public class RmodifyViewService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int rNum = Integer.parseInt(request.getParameter("rNum"));
		ReviewDao reviewDao = ReviewDao.getInstance();
		ReviewDto dto = reviewDao.reviewModifyView(rNum);
		request.setAttribute("modify_view", dto);
	}
}
