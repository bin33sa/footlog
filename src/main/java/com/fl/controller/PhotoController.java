package com.fl.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import com.fl.model.PhotoDTO;
import com.fl.util.FileManager;      
import com.fl.util.MyMultipartFile;  
import com.fl.util.MyUtil;

@WebServlet("/photo/*")
@MultipartConfig 
public class PhotoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private MyUtil util = new MyUtil();
	private FileManager fileManager = new FileManager(); 

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}

	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String uri = req.getRequestURI();
		String cp = req.getContextPath();
		
		if (uri.indexOf(cp) == 0) {
			uri = uri.substring(cp.length());
		}
		
		if (uri.indexOf("/photo/list") != -1) {
			list(req, resp);
		} else if (uri.indexOf("/photo/write") != -1) {
			if(req.getMethod().equalsIgnoreCase("GET")) {
				writeForm(req, resp);
			} else {
				writeSubmit(req, resp);
			}
		} else if (uri.indexOf("/photo/article") != -1) {
			article(req, resp);
		}
	}

	// 1. 리스트
	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cp = req.getContextPath();
		
		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if (page != null) current_page = Integer.parseInt(page);

			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if (schType == null) { schType = "all"; kwd = ""; }
			if(req.getMethod().equalsIgnoreCase("GET")) { kwd = util.decodeUrl(kwd); }

			int dataCount = 35; 
			int size = 12; 
			int total_page = util.pageCount(dataCount, size);
			if (current_page > total_page) current_page = total_page;
			
			List<PhotoDTO> list = new ArrayList<>();
			int startNum = dataCount - (current_page - 1) * size; 
			int endNum = startNum - size + 1;
			if(endNum < 1) endNum = 1;

			for (int i = startNum; i >= endNum; i--) {
				PhotoDTO dto = new PhotoDTO();
				dto.setNum(i);
				dto.setSubject("갤러리 사진 (" + i + ")");
				dto.setUserId("admin");
				dto.setUserName("관리자");
				dto.setReg_date("2025-05-22");
				// 리스트 썸네일용 (sample.jpg가 없으면 엑박 뜨므로 주의)
				dto.setImageFilename("sample.jpg"); 
				list.add(dto);
			}

			String listUrl = cp + "/photo/list";
			
			// JSP에서 seq로 넘기도록 여기서 주소 생성
			String articleUrl = cp + "/photo/article?page=" + current_page;
			
			String query = "size=" + size;
			if(kwd.length() != 0) {
				query += "&schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
				listUrl += "?" + query;
				articleUrl += "&" + query;
			} else {
				listUrl += "?";
			}
			
			String paging = util.paging(current_page, total_page, listUrl);

			req.setAttribute("list", list);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("size", size);
			req.setAttribute("page", current_page);
			req.setAttribute("total_page", total_page);
			req.setAttribute("articleUrl", articleUrl);
			req.setAttribute("paging", paging);
			req.setAttribute("schType", schType);
			req.setAttribute("kwd", kwd);
			
			String path = "/WEB-INF/views/photo/list.jsp";
			req.getRequestDispatcher(path).forward(req, resp);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 2. 글쓰기 폼
	protected void writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("mode", "write");
		String path = "/WEB-INF/views/photo/write.jsp";
		req.getRequestDispatcher(path).forward(req, resp);
	}

	// 3. 글 저장
	protected void writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		String cp = req.getContextPath();
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "photo";

		try {
			PhotoDTO dto = new PhotoDTO();
			dto.setUserId("admin");
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));

			Part p = req.getPart("uploadFile"); 
			MyMultipartFile multiPart = fileManager.doFileUpload(p, pathname);
			
			if (multiPart != null) {
				String filename = multiPart.getSaveFilename();
				dto.setImageFilename(filename);
				System.out.println("파일 저장 성공: " + pathname + File.separator + filename);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/photo/list");
	}

	// 4. 글 보기 
	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cp = req.getContextPath();
		String page = req.getParameter("page");
		String query = "page=" + page;
		
		try {
			
			long num = Long.parseLong(req.getParameter("seq")); 
			
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if (schType == null) { schType = "all"; kwd = ""; }
			kwd = util.decodeUrl(kwd);
			if (kwd.length() != 0) {
				query += "&schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}

			// 상세 보기용 가짜 데이터
			PhotoDTO dto = new PhotoDTO();
			dto.setNum(num);
			dto.setSubject("사진 상세 보기");
			dto.setContent("사진 설명입니다.");
			
		
			dto.setImageFilename("meow.png"); 
			
			dto.setUserId("admin");
			dto.setUserName("관리자");
			dto.setReg_date("2025-05-22");
			
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("query", query);

			//  article.jsp로 포워딩
			String path = "/WEB-INF/views/photo/article.jsp";
			req.getRequestDispatcher(path).forward(req, resp);
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendRedirect(cp + "/photo/list?" + query);
		}
	}
}