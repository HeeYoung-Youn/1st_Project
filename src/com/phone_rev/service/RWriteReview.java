package com.phone_rev.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Date;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.phone_rev.dao.ReviewDao;
import com.phone_rev.dto.ReviewDto;

public class RWriteReview implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String path = request.getRealPath("reviewFile");
		int maxSize = 1024*1024*20;
		String[] file = {"", "", "", "", ""};
		String[] originalFile = {"", "", "", "", ""};
		MultipartRequest mRequest = null;
		try {
			mRequest = new MultipartRequest(request, path, maxSize, 
					"utf-8", new DefaultFileRenamePolicy());
			Enumeration params = mRequest.getFileNames();
			int idx = 0;
			while(params.hasMoreElements()) {
				String param = (String) params.nextElement();
				file[idx] = mRequest.getFilesystemName(param);
				originalFile[idx] = mRequest.getOriginalFileName(param);
				idx++;
			}
			String mId = mRequest.getParameter("mId");
			String rTitle = mRequest.getParameter("rTitle");
			String rContent = mRequest.getParameter("rContent");
			rContent = rContent.trim();
			String rIp = request.getRemoteAddr();
			String rFileName_1 = file[4];
			String rFileName_2 = file[3];
			String rFileName_3 = file[2];
			String rFileName_4 = file[1];
			String rFileName_5 = file[0];
			ReviewDao dao = ReviewDao.getInstance();
			int result = dao.writeReview(mId, rTitle, rContent, rFileName_1, 
				rFileName_2, rFileName_3, rFileName_4, rFileName_5, rIp);
			if(result == ReviewDao.SUCCESS) {
				request.setAttribute("SuccessMsg", "글 작성이 완료되었습니다");
			}else {
				request.setAttribute("FailMsg", "글 작성에 실패했습니다");
			}
		}catch (IOException e) {
			System.out.println(e.getMessage());
			request.setAttribute("FailMsg", "20mb이하의 사진만 첨부 가능합니다");
		}
		
		for(String f : file) {
			InputStream is = null;
			OutputStream os = null;
			try {
				File serverFile = new File(path + "/" + f);
				if(serverFile.exists()) {
					is = new FileInputStream(serverFile);
					os = new FileOutputStream("D:/mega_IT/source/6_JSP/project_01/WebContent/reviewFile/" + f);
					byte[] bs = new byte[(int)serverFile.length()];
					while(true) {
						int nReadByte = is.read(bs);
						if(nReadByte==-1) {
							break;
						}
						os.write(bs, 0, nReadByte);
					}
				}
			}catch (Exception e) {
				System.out.println(e.getMessage());
			}finally {
				try {
					if(os!=null) {
						os.close();
					}
					if(is!=null) {
						is.close();
					}
				}catch (Exception e) {
					System.out.println(e.getMessage());
				}
			}
		}
	}
}
