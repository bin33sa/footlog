package com.fl.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.fl.model.NoticeDTO;
import com.fl.util.MyUtil;

@WebServlet("/notice/*")
@MultipartConfig
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
		
		// URL 라우팅
		if (uri.indexOf("/notice/list") != -1) {
			list(req, resp);
		} else if (uri.indexOf("/notice/write") != -1) {
			if(req.getMethod().equalsIgnoreCase("GET")) {
				writeForm(req, resp);
			} else {
				writeSubmit(req, resp);
			}
		} else if (uri.indexOf("/notice/view") != -1) {
			view(req, resp);
		}
	}

	// 1. 리스트 (가짜 데이터 생성 부분 수정)
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

			// 일반 게시글 (가짜 데이터)
			for (int i = startNum; i >= endNum; i--) {
				NoticeDTO dto = new NoticeDTO();
				
				// [수정] DTO 변수명 변경 (num -> board_main_code)
				dto.setBoard_main_code((long)i); 
				
				// [수정] notice -> category (일반글은 카테고리 2번으로 가정)
				dto.setCategory(2); 
				
				dto.setTitle("페이징 테스트용 공지사항 제목입니다. (" + i + ")");
				
				// [수정] userId, userName -> member_id, member_name
				dto.setMember_id("admin");
				dto.setMember_name("관리자");
				
				// [수정] regDate -> created_at
				dto.setCreated_at("2025-05-22");
				
				// [수정] hitCount -> view_count
				dto.setView_count(i * 5);
				
				// [수정] 파일 유무 (NoticeDTO에 file_count가 있다면)
				dto.setFile_count(0); 
				
				list.add(dto);
			}

			// 상단 공지 (가짜 데이터)
			List<NoticeDTO> listNotice = new ArrayList<>();
			if(current_page == 1) {
				NoticeDTO topDto = new NoticeDTO();
				
				topDto.setBoard_main_code(100L);
				
				// [수정] 중요 공지는 카테고리 1번으로 가정
				topDto.setCategory(1); 
				
				topDto.setTitle("[필독] 커뮤니티 이용 규정 안내");
				topDto.setMember_id("admin");
				topDto.setMember_name("관리자");
				topDto.setCreated_at("2025-01-01");
				topDto.setView_count(9999);
				topDto.setFile_count(1); // 파일 있음 표시
				
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

	// 2. 글 쓰기 폼
	protected void writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("mode", "write");
		String path = "/WEB-INF/views/notice/write.jsp";
		req.getRequestDispatcher(path).forward(req, resp);
	}

	// 3. 글 저장 처리
	protected void writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cp = req.getContextPath();
		
		try {
			String title = req.getParameter("title");
			String content = req.getParameter("content");
			String notice = req.getParameter("notice"); // 체크박스 값
			
			// [수정] notice 체크 여부를 category 값으로 변환
			// 체크됨(중요공지): 1, 체크안됨(일반): 2
			int category = (notice != null) ? 1 : 2; 

			System.out.println("--- [공지사항 등록 시뮬레이션] ---");
			System.out.println("제목: " + title);
			System.out.println("내용: " + content);
			System.out.println("카테고리: " + category + " (1:중요, 2:일반)");
			
			// 실제로는 Service 호출 -> Mapper 호출 -> DB 저장 순서
			// NoticeDTO dto = new NoticeDTO();
			// dto.setTitle(title); ...
			// service.insertNotice(dto);
			
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

			// [수정] 파라미터 이름 seq -> board_main_code로 변경
			// (JSP에서도 링크 걸 때 &board_main_code=${dto.board_main_code} 로 보내야 함)
			String boardMainCodeStr = req.getParameter("board_main_code");
			if(boardMainCodeStr == null) {
				// 호환성을 위해 seq도 체크
				boardMainCodeStr = req.getParameter("seq");
			}
			long board_main_code = Long.parseLong(boardMainCodeStr);
			
			NoticeDTO dto = new NoticeDTO();
			dto.setBoard_main_code(board_main_code);
			dto.setTitle("글번호 " + board_main_code + "번 공지사항 상세.");
			
			String content = "상세 내용입니다.\n줄바꿈이 잘 되나요?\nDB 없이 테스트 중입니다.";
			dto.setContent(util.htmlSymbols(content)); 
			
			dto.setMember_id("admin");
			dto.setMember_name("관리자");
			dto.setCreated_at("2025-05-22");
			dto.setView_count(100);
			dto.setCategory(2); // 일반글
			dto.setFile_count(0);

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