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

import com.fl.model.GalleryDTO; // [변경] PhotoDTO -> GalleryDTO
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
			
			List<GalleryDTO> list = new ArrayList<>();
			int startNum = dataCount - (current_page - 1) * size;
			int endNum = startNum - size + 1;
			if(endNum < 1) endNum = 1;

	
			for (int i = startNum; i >= endNum; i--) {
				GalleryDTO dto = new GalleryDTO();
				
	
				dto.setGallery_code((long)i);
				
	
				dto.setTitle("갤러리 사진 (" + i + ")");
				
				
				dto.setMember_id("admin");
				dto.setMember_name("관리자");
				
				// [변경] reg_date -> created_at
				dto.setCreated_at("2025-05-22");
				
				// [변경] imageFilename -> title_image (썸네일)
				dto.setTitle_image("sample.jpg");
				
				// [추가] 조회수 등
				dto.setView_count(i * 10);
				
				list.add(dto);
			}

			String listUrl = cp + "/photo/list";
			
			// [변경] articleUrl 파라미터를 gallery_code로 받을 준비 (JSP에서 &gallery_code=${dto.gallery_code} 사용 권장)
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
			GalleryDTO dto = new GalleryDTO();
			
			// [변경] DTO 변수명에 맞춰 파라미터 수신
			// 주의: JSP의 input name도 "subject" -> "title"로 바꾸는 것이 좋지만,
			// 일단 기존 JSP 호환을 위해 "subject"로 받아서 setTitle에 넣습니다.
			String title = req.getParameter("title");
			if(title == null) title = req.getParameter("subject"); // 호환성 체크
			
			dto.setTitle(title);
			dto.setContent(req.getParameter("content"));
			dto.setMember_id("admin"); // 임시

			Part p = req.getPart("uploadFile");
			MyMultipartFile multiPart = fileManager.doFileUpload(p, pathname);
			
			if (multiPart != null) {
				String filename = multiPart.getSaveFilename();
				
				// [변경] imageFilename -> title_image
				dto.setTitle_image(filename);
				
				System.out.println("파일 저장 성공: " + pathname + File.separator + filename);
			}
			
			// 실제 DB 저장 로직 (Service 호출)
			// dao.insertGallery(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/photo/list");
	}

	// 4. 글 보기 (Article -> View)
	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cp = req.getContextPath();
		String page = req.getParameter("page");
		String query = "page=" + page;
		
		try {
			// [변경] 파라미터 수신 (gallery_code 우선, 없으면 seq)
			String codeStr = req.getParameter("gallery_code");
			if(codeStr == null) codeStr = req.getParameter("seq");
			
			long gallery_code = Long.parseLong(codeStr);
			
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if (schType == null) { schType = "all"; kwd = ""; }
			kwd = util.decodeUrl(kwd);
			if (kwd.length() != 0) {
				query += "&schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}

			// 상세 보기용 가짜 데이터
			GalleryDTO dto = new GalleryDTO();
			
			// [변경] setter 메서드명 변경
			dto.setGallery_code(gallery_code);
			dto.setTitle("사진 상세 보기 (제목)");
			dto.setContent("사진 설명입니다. (내용)");
			
			// [변경] 이미지 파일명 설정
			dto.setTitle_image("meow.png");
			
			dto.setMember_id("admin");
			dto.setMember_name("관리자");
			dto.setCreated_at("2025-05-22");
			dto.setView_count(123);
			
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("query", query);

			String path = "/WEB-INF/views/photo/article.jsp";
			req.getRequestDispatcher(path).forward(req, resp);
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendRedirect(cp + "/photo/list?" + query);
		}
	}
}