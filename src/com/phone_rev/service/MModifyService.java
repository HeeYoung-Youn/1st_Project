package com.phone_rev.service;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.phone_rev.dao.MemberDao;
import com.phone_rev.dto.MemberDto;

public class MModifyService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String mId = request.getParameter("mId");
		String mPw = request.getParameter("mPw");
		String nowPw = request.getParameter("nowPw");
		if(mPw.equals("")) {
			mPw = nowPw;
		}
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
		if(memberDao.modifyMember(dto) == MemberDao.SUCCESS) {
			request.setAttribute("modifyResult", "회원정보 수정이 완료되었습니다");
			HttpSession httpSession = request.getSession();
			httpSession.setAttribute("member", dto);
		}else {
			request.setAttribute("modifyResult", "회원정보 수정에 실패했습니다");
		}
	}
}
