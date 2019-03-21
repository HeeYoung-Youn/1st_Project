package com.phone_rev.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.phone_rev.dao.ReviewDao;

public class RmodifyService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String path = request.getRealPath("reviewFile");
		int maxSize = 1024*1024*20;
		String[] file = {"", "", "", "", ""};
		String[] originalFile = {"", "", "", "", ""};
		String[] upFile = {"","","","",""};
		MultipartRequest mRequest = null;
		try {
			mRequest = new MultipartRequest(request, path, maxSize, 
					"utf-8", new DefaultFileRenamePolicy());
			Enumeration params = mRequest.getFileNames();
			int idx = 4;
			while(params.hasMoreElements()) {
				String param = (String) params.nextElement();
				file[idx] = mRequest.getFilesystemName(param);
				idx--;
			}
			originalFile[0] = mRequest.getParameter("dbrFileName_1");
			originalFile[1] = mRequest.getParameter("dbrFileName_2");
			originalFile[2] = mRequest.getParameter("dbrFileName_3");
			originalFile[3] = mRequest.getParameter("dbrFileName_4");
			originalFile[4] = mRequest.getParameter("dbrFileName_5");
			for(int i=0 ; i<file.length ; i++) {
				upFile[i] = (file[i]==null)? originalFile[i] :file[i];
			}
			String rTitle = mRequest.getParameter("rTitle");
			String rContent = mRequest.getParameter("rContent");
			rContent = rContent.trim();
			String rIp = request.getRemoteAddr();
			int rNum = Integer.parseInt(mRequest.getParameter("rNum"));
			String pageNum = mRequest.getParameter("pageNum");
			request.setAttribute("pageNum", pageNum);
			ReviewDao dao = ReviewDao.getInstance();
			int result = dao.modifyReview(rTitle, rContent, upFile[0], 
					upFile[1], upFile[2], upFile[3], upFile[4], rIp, rNum);
			if(result == ReviewDao.SUCCESS) {
				request.setAttribute("SuccessMsg", "글 수정이 완료되었습니다");
			}else {
				request.setAttribute("FailMsg", "글 수정에 실패했습니다");
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
				System.out.println("error:"+e.getMessage());
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
