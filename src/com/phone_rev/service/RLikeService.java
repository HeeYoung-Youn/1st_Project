package com.phone_rev.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.phone_rev.dao.R_likeDao;
import com.phone_rev.dao.ReviewDao;
import com.phone_rev.dto.R_likeDto;
import com.phone_rev.dto.ReviewDto;

public class RLikeService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession httpSession = request.getSession();
		String mId = (String) httpSession.getAttribute("mId");
		int rNum = Integer.parseInt(request.getParameter("rNum"));
		R_likeDao likeDao = R_likeDao.getInstance();
		ReviewDao reviewDao = ReviewDao.getInstance();
		if(likeDao.likePressConfirm(rNum, mId)==R_likeDao.UNPRESSED) {
			likeDao.pressLike(rNum, mId);
			ReviewDto reviewDto = reviewDao.contentView(rNum);
			int likeCnt = reviewDto.getLikeCnt();
			request.setAttribute("likeCnt", likeCnt);
			request.setAttribute("likePressMsg", "추천을 눌렀습니다");
		}else {
			ReviewDto reviewDto = reviewDao.contentView(rNum);
			int likeCnt = reviewDto.getLikeCnt();
			request.setAttribute("likeCnt", likeCnt);
			request.setAttribute("likePressMsg", "이미 추천을 누른 글입니다");
		}
	}
}
