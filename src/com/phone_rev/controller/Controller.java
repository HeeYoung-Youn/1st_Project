package com.phone_rev.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.service.ALoginService;
import com.phone_rev.service.MDownGradeMemberService;
import com.phone_rev.service.MIdConfirmService;
import com.phone_rev.service.MJoinService;
import com.phone_rev.service.MListMemberService;
import com.phone_rev.service.MLoginService;
import com.phone_rev.service.MLogoutService;
import com.phone_rev.service.MModifyService;
import com.phone_rev.service.MPwConfirmService;
import com.phone_rev.service.MQuitService;
import com.phone_rev.service.MUpGradeMemberService;
import com.phone_rev.service.MainService;
import com.phone_rev.service.MyContentService;
import com.phone_rev.service.NContentNotice;
import com.phone_rev.service.NDeleteService;
import com.phone_rev.service.NListNoticeService;
import com.phone_rev.service.NRevocerService;
import com.phone_rev.service.NWriteCommentService;
import com.phone_rev.service.NWriteComment_commentService;
import com.phone_rev.service.NWriteNotice;
import com.phone_rev.service.NcommentAppendService;
import com.phone_rev.service.NmodifyService;
import com.phone_rev.service.NmodifyViewService;
import com.phone_rev.service.QContentQnA;
import com.phone_rev.service.QDeleteService;
import com.phone_rev.service.QListQnAService;
import com.phone_rev.service.QReplyService;
import com.phone_rev.service.QReplyViewService;
import com.phone_rev.service.QRevocerService;
import com.phone_rev.service.QWriteQnA;
import com.phone_rev.service.QmodifyService;
import com.phone_rev.service.QmodifyViewService;
import com.phone_rev.service.RContentReview;
import com.phone_rev.service.RDeleteService;
import com.phone_rev.service.RLikeService;
import com.phone_rev.service.RListReviewService;
import com.phone_rev.service.RRevocerService;
import com.phone_rev.service.RWriteCommentService;
import com.phone_rev.service.RWriteComment_commentService;
import com.phone_rev.service.RWriteReview;
import com.phone_rev.service.RcommentAppendService;
import com.phone_rev.service.RmodifyService;
import com.phone_rev.service.RmodifyViewService;
import com.phone_rev.service.Service;


/**
 * Servlet implementation class Controller
 */
@WebServlet("*.do")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private int write_view = 0;
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		actionDo(request, response);
	}

	private void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String conPath = request.getContextPath();
		String com = uri.substring(conPath.length());
		String viewPage = null;
		Service service = null;
		if(com.equals("/main.do")) { // main
			service = new MainService();
			service.execute(request, response);
			viewPage = "main/main.jsp";
		}else if(com.equals("/joinView.do")) { // member관련
			viewPage = "member/join.jsp";
		}else if(com.equals("/mIdConfirm.do")) {
			service = new MIdConfirmService();
			service.execute(request, response);
			viewPage = "member/mIdConfirm.jsp";
		}else if(com.equals("/mPwConfirm.do")) {
			service = new MPwConfirmService();
			service.execute(request, response);
			viewPage = "member/mPwConfirm.jsp";
		}else if(com.equals("/join.do")) {
			service = new MJoinService();
			service.execute(request, response);
			viewPage = "loginView.do";
		}else if(com.equals("/loginView.do")) {
			viewPage = "member/login.jsp";
		}else if(com.equals("/login.do")) {
			service = new MLoginService();
			service.execute(request, response);
			viewPage = "main.do";
		}else if(com.equals("/logout.do")) {
			service = new MLogoutService();
			service.execute(request, response);
			viewPage = "main.do";
		}else if(com.equals("/modifyMemberView.do")) {
			viewPage = "member/modify.jsp";
		}else if(com.equals("/modifyMember.do")) {
			service = new MModifyService();
			service.execute(request, response);
			viewPage = "main.do";
		}else if(com.equals("/quitMemberView.do")) {
			viewPage = "member/quit.jsp";
		}else if(com.equals("/quitMember.do")) {
			service = new MQuitService();
			service.execute(request, response);
			viewPage = "main.do";
		}else if(com.equals("/listMember.do")) { // admin 관련
			service = new MListMemberService();
			service.execute(request, response);
			viewPage = "member/memberList.jsp";
		}else if(com.equals("/downgradeMember.do")) {
			service = new MDownGradeMemberService();
			viewPage = "/listMember.do";
			service.execute(request, response);
		}else if(com.equals("/upgradeMember.do")) {
			service = new MUpGradeMemberService();
			viewPage = "/listMember.do";
			service.execute(request, response);
		}else if(com.equals("/adminLoginView.do")) {
			viewPage = "admin/login.jsp";
		}else if(com.equals("/adminLogin.do")) {
			service = new ALoginService();
			service.execute(request, response);
			viewPage = "main.do";
		}else if(com.equals("/listReview.do")) { // review 관련
			service = new RListReviewService();
			service.execute(request, response);
			viewPage = "review/reviewList.jsp";
		}else if(com.equals("/contentReview.do")) {
			service = new RContentReview();
			service.execute(request, response);
			viewPage = "review/contentReview.jsp";
		}else if(com.equals("/writeReviewView.do")) {
			write_view = 1;
			viewPage = "review/writeReview.jsp";
		}else if(com.equals("/writeReview.do")) {
			if(write_view == 1) {
				service = new RWriteReview();
				service.execute(request, response);
				write_view = 0;
			}
			viewPage = "listReview.do";
		}else if(com.equals("/reviewLike.do")) {
			service = new RLikeService();
			service.execute(request, response);
			viewPage = "review/rLikeReview.jsp";
		}else if(com.equals("/ReviewCommentAppend.do")) {
			service = new RcommentAppendService();
			service.execute(request, response);
			viewPage = "review/appendComment.jsp";
		}else if(com.equals("/modifyReviewView.do")) {
			service = new RmodifyViewService();
			service.execute(request, response);
			viewPage = "review/modifyReview.jsp";
		}else if(com.equals("/modifyReview.do")) {
			service = new RmodifyService();
			service.execute(request, response);
			viewPage = "listReview.do";
		}else if(com.equals("/deleteReview.do")) {
			service = new RDeleteService();
			service.execute(request, response);
			viewPage = "listReview.do";
		}else if(com.equals("/writeCommentReview.do")) {
			service = new RWriteCommentService();
			service.execute(request, response);
			viewPage = "contentReview.do";
		}else if(com.equals("/writeComment_commentReview.do")) {
			service = new RWriteComment_commentService();
			service.execute(request, response);
			viewPage = "contentReview.do";
		}else if(com.equals("/recoverReview.do")) {
			service = new RRevocerService();
			service.execute(request, response);
			viewPage = "listReview.do";
		}else if(com.equals("/listQnA.do")) { // Q & A 관련
			service = new QListQnAService();
			service.execute(request, response);
			viewPage = "qna/qnaList.jsp";
		}else if(com.equals("/contentQnA.do")) {
			service = new QContentQnA();
			service.execute(request, response);
			viewPage = "qna/contentQnA.jsp";
		}else if(com.equals("/recoverQnA.do")) {
			service = new QRevocerService();
			service.execute(request, response);
			viewPage = "listQnA.do";
		}else if(com.equals("/modifyQnAView.do")) {
			service = new QmodifyViewService();
			service.execute(request, response);
			viewPage = "qna/modifyQnA.jsp";
		}else if(com.equals("/modifyQnA.do")) {
			service = new QmodifyService();
			service.execute(request, response);
			viewPage = "listQnA.do";
		}else if(com.equals("/deleteQnA.do")) {
			service = new QDeleteService();
			service.execute(request, response);
			viewPage = "listQnA.do";
		}else if(com.equals("/writeQnAView.do")) {
			write_view = 1;
			viewPage = "qna/writeQnA.jsp";
		}else if(com.equals("/writeQnA.do")) {
			if(write_view == 1) {
				service = new QWriteQnA();
				service.execute(request, response);
				write_view = 0;
			}
			viewPage = "listQnA.do";
		}else if(com.equals("/replyQnAView.do")) {
			service = new QReplyViewService();
			service.execute(request, response);
			viewPage = "qna/replyQnA.jsp";
		}else if(com.equals("/replyQnA.do")) {
			service = new QReplyService();
			service.execute(request, response);
			viewPage = "listQnA.do";
		}else if(com.equals("/listNotice.do")) { // Notice 관련
			service = new NListNoticeService();
			service.execute(request, response);
			viewPage = "notice/noticeList.jsp";
		}else if(com.equals("/writeNoticeView.do")) {
			write_view = 1;
			viewPage = "notice/writeNotice.jsp";
		}else if(com.equals("/writeNotice.do")) {
			if(write_view == 1) {
				service = new NWriteNotice();
				service.execute(request, response);
				write_view = 0;
			}
			viewPage = "listNotice.do";
		}else if(com.equals("/contentNotice.do")) {
			service = new NContentNotice();
			service.execute(request, response);
			viewPage = "notice/contentNotice.jsp";
		}else if(com.equals("/NoticeCommentAppend.do")) {
			service = new NcommentAppendService();
			service.execute(request, response);
			viewPage = "notice/appendComment.jsp";
		}else if(com.equals("/writeCommentNotice.do")) {
			service = new NWriteCommentService();
			service.execute(request, response);
			viewPage = "contentNotice.do";
		}else if(com.equals("/writeComment_commentNotice.do")) {
			service = new NWriteComment_commentService();
			service.execute(request, response);
			viewPage = "contentNotice.do";
		}else if(com.equals("/recoverNotice.do")) {
			service = new NRevocerService();
			service.execute(request, response);
			viewPage = "listNotice.do";
		}else if(com.equals("/deleteNotice.do")) {
			service = new NDeleteService();
			service.execute(request, response);
			viewPage = "listNotice.do";
		}else if(com.equals("/modifyNoticeView.do")) {
			service = new NmodifyViewService();
			service.execute(request, response);
			viewPage = "notice/modifyNotice.jsp";
		}else if(com.equals("/modifyNotice.do")) {
			service = new NmodifyService();
			service.execute(request, response);
			viewPage = "listNotice.do";
		}else if(com.equals("/myContent.do")) {
			service = new MyContentService();
			service.execute(request, response);
			viewPage = "member/myContent.jsp";
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
