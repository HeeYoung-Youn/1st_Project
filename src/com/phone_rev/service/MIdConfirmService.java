package com.phone_rev.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.dao.MemberDao;

public class MIdConfirmService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String mId = request.getParameter("mId");
		MemberDao mDao = MemberDao.getInstance();
		int result = mDao.mIdConfirm(mId);
		if(result == MemberDao.EXISTENT) {
			request.setAttribute("mIdMsg", "중복된 ID입니다");
		}else {
			request.setAttribute("mIdMsg", "사용가능한 ID입니다");
		}
	}
}
