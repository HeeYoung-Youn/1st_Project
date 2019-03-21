package com.phone_rev.service;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.dao.MemberDao;
import com.phone_rev.dto.MemberDto;

public class MJoinService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String mId = request.getParameter("mId");
		String mPw = request.getParameter("mPw");
		String mName = request.getParameter("mName");
		String chosedMBirth = request.getParameter("mBirth");
		Date mBirth;
		if(chosedMBirth.equals("")) {
			mBirth = null;
		}else {
			mBirth = Date.valueOf(chosedMBirth);
		}
		String mEmail = request.getParameter("mEmail");
		MemberDto dto = new MemberDto(mId, 1, mPw, mName, mEmail, mBirth, 1);
		MemberDao memberDao = MemberDao.getInstance();
		if(memberDao.joinMember(dto) == MemberDao.SUCCESS) {
			request.setAttribute("joinSuccessMsg", "회원가입이 완료되었습니다");
		}else {
			request.setAttribute("joinFailMsg", "회원가입에 실패했습니다");
		}
	}
}
