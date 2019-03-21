package com.phone_rev.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.phone_rev.dao.MemberDao;

public class MQuitService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String mId = request.getParameter("mId");
		MemberDao memberDao = MemberDao.getInstance();
		memberDao.quitMember(mId);
		if(memberDao.quitMember(mId) == MemberDao.SUCCESS) {
			request.setAttribute("quitSuccessMsg", "회원 탈퇴가 완료되었습니다");
			HttpSession httpSession = request.getSession();
			httpSession.invalidate();
		}else {
			request.setAttribute("quitFailMsg", "회원 탈퇴에 싪패했습니다");
		}
	}
}
