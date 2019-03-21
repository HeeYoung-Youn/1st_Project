package com.phone_rev.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.dao.MemberDao;

public class MUpGradeMemberService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String[] mIdGroup = request.getParameterValues("mId");
		MemberDao memberDao = MemberDao.getInstance();
		int result = 0;
		for(int i=0; i<mIdGroup.length; i++) {
			result += memberDao.upgradeMember(mIdGroup[i]);
		}
		if(result==MemberDao.FAIL) {
			request.setAttribute("upGradeMsg", "일반회원 등록에 실패했습니다");
		}else {
			request.setAttribute("upGradeMsg", "일반회원 등록이 완료되었습니다");
		}
	}
}
