package com.phone_rev.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phone_rev.dao.ReviewDao;
import com.phone_rev.dto.ReviewDto;

public class MainService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		ReviewDao reviewDao = ReviewDao.getInstance();
		ArrayList<ReviewDto> reviewList = reviewDao.getReviewList();
		ArrayList<Integer> rNumList = new ArrayList<Integer>();
		ArrayList<String> fileNameList = new ArrayList<String>();
		for(int i=0; i<reviewList.size(); i++) {
			ReviewDto reviewDto = reviewList.get(i);
			int rNum = reviewDto.getrNum();
			String fileName = reviewDto.getrFileName_1();
			rNumList.add(rNum);
			fileNameList.add(fileName);
		}
		request.setAttribute("rNumList", rNumList);
		request.setAttribute("fileNameList", fileNameList);
	}
}
