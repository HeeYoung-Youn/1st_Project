package com.phone_rev.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.phone_rev.dao.AdminDao;
import com.phone_rev.dao.MemberDao;
import com.phone_rev.dto.AdminDto;
import com.phone_rev.dto.MemberDto;

public class ALoginService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String aId = request.getParameter("aId");
		String aPw = request.getParameter("aPw");
		AdminDao aDao = AdminDao.getInstance();
		int result = aDao.loginCheck(aId, aPw);
		if(result == AdminDao.LOGIN_SUCCESS) {
			HttpSession httpSession = request.getSession();
			AdminDto dto = aDao.getAdmin(aId);
			httpSession.setAttribute("aId", aId);
			httpSession.setAttribute("admin", dto);
			request.setAttribute("loginSuccessMsg", "로그인이 완료되었습니다");
		}else if(result == MemberDao.LOGIN_FAIL) {
			request.setAttribute("loginFailMsg", "아이디 또는 비밀번호를 다시 확인하세요");
		}
	}
}
