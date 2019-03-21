package com.phone_rev.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.phone_rev.dao.MemberDao;
import com.phone_rev.dto.MemberDto;


public class MLoginService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String mId = request.getParameter("mId");
		String mPw = request.getParameter("mPw");
		MemberDao mDao = MemberDao.getInstance();
		int result = mDao.loginCheck(mId, mPw);
		if(result == MemberDao.LOGIN_SUCCESS) {
			HttpSession httpSession = request.getSession();
			MemberDto dto = mDao.getMember(mId);
			httpSession.setAttribute("mId", mId);
			httpSession.setAttribute("member", dto);
			request.setAttribute("loginSuccessMsg", "로그인이 완료되었습니다");
		}else if(result == MemberDao.LOGIN_FAIL) {
			request.setAttribute("loginFailMsg", "아이디 또는 비밀번호를 다시 확인하세요");
		}
	}
}
