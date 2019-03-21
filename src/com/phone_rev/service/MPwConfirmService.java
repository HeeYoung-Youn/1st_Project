package com.phone_rev.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.dao.MemberDao;

public class MPwConfirmService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String mId = request.getParameter("mId");
		String nowPw = request.getParameter("nowPw");
		MemberDao mDao = MemberDao.getInstance();
		int result = mDao.mPwConfirm(mId, nowPw);
		if(result == MemberDao.SUCCESS) {
			request.setAttribute("mPwMsg", "등록된 비밀번호와 일치합니다");
		}else if(result == MemberDao.FAIL){
			request.setAttribute("mPwMsg", "등록된 비밀번호와 일치하지 않습니다");
		}
	}

}
