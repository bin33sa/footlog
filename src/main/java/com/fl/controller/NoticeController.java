package com.fl.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig; // 파일 업로드용 설정
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import com.fl.model.NoticeDTO;
import com.fl.util.MyUtil;

@WebServlet("/notice/*")
@MultipartConfig // JSP에 enctype="multipart/form-data"가 있으면 이게 꼭 있어야 request.getParameter가 작동함
public class NoticeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private MyUtil util = new MyUtil();

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
		
		// URL 라우팅 (주소 분기 처리)
		if (uri.indexOf("/notice/list") != -1) {
			list(req, resp);
		} else if (uri.indexOf("/notice/write") != -1) {
			// GET 방식이면 폼 보여주기, POST 방식이면 저장하기
			if(req.getMethod().equalsIgnoreCase("GET")) {
				writeForm(req, resp);
			} else {
				writeSubmit(req, resp);
			}
		} else if (uri.indexOf("/notice/view") != -1) {
			view(req, resp);
		}
	}

	// 1. 리스트 (가짜 데이터)
	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cp = req.getContextPath();
		
		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if (page != null) {
				current_page = Integer.parseInt(page);
			}
			
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if (schType == null) {
				schType = "all";
				kwd = "";
			}
			if(req.getMethod().equalsIgnoreCase("GET")) {
				kwd = util.decodeUrl(kwd);
			}

			int dataCount = 35; 
			int size = 10;
			int total_page = util.pageCount(dataCount, size);
			
			if (current_page > total_page) {
				current_page = total_page;
			}
			
			List<NoticeDTO> list = new ArrayList<>();
			int startNum = dataCount - (current_page - 1) * size; 
			int endNum = startNum - size + 1;
			if(endNum < 1) endNum = 1;

			for (int i = startNum; i >= endNum; i--) {
				NoticeDTO dto = new NoticeDTO();
				dto.setNum(i);
				dto.setNotice(0);
				dto.setTitle("페이징 테스트용 공지사항 제목입니다. (" + i + ")");
				dto.setUserId("admin");
				dto.setUserName("관리자");
				dto.setRegDate("2025-05-22");
				dto.setHitCount(i * 5);
				list.add(dto);
			}

			List<NoticeDTO> listNotice = new ArrayList<>();
			if(current_page == 1) {
				NoticeDTO topDto = new NoticeDTO();
				topDto.setNum(100);
				topDto.setNotice(1);
				topDto.setTitle("[필독] 커뮤니티 이용 규정 안내");
				topDto.setUserId("admin");
				topDto.setUserName("관리자");
				topDto.setRegDate("2025-01-01");
				topDto.setHitCount(9999);
				listNotice.add(topDto);
			}
			
			String listUrl = cp + "/notice/list";
			String articleUrl = cp + "/notice/view?page=" + current_page;
			
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
			req.setAttribute("listNotice", listNotice);
			req.setAttribute("articleUrl", articleUrl);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("page", current_page);
			req.setAttribute("total_page", total_page);
			req.setAttribute("paging", paging);
			req.setAttribute("schType", schType);
			req.setAttribute("kwd", kwd);
			
			String path = "/WEB-INF/views/notice/list.jsp";
			req.getRequestDispatcher(path).forward(req, resp);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 2. 글 쓰기 폼 (GET)
	protected void writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("mode", "write");
		String path = "/WEB-INF/views/notice/write.jsp";
		req.getRequestDispatcher(path).forward(req, resp);
	}

	// 3. 글 저장 처리 (POST) - DB 없으므로 콘솔 출력만
	protected void writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cp = req.getContextPath();
		
		try {
			// @MultipartConfig가 있어야 아래 파라미터가 읽힘
			String title = req.getParameter("title");
			String content = req.getParameter("content");
			String notice = req.getParameter("notice"); // 체크하면 "1", 안하면 null
			
			// DB 저장 시뮬레이션 (콘솔 확인용)
			System.out.println("--- [공지사항 등록 시뮬레이션] ---");
			System.out.println("제목: " + title);
			System.out.println("내용: " + content);
			System.out.println("중요공지 여부: " + (notice == null ? "일반(0)" : "중요(1)"));
			System.out.println("파일: 업로드 로직은 추후 구현");
			
			// 저장이 끝나면 리스트로 리다이렉트
			resp.sendRedirect(cp + "/notice/list");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 4. 글 보기
	protected void view(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cp = req.getContextPath();
		String page = req.getParameter("page");
		String query = "page=" + page;
		
		try {
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if(schType == null) {
				schType = "all";
				kwd = "";
			}
			kwd = util.decodeUrl(kwd);
			
			if(kwd.length() != 0) {
				query += "&schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}

			long num = Long.parseLong(req.getParameter("seq"));
			
			NoticeDTO dto = new NoticeDTO();
			dto.setNum(num);
			dto.setTitle("글번호 " + num + "번 공지사항 상세.");
			
			// 줄바꿈 테스트
			String content = "상세 내용입니다.\n줄바꿈이 잘 되나요?\nDB 없이 테스트 중입니다.";
			dto.setContent(util.htmlSymbols(content)); 
			
			dto.setUserId("admin");
			dto.setUserName("관리자");
			dto.setRegDate("2025-05-22");
			dto.setHitCount(100);
			dto.setNotice(0);

			req.setAttribute("dto", dto);
			req.setAttribute("query", query);
			req.setAttribute("page", page);
			
			String path = "/WEB-INF/views/notice/view.jsp";
			req.getRequestDispatcher(path).forward(req, resp);
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendRedirect(cp + "/notice/list?" + query);
		}
	}
	
}